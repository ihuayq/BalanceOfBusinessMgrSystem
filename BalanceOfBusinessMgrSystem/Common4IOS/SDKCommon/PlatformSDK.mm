//
//  PlatformSDK.cpp
//  Unity-iPhone
//
//  Created by loco on 14-8-26.
//
//

#include "PlatformSDK.h"
#import "JSONKit.h"
#import <AdSupport/AdSupport.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#include "Utils.h"
#include <json/json.h>
#import "HttpRequest.h"

using namespace LocoSDK;

CPlatformSDK *g_PlatformSDK = 0;

extern CPlatformSDK *createPlatformSDKInstance();

CPlatformSDK *CPlatformSDK::sharedPlatformSDK()
{
    if (g_PlatformSDK == 0) {
        g_PlatformSDK = createPlatformSDKInstance();
    }
    
    return g_PlatformSDK;
}

CPlatformSDK::CPlatformSDK()
{
    m_isInitialized = false;
    m_isLoginAfterInit = false;
    m_isLogined = false;
}

void CPlatformSDK::initSDK()
{
    NSString *appId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"app_id"];
    NSString *appKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"app_key"];
    NSString *gameId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"game_id"];
    NSString *gameKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"game_key"];
    NSString *orientation = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"orientation"];
    NSString *loginVerifyUrl = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"login_verify_url"];
    NSString *payRequestUrl = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"pay_request_url"];
    NSString *payNotifyUrl = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"pay_notify_url"];
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"app_name"];
    
    if (appId) {
        m_appId = std::string([appId UTF8String]);
    }
    if (appKey) {
        m_appKey = std::string([appKey UTF8String]);
    }
    if (gameId) {
        m_gameId = std::string([gameId UTF8String]);
    }
    if (gameKey) {
        m_gameKey = std::string([gameKey UTF8String]);
    }
    if (orientation) {
        m_orientation = std::string([orientation UTF8String]);
    }
    if (loginVerifyUrl) {
        m_loginVerifyUrl = std::string([loginVerifyUrl UTF8String]);
    }
    if (payRequestUrl) {
        m_payRequestUrl = std::string([payRequestUrl UTF8String]);
    }
    if (payNotifyUrl) {
        m_payNotifyUrl = std::string([payNotifyUrl UTF8String]);
    }
    if (appName) {
        m_appName = std::string([appName UTF8String]);
    }
}

void CPlatformSDK::login()
{
    if (m_isLogined) {
        return;
    }
    
    if (m_isInitialized) {
        doLogin();
    }
    else
    {
        m_isLoginAfterInit = true;
    }
}

void CPlatformSDK::destroySDK()
{
    if (g_PlatformSDK) {
        delete g_PlatformSDK;
        g_PlatformSDK = 0;
    }
}

const char *CPlatformSDK::getUserId()
{
    return "";
}

void CPlatformSDK::verifyLogin(const char *uin, const char *token)
{
    std::string strUrl = CPlatformSDK::sharedPlatformSDK()->getLoginVerifyUrl(uin, token);
    NSString *url = [NSString stringWithUTF8String:strUrl.c_str()];
    HttpRequest *request = [[HttpRequest alloc] initWithUrl:url andName:@"Verify Login"];
    request.handler = ^(BOOL bSuccess, NSData *data) {
        hideLoadingView();
        if (bSuccess) {
            NSString *buf = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [buf objectFromJSONString];
            NSNumber *code = [dic objectForKey:@"code"];
            if ([code intValue] != 1) {
                NSLog(@"Verify Login failed");
                
            }
            else
            {
                NSLog(@"Verify Login success");
                
                onLoginSuccess([buf UTF8String]);
            }
        }
        else
        {
            NSLog(@"Verify Login failed");
        }
    };
    
    NSString *msg = @"登陆验证...";
    showLoadingView([msg UTF8String]);
    [request startRequestWithCompletionHandler];
}

void CPlatformSDK::buyProduct(const char *unitId, const char *unitName, int count, int total, const char *callBackInfo)
{
    if (!m_isLogined) {
        return;
    }

    std::string strUrl = CPlatformSDK::sharedPlatformSDK()->getPayRequestUrl(unitId, count, total, callBackInfo);
    NSString *url = [NSString stringWithUTF8String:strUrl.c_str()];
    HttpRequest *request = [[HttpRequest alloc] initWithUrl:url andName:@"Request Pay"];
    request.handler = ^(BOOL bSuccess, NSData *data) {
        hideLoadingView();
        if (bSuccess) {
            NSString *buf = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [buf objectFromJSONString];
            NSString *order = [dic objectForKey:@"order"];
            if (order) {
                NSLog(@"Request Pay success");
                
                doPay([order UTF8String], unitId, unitName, count, total, "");
            }
            else
            {
                NSLog(@"Request Pay failed, parse error");
            }
        }
        else
        {
            NSLog(@"Request Pay failed");
        }
    };
    
    NSString *msg = @"请求订单...";
    showLoadingView([msg UTF8String]);
    [request startRequestWithCompletionHandler];
}

void CPlatformSDK::setListener(CPlatformListener *listener)
{
    m_listener = listener;
}

void CPlatformSDK::onInitSuccess()
{
    m_isInitialized = true;
    
    if (m_isLoginAfterInit) {
        doLogin();
    }
}

void CPlatformSDK::onLoginSuccess(const char *jsonStr)
{
    std::string buf = std::string(jsonStr);
    Json::Reader reader;
    Json::Value reqData;
    if (reader.parse(buf, reqData))
    {
        Json::Value tmpObj;
        tmpObj["channel"] = getChannelName();
        tmpObj["appid"] = m_appId;
        tmpObj["platformid"] = reqData["platformid"];
        std::string name = reqData["name"].asString();
        tmpObj["name"] = base64Encode(name);
        tmpObj["avatar"] = "";
        tmpObj["sex"] = "";
        tmpObj["area"] = "";
        tmpObj["nick"] = "";
        tmpObj["logintime"] = reqData["logintime"];
        tmpObj["cpinfo"] = "";
        tmpObj["sign"] = reqData["sign"];
        
        std::string strTmpObj = tmpObj.toStyledString();
        std::string session = base64Encode(strTmpObj);
        
        m_userInfo.channelID = std::string(getChannelName());
        m_userInfo.channelUserID = reqData["platformid"].asString();
        m_userInfo.channelUserName = name;
        m_userInfo.session = session;
        m_userInfo.gameKey = m_gameKey;
        m_userInfo.gameId = m_gameId;
        
        m_isLogined = true;
        
        if (m_listener) {
            m_listener->onLoginSuccess(&m_userInfo);
        }
    }
    else
    {
        NSLog(@"json parse error");
    }
}

void CPlatformSDK::onLoginFailed()
{
    if (m_listener) {
        m_listener->onLoginFailed();
    }
}

void CPlatformSDK::onPaySuccess(const char *order)
{
    if (m_listener) {
        m_listener->onPaySuccess(order);
    }
}

void CPlatformSDK::onPayFailed()
{
    if (m_listener) {
        m_listener->onPayFailed();
    }
}

void CPlatformSDK::onLogout()
{
    m_isLogined = false;
    
    if (m_listener) {
        m_listener->onLogout();
    }
}

std::string CPlatformSDK::getLoginVerifyUrl(const char *uin, const char *access_token)
{
    std::string url;
    std::string sign = std::string(getChannelName()) + m_appId + m_gameId + std::string(access_token) + m_gameKey;
    std::string md5sign = getMD5(sign.c_str());
    url = m_loginVerifyUrl + "?channel=" + std::string(getChannelName()) + "&appid=" + m_appId + "&gameid=" + m_gameId + "&uid=" + std::string(uin) + "&name=&sessionid=" + std::string(access_token) + "&extra=&extra2=&sign=" + md5sign;
    
    return url;
}

std::string CPlatformSDK::getPayRequestUrl(const char *unitId, int count, int total, const char *callBackInfo)
{
    std::string url;
    std::string sign = std::string(getChannelName()) + m_appId + m_gameId + m_userInfo.channelUserID + std::string(unitId) + m_gameKey;
    std::string md5sign = getMD5(sign.c_str());
    std::string cpinfo = std::string(callBackInfo);
    std::string base64cpinfo = base64Encode(cpinfo);
    std::string urlencodecpinfo = UrlEncode(base64cpinfo);
    char buf[20];
    sprintf(buf, "%d", count);
    std::string strCount = std::string(buf);
    sprintf(buf, "%d", total);
    std::string strTotal = std::string(buf);
    url = m_payRequestUrl + "?channel=" + std::string(getChannelName()) + "&appid=" + m_appId + "&gameid=" + m_gameId + "&platformid=" + m_userInfo.channelUserID + "&productid=" + std::string(unitId) + "&productcount=" + strCount + "&originalmoney=" + strTotal + "&money=" + strTotal + "&cpinfo=" + urlencodecpinfo + "&sign=" + md5sign;
    
    return url;
}

bool CPlatformSDK::isSupportFunction(const char *funcName)
{
    if (strcmp(funcName, "logout") == 0) {
        return isSupportLogout();
    }
    else if (strcmp(funcName, "switchAccount") == 0)
    {
        return isSupportSwitchAccount();
    }
    else if (strcmp(funcName, "enterPlatform") == 0)
    {
        return isSupportEnterPlatform();
    }
    else
    {
        return false;
    }
}







