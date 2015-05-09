//
//  PayInfo.m
//  ipaycard
//
//  Created by han bing on 13-1-17.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "PayInfo.h"

@implementation PayInfo
static PayInfo *instence;
@synthesize payDetail;
@synthesize endPay;

@synthesize transDict;
@synthesize addOne;

+(PayInfo *) newInstence{
    @synchronized(self){
        if (instence == nil) {
            instence = [[PayInfo alloc] init];
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
