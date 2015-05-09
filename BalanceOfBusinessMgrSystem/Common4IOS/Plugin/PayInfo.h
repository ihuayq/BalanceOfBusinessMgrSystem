//
//  PayInfo.h
//  ipaycard
//
//  Created by han bing on 13-1-17.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayInfo : NSObject{
    NSMutableDictionary *payDetail;
    NSDictionary *endPay;
}

@property (nonatomic, retain) NSMutableDictionary *payDetail;
@property (nonatomic, retain) NSDictionary *endPay;
@property (nonatomic, retain) NSDictionary *transDict;
@property (nonatomic, retain) NSDictionary *addOne;

+(PayInfo *) newInstence;
@end
