//
//  ZFTSwiper.h
//  ZFTSwiper
//
//  Created by JinzhuLin on 13-4-16.
//  Copyright (c) 2013年 zft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwiperDelegate.h"




@interface ZFTSwiper :NSObject<ISwiperInterface>

- (id)init;

- (void)dealloc;
//获取版本号
+ (NSString*)getSDKVersion;




@end

