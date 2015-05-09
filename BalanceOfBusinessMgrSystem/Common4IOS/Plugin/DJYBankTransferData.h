//
//  DJYBankTransferData.h
//  ipaycard
//
//  Created by Davidsph on 4/17/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJYBankTransferData : NSObject

@property(nonatomic,strong)NSString *bankName; //银行名称

@property(nonatomic,strong)NSString *bankCode; //银行代码

@property(nonatomic,strong)NSString *bankIcon; //银行logo 

@property(nonatomic,strong)NSString *bankHotPhone; //银行服务热线 

@property(nonatomic,strong)NSString *bankName_belong;//开户行名称 

@property(nonatomic,strong)NSString *bankProvince; //开户行所在省份

@property(nonatomic,strong)NSString *bankCity; //开户行所在城市

//@property(nonatomic,strong)NSString *handingFee; //手续费

@property(nonatomic,strong)NSString *handingFeeRate; //手续费率

@property(nonatomic,strong)NSString *moneyArriveTime; //到账时间

//@property(nonatomic,strong)NSString *realTransferMoney; //实际支付金额 = 交易金额 + 手续费


@property(nonatomic,strong)NSString *transferMoney; //计划 转账金额 即交易金额 

@property(nonatomic,strong)NSString *name; //收款人姓名

@property(nonatomic,strong)NSString *cardNum; //收款人银行卡号

@property(nonatomic,strong)NSString *txamt; //收款人银行卡号

//新增的业务
@property(nonatomic,strong)NSString *payFee; //付款手续费

@property(nonatomic,strong)NSString *payAmt; //付款金额

@property(nonatomic,strong)NSString *payRealAmt; //实际 付款金额

@property(nonatomic,strong)NSString *receiptAmt; //收款金额

@property(nonatomic,strong)NSString *receiptFee;//收款手续费

@property(nonatomic,strong)NSString *receiptRealAmt; //实际收款金额

@property(nonatomic,strong)NSString *orderDate; //时间

@property(nonatomic,strong)NSString *serialNo; //时间

@property  (nonatomic, strong)NSString *unitMinAmt;//单笔最小限额

@property (nonatomic, strong) NSString  *unitMaxAmt;//单笔最大限额

//实时转账
@property (nonatomic, strong) NSString  *phoneInfo;//手机信息

@property (nonatomic, strong) NSString  *transinMobile;//手机信息

@property (nonatomic, strong) NSString  *readme;//手机信息

@property (nonatomic, strong) NSString  *orderid;//手机信息

//该类的数据是单例模式

+ (DJYBankTransferData *) newInstance;


@end
