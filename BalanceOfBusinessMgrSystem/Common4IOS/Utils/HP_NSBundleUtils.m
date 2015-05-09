//
//  HP_NSBundleUtils.m
//  youyouapp
//
//  Created by Yi Xu on 13-1-14.
//  Copyright (c) 2013年 CuiYiLong. All rights reserved.
//

#import "HP_NSBundleUtils.h"

@implementation HP_NSBundleUtils

//获得MainBundle infoDictionary
+(NSDictionary *) getMainBundleInfoDictionary{
    return [[NSBundle mainBundle] infoDictionary];
}

//获得APP名称
+(NSString *) getMainBundleAPPName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

//获得APP版本号
+(NSString *) getMainBundleAPPVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//获得APP BUILD版本号
+(NSString *) getMainBundleBundleVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end
