//
//  SysInfo.m
//  ipaycard
//
//  Created by han bing on 13-1-10.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "SysInfo.h"

@implementation SysInfo
static SysInfo *instence;
@synthesize curNavImageName;
@synthesize status;
@synthesize swipeReaderId;
@synthesize encode;
@synthesize randomStr;
@synthesize srRegister;
@synthesize pushData;
@synthesize srDT;
@synthesize lastNotifationName;
@synthesize bankRandom;
@synthesize dataStep;
@synthesize tryTimes;

+(SysInfo *) newInstence{
    @synchronized(self){
        if (instence == nil) {
            instence = [[SysInfo alloc] init];
        }
    }
    return instence;
}

+(id) allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (instence == nil) {
            instence = [super allocWithZone:zone];
            return instence;
        }
    }
    return nil;
}

-(id) copyWithZone:(NSZone *)zone{
    return self;
}

@end
