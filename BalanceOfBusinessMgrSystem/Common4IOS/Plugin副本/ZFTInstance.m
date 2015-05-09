//
//  ZFTInstance.m
//  ipaycard
//
//  Created by fei on 13-8-19.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "ZFTInstance.h"

@implementation ZFTInstance
@synthesize zft;

static ZFTInstance *single =nil;

- (id) init{
    
    if (self = [super init]) {
        
    }
    
    return self;
}

+(ZFTInstance *)newInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single  = [[ZFTInstance alloc]init];
        single.zft = [[ZftQiposLib alloc]init];
    });
    return single;
}


@end
