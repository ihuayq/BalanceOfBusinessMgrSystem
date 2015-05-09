//
//  TradeDetail.m
//  ipaycard
//
//  Created by han bing on 13-1-17.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "TradeDetail.h"

@implementation TradeDetail
static TradeDetail *instence;
@synthesize tdDetail;

+(TradeDetail *) newInstence{
    @synchronized(self){
        if (instence == nil) {
            instence = [[TradeDetail alloc] init];
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
