//
//  DJYBankTransferHelper.h
//  ipaycard
//
//  Created by Davidsph on 4/15/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYBaseNetworkHelp.h"
#import "DJYBankTransferData.h"

@interface DJYBankTransferHelper : DJYBaseNetworkHelp


//+ (void)bankTransfer_addNewCard
//


//查询 银行卡号 与所属银行是否相符

/*******
 
 请求参数说明 
 
 cardNum ----》》》银行卡号 
 
 
 返回参数说明 
 
 [messageDic setObject:bankName forKey:@"BANKCODENAME"];
 [messageDic setObject:bankCode forKey:@"BANKCODE"];

 BANKCODENAME --- 》》》》 银行名字  需要与界面中选择的银行名字进行校验 
 
 BANKCODE --- 》》》银行代码 
 
 ********/

+ (void) checkCardBelongToWithCradNum:(NSString *) cardNum
                          andDelegate:(id<ServiceDelegate>) delegate;







//计算费率

/*******
 
 请求参数说明
 
 DJYBankTransferData ---》》有关银行的一些操作 必传 
 
 银行名称   bankName
 
 交易金额 transferMoney
 
 收款人银行卡号  cardNum 

 银行编码  bankCode
 
 
 返回参数说明 
 
 PAYFEE -----》》手续费 
 
 
 ********/


+ (void) calculateMoneyRateWithBankInfo:(DJYBankTransferData *) bankData andDelegate:(id<ServiceDelegate>) delegate;




/*******
 
 请求参数说明 
 
 DJYBankTransferData ---》》有关银行的一些操作 
 

 只需传入这些参数 其他参数 已在上一个接口中 接收到
 
 transferDate.bankProvince =@"北京";
 
 transferDate.bankCity = @"北京";
 
 transferDate.bankName_belong = @"九龙山支行";
 
 transferDate.name = @"董雪莹";

 
 
  
 返回参数说明 
 
 
 KEY_ProductId --- 》》》返回产品订单号
 
 
 ********/






+ (void) commitBankTransferBusinessWithTransferData:(DJYBankTransferData *) transferDate
                                        andDelegate:(id<ServiceDelegate>) delegate;


//查询卡卡转账以及信用卡还款额度限制
+ (void)limitBanktranfer:(NSString *)bizType   andDelegate:(id<ServiceDelegate>) delegate;

+(void)checkBankadress:(NSString *)searchType  andDelegate:(id<ServiceDelegate>) delegate;//查询银行归属地
@end
