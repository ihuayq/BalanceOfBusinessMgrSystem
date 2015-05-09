//
//  MobileRechargeOrder.h
//  ipaycard
//
//  Created by han on 13-1-4.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileRechargeOrder : NSObject{
    NSDictionary *prodectDict;
    NSDictionary *confirmDict;
    NSDictionary *detailDict;
    NSDictionary *phoneNum;
}
@property (nonatomic, retain) NSDictionary *prodectDict;
@property (nonatomic, retain) NSDictionary *confirmDict;
@property (nonatomic, retain) NSDictionary *detailDict;
@property (nonatomic, retain) NSDictionary *phoneNum;

@property (nonatomic, strong) NSString *mobileNum;
@property (nonatomic, strong) NSString *provid;
@property (nonatomic, strong) NSString *operid;
@property (nonatomic, strong) NSString *phonetypeid;

@property (nonatomic, strong) NSString *commface;
@property (nonatomic, strong) NSString *facestring;

@property (nonatomic, strong) NSString *valueStr;

@property (nonatomic, strong) NSString *productID;

@property (nonatomic, strong) NSString *reqId;

@property (nonatomic, strong) NSString *provname;
@property (nonatomic, strong) NSString *opertype;

@property (nonatomic, strong) NSString *orderDate; //交易时间


+(MobileRechargeOrder *) newInstence;
- (void)initMobileData;


@end
