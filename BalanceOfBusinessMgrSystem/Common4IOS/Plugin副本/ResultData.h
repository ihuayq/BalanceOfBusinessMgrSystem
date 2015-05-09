//
//  ResultData.h
//  ipaycard
//
//  Created by fei on 13-5-22.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultData : NSObject

@property(nonatomic,strong) NSString *bankCode; //银行代码

@property(nonatomic,strong) NSString *cardNum; //卡号

@property(nonatomic,strong) NSString *balance; //余额

@property(nonatomic,strong) NSString *bankName; //银行名称

+ (ResultData *) newInstance;

@end
