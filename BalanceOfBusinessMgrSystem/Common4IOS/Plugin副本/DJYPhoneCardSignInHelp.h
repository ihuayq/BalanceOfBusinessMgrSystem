//
//  DJYPhoneCardSignInHelp.h
//  ipaycard
//
//  Created by Davidsph on 4/9/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYBaseNetworkHelp.h"

@interface DJYPhoneCardSignInHelp : DJYBaseNetworkHelp



//手机刷卡器签到 接口
/*******
 
 参数解释 ：
 
 number 刷卡器号 
 
 random 随机数  客户端自己生成的随机数 9个字节 
 
 checkCode 刷卡器上送的校验码  首先，把7字节的刷卡器ID号在前，9字节的随机码在后，连接成为16字节的数组；然后，调用Device接口的encryptDigest方法，keyIndex参数传入0x04，该方法的返回值即是校验码。
 
 返回参数：
 
 成功代理 是 签到成功
 
 RETBYTE ---分散因子 需要写入到刷卡器中 
 
  
 ********/

+ ( BOOL) makePhoneCardSignInWithMachineNum:(NSString *) number  random:(NSString *) randomNum  checkCode:(NSString *) checkCode delegate:(id<ServiceDelegate>) delegate;


//交响团礼品卡签到请求
+ (BOOL) makeLiftCardSignatureWithMachineNum:(NSString *)number  random:(NSString *)randomNum  checkCode:(NSString *)checkCode delegate:(id<ServiceDelegate>)delegate;

//新签到
+ (BOOL)makeNewSignWithMachineNum:(NSString *)number  random:(NSString *)randomNum  checkCode:(NSString *)checkCode delegate:(id<ServiceDelegate>)delegate;

@end
