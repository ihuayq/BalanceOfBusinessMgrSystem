//
//  SysInfo.h
//  ipaycard
//
//  Created by han bing on 13-1-10.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysInfo : NSObject{
    NSString *curNavImageName;
    NSString *status;   //设备是否插拔状态
    NSString *srRegister;   //设备注册状态
    NSString *swipeReaderId;
    NSMutableString *encode;
    NSDictionary *pushData;
    NSNumber *srDT;             //刷卡步骤
    NSNumber *dataStep;  //加密步骤
    NSString *lastNotifationName;
    NSString *bankRandom;
    NSNumber *tryTimes; //与刷卡器通讯次数
}
@property (nonatomic, retain) NSString *curNavImageName;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *swipeReaderId;
@property (nonatomic, retain) NSMutableString *encode;
@property (nonatomic, retain) NSMutableString *randomStr;
@property (nonatomic, retain) NSString *srRegister;
@property (nonatomic, retain) NSDictionary *pushData;
@property (nonatomic, retain) NSNumber *srDT;
@property (nonatomic, retain) NSString *lastNotifationName;
@property (nonatomic, retain) NSString *bankRandom;
@property (nonatomic, retain) NSNumber *dataStep;
@property (nonatomic, retain) NSNumber *tryTimes;

+(SysInfo *) newInstence;
@end
