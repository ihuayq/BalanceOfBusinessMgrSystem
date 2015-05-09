//
//  HP_NSDataUtils.m
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import "HP_NSDataUtils.h"

@implementation HP_NSDataUtils

+(NSInteger) getKBFromData:(NSData *) data{
    return data.length/1024;
}

+(NSInteger) getMBFromData:(NSData *) data{
    return data.length/1024/1024;
}

+(NSInteger) getGBFromData:(NSData *) data{
    return data.length/1024/1024/1024;
}

@end
