//
//  DJYBaseNetworkHelp.h
//  ipaycard
//
//  Created by Davidsph on 4/9/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ServiceDelegate.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "DJYUilityHelper.h"

typedef enum{
    

    BUSINESS_MobilePay_Quary = 100,
    BUSINESS_MobilePay_Commit,
    BUSINESS_AliPay_Quary,
    BUSINESS_AliPay_Commit,
    
    
}DJYRequestType;


@interface DJYBaseNetworkHelp : NSObject


+(NSMutableData *) transformDictToString:(NSMutableDictionary *) dataDict;


//拼接 参数 
+(void)createPostURL:(NSMutableDictionary *)params request:(ASIFormDataRequest *) request;

//支付订单


/*******
 
 请求参数说明：
 productId 为产品订单号
 phoneId 刷卡器号
 accNo 银行卡号
 pwd 银行密码
 ordamt 交易金额
 merNo 商户编号
 
 可选：
 trdt交易时间
 payType交易方式
 checkcode 摘要密文
 rettranscod回调交易码
 mac
 
 返回参数说明：
  
 无参数 成功直接回调 成功时的代理  ---》》》支付成功
 
 
 ********/



/*******
 
 支付订单封装说明 按照支付通方面要求 支付订单这一功能是要封装到SDK里面的  按照实际情况 商家调用这一接口时 只需传入订单号
 
 和商家编号 等其他一些必要信息 但用户银行卡号和密码 等重要资料 对商家来说是透明的 是不可能 知道的 这些私密资料 只对SDK内部使用 。
 此接口封装 有待完善
 
 
 
 ********/


//尚未完成 与手机刷卡器有关的 参数 是写死的 待完善 4/11


+ (void) payOrderWithProductId:(NSString *) productId withPhoneId :(NSString *)phoneId withAccNo :(NSString *)accNo withPwd : (NSString *)pwd withOrdamt : (NSString *)ordamt withMerNo :(NSString *) merNo withCheckCode:(NSString *)checkCode withRetTransCode:(NSString *)retTransCode  withdelegate:(id<ServiceDelegate>) delegate;



+ (void) payOrderWithSerialNo:(NSString *)serialNo withPhoneId:(NSString *)phoneId withAccNo:(NSString *)accNo withPwd:(NSString *)pwd withOrdamt:(NSString *)ordamt withCheckCode:(NSString *)checkCode withRetTransCode:(NSString *)retTransCode withdelegate:(id<ServiceDelegate>)delegate;



+ (void) payTransWithProductId:(NSString *)productId withPhoneId:(NSString *)phoneId withAccNo:(NSString *)accNo withPwd:(NSString *)pwd withOrdamt:(NSString *)ordamt withMerNo:(NSString *)merNo withCheckCode:(NSString *)checkCode withRetTransCode:(NSString *)retTransCode withTxamt:(NSString *)txamt withdelegate:(id<ServiceDelegate>)delegate;

/*******
 
 请求参数说明 
 
 productId ---》》》产品订单号 
 
 merNo ----》》》商户编号 
 
 orderMoney ---》》》订单金额 
 
 其他参数待完善 需要与支付通方面沟通 4/14 
 
 
 
 ********/


//+ (void) payOrderWithProductId:(NSString *) productId merNo:(NSString *)merNo orderMoney:(NSString *) orderMoney delegate:(id<ServiceDelegate>) delegate;





@end
