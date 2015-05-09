//
//  ZFTInstance.h
//  ipaycard
//
//  Created by fei on 13-8-19.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZftQiposLib.h"

@interface ZFTInstance : NSObject

@property (nonatomic, strong) ZftQiposLib *zft;

+(ZFTInstance *)newInstance;


@end
