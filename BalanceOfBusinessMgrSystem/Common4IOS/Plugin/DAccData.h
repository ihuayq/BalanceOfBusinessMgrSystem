//
//  DAccData.h
//  ipaycard
//
//  Created by RenLongfei on 14-3-10.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "DDataModal.h"

@interface DAccData : DDataModal

@property (nonatomic, strong) NSString *accNum;//银行卡号
@property (nonatomic, strong) NSString *accName;//持卡人名字

@property (nonatomic, strong) NSString *accBalance;//余额

@property (nonatomic, strong) NSString *accTransValue;//转账金额

@property (nonatomic, strong) NSString *accTransReqId;//转账订单号

@property (nonatomic, strong) NSString *desc;//转账备注

@property (nonatomic, strong) NSString *accTNMobile;//提醒手机号

//充值
@property (nonatomic, strong) NSString *accChargeValue;//充值金额

@property (nonatomic, strong) NSString *ordNum; 

//体现
@property (nonatomic, strong) NSString *bankCode;//银行编码
@property (nonatomic, strong) NSString *branchName;//户行名称
@property (nonatomic, strong) NSString *trxAmount;//提现金额
@property (nonatomic, strong) NSString *settlePwd;//提现密码

@property (nonatomic, strong) NSString *bankCredType;//卡类型


@property (nonatomic, strong) NSString *casOrdId;//提现订单号
@property (nonatomic, strong) NSString *ordStatus;//提现状态

@property (nonatomic, strong) NSString *bankNet;//支行网点

@property (nonatomic, strong) NSString *dealtime;//交易时间

@property (nonatomic, strong) NSString *provinceStr;
@property (nonatomic, strong) NSString *cityStr;


+(DDataModal *) newInstance;

- (void)initData;
@end
