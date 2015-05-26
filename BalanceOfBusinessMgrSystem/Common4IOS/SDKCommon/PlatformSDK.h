//
//  PlatformSDK.h
//  Unity-iPhone
//
//  Created by loco on 14-8-26.
//
//

#ifndef __Unity_iPhone__PlatformSDK__
#define __Unity_iPhone__PlatformSDK__

#include <iostream>

struct PlatformUserInfo
{
    std::string channelID;      // 渠道标识
    std::string channelUserID;  // 平台id
    std::string channelUserName;    // 平台name
    std::string session;        // SDK相关的令牌
    std::string gameKey;        // 游戏key
    std::string gameId;         // 游戏id
};

class CPlatformListener {
    
public:
    
    virtual void onLoginSuccess(PlatformUserInfo *userInfo) {}
    virtual void onLoginFailed() {}
    virtual void onLogout() {}
    virtual void onPaySuccess(const char * order) {}
    virtual void onPayFailed() {}
};

class CPlatformSDK {
    
public:
    
    CPlatformSDK();
    ~CPlatformSDK() {}
    
public:
    
    static CPlatformSDK * sharedPlatformSDK();

    virtual void beforeInit() {}
    virtual void initSDK();
    virtual void destroySDK();
    virtual void showFloatToolBar() {}
    virtual void hideFloatToolBar() {}
    void login();
    virtual const char *getUserId();
    virtual void onPause() {}
    virtual void onResume() {}
    
    void verifyLogin(const char *uin, const char *token);
    
    /// 支付接口
    // unitId 虚拟货币id
    // unitName 虚拟货币名称
    // count 购买虚拟货币数量
    // total 定额支付总金额，单位为分
    // callBackInfo 开发者自定义参数
    void buyProduct(const char *unitId, const char *unitName, int count, int total, const char *callBackInfo);
    // 一些渠道充值需要传serverId
    void setServerId(const char *serverId) { m_serverId = std::string(serverId); }
    
    virtual void handleURL(const char* url) {}
    
    void setListener(CPlatformListener *listener);
    void onInitSuccess();
    void onLoginSuccess(const char *jsonStr);
    void onLoginFailed();
    void onPaySuccess(const char *order);
    void onPayFailed();
    void onLogout();
    
    bool isLogined() { return m_isLogined; }
    
    bool isSupportFunction(const char *funcName);
    virtual bool isSupportLogout() { return false; }
    virtual bool isSupportSwitchAccount() { return false; }
    virtual bool isSupportEnterPlatform() { return false; }
    virtual void enterPlatform() {}
    virtual void logout() {}
    virtual void switchPlatform() {}
    
    virtual const char * getChannelName() { return ""; }
    
    std::string getAppId()
    {
        return m_appId;
    }
    
    std::string getAppKey()
    {
        return m_appKey;
    }
    
    std::string getGameId()
    {
        return m_gameId;
    }
    
    std::string getGameKey()
    {
        return m_gameKey;
    }
    
    bool isLandscape()
    {
        return m_orientation == "landscape";
    }
    
    std::string getLoginVerifyUrl(const char *uin, const char *access_token);
    
    std::string getPayRequestUrl(const char *unitId, int count, int total, const char *callBackInfo);
    
    std::string getPayNotifyUrl()
    {
        return m_payNotifyUrl;
    }
    
    std::string getAppName()
    {
        return m_appName;
    }
    
    std::string getServerId()
    {
        return m_serverId;
    }
    
protected:
    
    virtual void doLogin() {}
    virtual void doPay(const char *order, const char *unitId, const char *unitName, int count, int total, const char *callBackInfo) {}
    
private:
    
    std::string m_appId;
    std::string m_appKey;
    std::string m_gameId;
    std::string m_gameKey;
    std::string m_orientation;
    std::string m_loginVerifyUrl;
    std::string m_payRequestUrl;
    std::string m_payNotifyUrl;
    std::string m_appName;
    std::string m_serverId;
    
    CPlatformListener *m_listener;
    
    PlatformUserInfo m_userInfo;
    
    bool m_isInitialized;
    bool m_isLoginAfterInit;
    bool m_isLogined;
};

#endif /* defined(__Unity_iPhone__PlatformSDK__) */
