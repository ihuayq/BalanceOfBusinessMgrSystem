//
//  DJYCreditCardData.h
//  ipaycard
//
//  Created by Davidsph on 4/19/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJYCreditCardData : NSObject

@property (nonatomic, retain) NSDictionary *confirmDict;

@property(nonatomic,strong)NSString *bankName; //还款银行名称


@property(nonatomic,strong)NSString *bankCode; //银行代码


@property(nonatomic,strong)NSString *payMentMoney; //还款金额

@property(nonatomic,strong)NSString *cardNum; //卡号

@property(nonatomic,strong)NSString *fee; //还款手续费


@property(nonatomic,strong)NSString *totalMoney; //总的还款金额 

@property(nonatomic,strong)NSString *provinceName; //信用卡所在省份 

@property(nonatomic,strong)NSString *message; //还款的一些信息



@property(nonatomic,strong)NSString *productName; //产品名称


@property(nonatomic,strong)NSString *productId; //产品ID

//详情
@property(nonatomic,strong)NSString *orderdate; //交易日期

@property(nonatomic,strong)NSString *serialno; //支付通交易编号


@property(nonatomic,strong)NSString *payDateStr; //支付通交易编号

@property  (nonatomic, strong)NSString *unitMinAmt;//单笔最小限额

@property (nonatomic, strong) NSString  *unitMaxAmt;//单笔最大限额

//该类的数据是单例模式

+ (DJYCreditCardData *) newInstance;


@end
