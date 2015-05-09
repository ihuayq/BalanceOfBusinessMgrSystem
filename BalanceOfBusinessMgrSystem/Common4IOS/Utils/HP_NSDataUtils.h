//
//  HP_NSDataUtils.h
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_NSDataUtils : NSObject

//获得NSData对象的大小（单位：KB）
+(NSInteger) getKBFromData:(NSData *) data;

//获得NSData对象的大小（单位：MB）
+(NSInteger) getMBFromData:(NSData *) data;

//获得NSData对象的大小（单位：GB）
+(NSInteger) getGBFromData:(NSData *) data;

@end
