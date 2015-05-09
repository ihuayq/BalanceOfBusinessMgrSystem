//
//  NewPayNetworkData.h
//  ipaycard
//
//  Created by fei on 13-4-24.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewPayNetworkData : NSObject

@property(nonatomic,strong)NSString *number; //系统类别码 servCode

//trcd交易代码 F10155
//chlcd渠道代码
//trdt交易时间 
@property(nonatomic,strong)NSString *servcode; //系统类别码 servCode
//PRY 银商  STP 游戏点卡 支付宝公共事业

@property(nonatomic,strong)NSString *termtypecode;//终端类别码 termTypeCode
//掌芯宝I版 ZXBI   掌芯宝S版 ZXBS 
@property(nonatomic,strong)NSString *cardtype;//受卡类型 cardType
//磁条卡：TRACK  接触IC：TOUCH   非接IC：NONTOUCH
//userId 用户编号
@property(nonatomic,strong)NSString *termid;//终端编号 termid

@property(nonatomic,strong)NSString *accno;//2，3磁道 accno

@property(nonatomic,strong)NSString *passwd;//密码

@property(nonatomic,strong)NSString *checkcode;//摘要串 checkCode

@property(nonatomic,strong)NSString *serialno;//商品订单号 serialNo

@property(nonatomic,strong)NSString *rettranscod;//回调交易吗 RetTransCod

@property(nonatomic,strong)NSString *paytype;//支付方式 payType
//手机可选
/* 手机和PBOC上送 */
@property(nonatomic,strong)NSString *txamt;//支付金额 txAmt

@property(nonatomic,strong)NSString *merno;//商户编号 MerNo
/* PBOC上送字段 */
@property(nonatomic,strong)NSString *bankcode;//付款银行编码 bankCode 
//////
@property(nonatomic,strong)NSString *accamt;//虚拟账户支付金额 accAmt

@property(nonatomic,strong)NSString *version;//协议版本号

@property(nonatomic,strong)NSString *charset;//字符集

@property(nonatomic,strong)NSString *transtype;//交易类型 transType

@property(nonatomic,strong)NSString *icdata;//IC卡交易城 ICData

/////////
@property(nonatomic,strong)NSString *cardnumber;//银行卡号 cardNumber

@property(nonatomic,strong)NSString *orderamount;//交易金额 orderAmount

//////////
@property(nonatomic,strong)NSString *signmethod;//签名方法 signMethod

@property(nonatomic,strong)NSString *iccardseqnumber;//IC卡系列号 ICCardSeqNumber

@property(nonatomic,strong)NSString *mac;//MAC /0

//返回
@property(nonatomic,strong)NSString *txndat;// TXNDAT 交易日期

//实时转账
@property(nonatomic,strong)NSString *paydesc;// 备注
@property(nonatomic,strong)NSString *payrtmobile;//接受手机号
@property(nonatomic,strong)NSString *transmoney;//转账金额
@property(nonatomic,strong)NSString *phoneinfo;//转账金额


+ (NewPayNetworkData *)newInstance;

@end
