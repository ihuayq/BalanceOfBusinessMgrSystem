//
//  TrainData.h
//  ipaycard
//
//  Created by RenLongfei on 13-12-24.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainData : NSObject

@property (nonatomic, strong)  NSString *train_queryid;//查询id
@property (nonatomic, strong)  NSString *train_no;//车次号
@property (nonatomic, strong)  NSString *train_id;//车次id
@property (nonatomic, strong)  NSString *order_id;//流水id

@property (nonatomic, strong)  NSString *fromStation;
@property (nonatomic, strong)  NSString *toStation;

@property (nonatomic, strong)  NSString *from_info;
@property (nonatomic, strong)  NSString *to_Info;
@property (nonatomic, strong)  NSString *spendtime;//所费时间
@property (nonatomic, strong)  NSString *dateStr;//订票日期
@property (nonatomic, strong)  NSString *startTime;//出发时间

@property (nonatomic, strong)  NSString *unitPrice;//单价
@property (nonatomic, strong)  NSString *trainPrice;//车票总价格
@property (nonatomic, strong)  NSString *poundage;//手续费

@property (nonatomic, strong)  NSArray *train_array;//车次类型
@property (nonatomic, strong)  NSArray *seat_array;//座位类型

@property (nonatomic, strong)  NSString *totalAmountString;
@property (nonatomic, strong)  NSString *jsonString;
@property (nonatomic, strong)  NSString *receiveNumString;

@property (nonatomic, strong)  NSMutableArray  *passengerArr;//购票的人数
@property (nonatomic, strong)  NSString  *num;

@property (nonatomic, strong)  NSString *trainReqId;//订单号
@property (nonatomic, strong)  NSString *paytime;//交易时间

@property (nonatomic, strong)  NSString *billTitle;//抬头
@property (nonatomic, strong)  NSString *detailAddress;//详细地址
@property (nonatomic, strong)  NSString *billInfo;//信息

@property (nonatomic, strong)  NSString *phoneInfo;

@property BOOL withBill;

+ (TrainData *) newInstance;
- (void)reset;

@end
