//
//  HP_NSBundleUtils.h
//  youyouapp
//
//  Created by Yi Xu on 13-1-14.
//  Copyright (c) 2013年 CuiYiLong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_NSBundleUtils : NSObject

//获得MainBundle infoDictionary
+(NSDictionary *) getMainBundleInfoDictionary ;

//获得APP名称
+(NSString *) getMainBundleAPPName ;

//获得APP版本号
+(NSString *) getMainBundleAPPVersion;

//获得APP BUILD版本号
+(NSString *) getMainBundleBundleVersion;

@end
