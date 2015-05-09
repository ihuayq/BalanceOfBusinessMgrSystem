//
//  HP_NetWorkUtils.h
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_NetWorkUtils : NSObject

//是否有网络
+(BOOL)isNetWorkEnable;

//是否是wifi
+(BOOL)isWifi;

//是否是3G
+(BOOL)is3G;

@end
