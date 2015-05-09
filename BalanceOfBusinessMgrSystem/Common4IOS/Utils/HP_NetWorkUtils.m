//
//  HP_NetWorkUtils.m
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import "HP_NetWorkUtils.h"
#import "HP_Reachability.h"

@implementation HP_NetWorkUtils


+(BOOL)isWifi {
	return ([[HP_Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == ReachableViaWiFi);
}

+(BOOL)is3G {
	return ([[HP_Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN);
}

+(BOOL)isNetWorkEnable{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
