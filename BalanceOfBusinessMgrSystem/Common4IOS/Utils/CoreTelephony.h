//
//  CoreTelephony.h
//  AllBelieve
//
//  Created by myMac on 14-8-27.
//  Copyright (c) 2014年 aaa. All rights reserved.
//




struct CTServerConnection
{
    int a;
    int b;
    CFMachPortRef myport;
    int c;
    int d;
    int e;
    int f;
    int g;
    int h;
    int i;
};

struct CTResult
{
    int flag;
    int a;
};

struct CTServerConnection * _CTServerConnectionCreate(CFAllocatorRef, void *, int *);

void _CTServerConnectionCopyMobileIdentity(struct CTResult *, struct CTServerConnection *, NSString **);

#include <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CoreTelephonyDefines.h>

@interface CoreTelephony : NSObject


//+(NSString*) getDeviceIMSI;
//+(NSString*) getPhoneCodeByCT;

@end
