//
//  Created by locojoy on 14-3-4.
//  Copyright (c) 2014年 locojoy. All rights reserved.
//

#include <stdio.h>
#include <stdarg.h>
#include "Utils.h"
#include <openssl/md5.h>
#include <openssl/evp.h>
#include "sys/socket.h"
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/sysctl.h>
#include <mach/mach.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
#include "PlatformSDK.h"

static const int kMaxLogLen = 16*1024;

#define kTag_MainScreenView        (2002)
#define kTag_ActivityIndicatoriew  (2001)
#define kTag_PromptView            (2000)


void LJLog(const char * pszFormat, ...)
{
    printf("LeDongSDK: ");
    char szBuf[kMaxLogLen];
    
    va_list ap;
    va_start(ap, pszFormat);
    vsprintf(szBuf, pszFormat, ap);
    va_end(ap);
    printf("%s", szBuf);
    printf("\n");
}

unsigned char ToHex(unsigned char x)
{
    return x > 9 ? x + 55 : x + 48;
}

std::string getBundleId()
{
    NSString* strAppId = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey];
    std::string appId = std::string([strAppId UTF8String]);
    return appId;
}

std::string UrlEncode(const std::string& str)
{
    std::string strTemp = "";
    
    size_t length = str.length();
    
    for (size_t i = 0; i < length; i++)
    {
        if (isalnum((unsigned char)str[i])
            || (str[i] == '-')
            || (str[i] == '_')
            || (str[i] == '.')
            || (str[i] == '~')
            )
        {
            strTemp += str[i];
        }
        else if (str[i] == ' ')
        {
            strTemp += "+";
        }
        else
        {
            strTemp += '%';
            strTemp += ToHex((unsigned char)str[i] >> 4);
            strTemp += ToHex((unsigned char)str[i] % 16);
        }
    }
    
    return strTemp;
}

std::string getMD5(const char *buf)
{
    std::string strMD5 = "";
    
    if (buf)
    {
        size_t len = strlen(buf);
        
        unsigned char result[MD5_DIGEST_LENGTH];
    
        MD5((const unsigned char *)buf, len, result);
    
        char md5[33];
        
        for (int i = 0; i < 32; i++)
        {
            if (i % 2 == 0)
            {
                md5[i] = tolower(ToHex((result[i / 2] >> 4) & 0xf));
            }
            else
            {
                md5[i] = tolower(ToHex(result[i / 2] & 0xf));
            }
        }
        md5[32] = 0;
        strMD5 = md5;
    }
    
    std::transform(strMD5.begin(), strMD5.end(), strMD5.begin(), tolower);
    
    return strMD5;
}

std::string base64Encode(std::string& str)
{
    std::string outStr = "";
    
    int len = str.length();
    
    if (len > 0)
    {
        char *p = new char[len * 2];
        
        if (p)
        {
            memset(p, 0, len * 2);
            EVP_EncodeBlock((unsigned char *)p, (const unsigned char *)str.c_str(), len);
            outStr = std::string(p);
            delete [] p;
        }
    }
    
    return outStr;
}

std::string base64Decode(std::string& str)
{
    std::string outStr = "";
    
    int len = str.length();
    
    if (len > 0)
    {
        char *p = new char[len];
        
        if (p)
        {
            memset(p, 0, len);
            EVP_DecodeBlock((unsigned char *)p, (const unsigned char *)str.c_str(), len);
            outStr = std::string(p);
            delete [] p;
        }
    }
    
    return outStr;
}

std::string getIPAddress()
{
    std::string outStr = "";
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - return 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iphone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    //
                    outStr = inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr);
                    break;
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    return outStr;
}

std::string getMacAddress()
{
    std::string outStr = "";
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending)
    {
        // iOS6版本以上用IDFA
		NSUUID* adID =  [[ASIdentifierManager sharedManager] advertisingIdentifier];
		outStr = [[adID UUIDString] cStringUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        int					mib[6] = {0};
        size_t				len  = 0;
        char				*buf = NULL;
        unsigned char		*ptr = NULL;
        struct if_msghdr	*ifm = NULL;
        struct sockaddr_dl	*sdl = NULL;
        
        mib[0] = CTL_NET;
        mib[1] = AF_ROUTE;
        mib[2] = 0;
        mib[3] = AF_LINK;
        mib[4] = NET_RT_IFLIST;
        
        if ((mib[5] = if_nametoindex("en0")) == 0)
        {
            printf("Error: if_nametoindex error\n");
            return "";
        }
        
        if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
        {
            printf("Error: sysctl, take 1\n");
            return "";
        }
        
        if ((buf = new char[len]) == NULL)
        {
            printf("Could not allocate memory. error!\n");
            return "";
        }
        
        if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
        {
            printf("Error: sysctl, take 2");
            return "";
        }
        
        ifm = (struct if_msghdr *)buf;
        sdl = (struct sockaddr_dl *)(ifm + 1);
        ptr = (unsigned char *)LLADDR(sdl);
        
        char szMac[64] = {0};
        sprintf(szMac,"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5));
        delete [] buf;
        
        outStr = szMac;
    }
    
    return outStr;
}

std::string parseParamFromUrl(const char *url, const char *param)
{
    std::string outStr = "";
    if (url && param) {
        std::string inStr = std::string(url);
        std::string tofind= std::string(param) + std::string("=");
        
        size_t pos= inStr.find(tofind);
        if (pos != std::string::npos)
        {
            size_t posEnd = inStr.find("&", pos);
            if (posEnd != std::string::npos) {
                outStr = inStr.substr(pos + tofind.length(), posEnd - pos - tofind.length());
            }
            else
            {
                outStr = inStr.substr(pos + tofind.length(), inStr.length() - pos - tofind.length());
            }
        }
    }
    
    return outStr;
}

void showLoadingView(const char *msg)
{
    UIView * rootView = [[[[UIApplication sharedApplication] keyWindow] rootViewController] view];
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    bool isLandscapeMode = CPlatformSDK::sharedPlatformSDK()->isLandscape();
    if (isLandscapeMode) {
        CGRect rc = CGRectMake(rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
        rect = rc;
    }
    
    if (nil == [rootView viewWithTag:kTag_MainScreenView])
    {
        UIView* mainScreenView = [[UIView alloc] initWithFrame:rect];
        mainScreenView.backgroundColor = [UIColor blackColor];
        mainScreenView.alpha = 0.5;
        mainScreenView.tag = kTag_MainScreenView;
        
        [rootView addSubview:mainScreenView];
        [mainScreenView release];
    }
    if (nil == [rootView viewWithTag:kTag_PromptView])
    {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.width/12)];
        label.tag = kTag_PromptView;
        label.alpha = 0.8;
        label.layer.cornerRadius = 10;
        label.backgroundColor = [UIColor blackColor];
        label.center = CGPointMake(rect.size.width/2, rect.size.height/2);
        
        label.text =  [NSString stringWithUTF8String: msg];
        label.textAlignment   = NSTextAlignmentCenter;
        label.textColor       = [UIColor whiteColor];
        
        [rootView addSubview:label];
        [label release];
    }
    if (nil == [rootView viewWithTag:kTag_ActivityIndicatoriew])
    {
        UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicator.center = CGPointMake(rect.size.width/2, rect.size.height/2-indicator.frame.size.height*5/4);
        indicator.tag = kTag_ActivityIndicatoriew;
        [indicator startAnimating];
        
        [rootView addSubview:indicator];
        [indicator release];
        
    }
}

void hideLoadingView()
{
    UIView * rootView = [[[[UIApplication sharedApplication] keyWindow] rootViewController] view];
    
    UIView* mainScreenView = [rootView viewWithTag:kTag_MainScreenView];
    if (mainScreenView != nil) {
        [mainScreenView removeFromSuperview];
    }
    
    UIActivityIndicatorView* indicator = (UIActivityIndicatorView*)[rootView viewWithTag:kTag_ActivityIndicatoriew];
    if (indicator != nil) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
    }
    
    UIView* label = [rootView viewWithTag:kTag_PromptView];
    if (label != nil) {
        [label removeFromSuperview];
    }
}

