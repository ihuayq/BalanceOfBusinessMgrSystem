//
//  CoreTelephony.m
//  AllBelieve
//
//  Created by myMac on 14-8-27.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#include <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CoreTelephonyDefines.h>

#import "CoreTelephony.h"

@implementation CoreTelephony

@end




struct CTServerConnection *sc=NULL;
struct CTResult result;

void callback() { }

//int main()
//{
//    sc = _CTServerConnectionCreate(kCFAllocatorDefault, callback, NULL);
//    
//    NSString *imei;
//    _CTServerConnectionCopyMobileIdentity(&result, sc, &imei);
//    
//    NSLog (@"zhiwei's IMEI is %@", imei);
//    
//    return 0;
//}


//IMSI

// 需要 CoreTelephony framework
// 在文件开头加入
//extern NSString* CTSIMSupportCopyMobileSubscriberIdentity();


//+ (NSString*) getDeviceIMSI
//{
//    return @"fff";
//    //return CTSIMSupportCopyMobileSubscriberIdentity();
//}



//本机电话号码

// 需要 CoreTelephony framework
// 在文件开头加入
//extern NSString* CTSettingCopyMyPhoneNumber();
//+ (NSString*) getPhoneCodeByCT
//{
//    return @"fff";
//   // return CTSettingCopyMyPhoneNumber();
//}


