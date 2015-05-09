//
//  DJYBaseNetworkHelp.m
//  ipaycard
//
//  Created by Davidsph on 4/9/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYBaseNetworkHelp.h"

#import "PayInfo.h"



@implementation DJYBaseNetworkHelp


+(NSMutableData *) transformDictToString:(NSMutableDictionary *) dataDict{
    
    NSArray *keys = [dataDict allKeys];
    
    
    NSMutableString *resultUrl = [[NSMutableString alloc] init];
    
    for (int i = 0; i< [keys count]; i++) {
        if (i > 0) {
            [resultUrl appendString:@"&"];
        }
        [resultUrl appendString:[keys objectAtIndex:i]];
        [resultUrl appendString:@"="];
        [resultUrl appendString:[dataDict objectForKey:[keys objectAtIndex:i]]];
    }
    
    
    NSMutableData *data = (NSMutableData *)[resultUrl dataUsingEncoding:NSUTF8StringEncoding];
    return  data;
    
}


+(void)createPostURL:(NSMutableDictionary *)params request:(ASIFormDataRequest *) request{
    
    NSString *postString=@"";
   
    for(NSString *key in [params allKeys])
    {        
        NSString *value=[params objectForKey:key];
        
        postString = [postString stringByAppendingFormat:@"%@=%@&",key,value];
        [request setPostValue:value forKey:key];
    }
    CCLog(@"请求参数列表 = %@ postString＝%@",params, postString);
}


//支付订单
/*******
 productId 为产品订单号
 phoneId 刷卡器号
 accNo 银行卡号
 pwd 银行密码
 ordamt 交易金额
 merNo 商户编号
 
 checkcode 摘要密文
 *******/

+ (void) payOrderWithProductId:(NSString *)productId withPhoneId:(NSString *)phoneId withAccNo:(NSString *)accNo withPwd:(NSString *)pwd withOrdamt:(NSString *)ordamt withMerNo:(NSString *)merNo withCheckCode:(NSString *)checkCode withRetTransCode:(NSString *)retTransCode withdelegate:(id<ServiceDelegate>)delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;

    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10014.front")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];

    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *userId =nil;
    
    NSString *userMobile = nil;
    
    if (IsCeshiData) {
        userId =UserID_CeshiValue;
        userMobile = @"13161188680";        
    } else{
        userId = Default_UserId_Value;
        userMobile  =Default_UserMobile_Value;
    }
    NSString *tmpSign = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"F10014",CHlCdNumber_value,timer, productId,userId,DefaultSecretKeyValue_Business];
    
    CCLog(@"temSIgn=%@",tmpSign);
    
    [dic setObject:GET_SIGN(tmpSign) forKey:@"MAC"];
    
    [dic setObject:timer forKey:KEY_TrTime];
    
    [dic setObject:@"02" forKey:@"payType"];
    //摘要密文
    [dic setObject:checkCode forKey:@"checkCode"];
    //回调交易码
    [dic setObject:retTransCode forKey:@"retTransCod"];
    //渠道代码 00000001 000001
    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];
    //    userId @"12110600001"
    [dic setObject:userId forKey:KEY_userId];
    [dic setObject:userMobile forKey:@"loginName"];
    //    @"02011000000056"
    [dic setObject:phoneId forKey:@"phoneID"];//刷卡器号
    //    @"0213040900000046"
    [dic setObject:productId forKey:@"PrdOrdNo"];//产品订单号
    //    @"622202XXXXXXXXXXX2492"
    [dic setObject:accNo forKey:@"accNo"];//银行卡号 按照文档应改为accNo
    //@"a3c729e8c375917cceea6d7a1368a401"
    [dic setObject:pwd forKey:@"pwd"];//银行密码
    //@"161"
    [dic setObject:ordamt forKey:@"ORDAMT"];//交易金额
    //    @"a3c729e8c375917cceea6d7a1368a401"

    [dic setObject:@"F10014" forKey:KEY_TrCd];
    
    [dic setObject:merNo forKey:@"MerNo"];//商户编号
    
    [self createPostURL:dic request:formRequst];
    
      
    [formRequst setCompletionBlock:^{
        
    
        [formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RSPCD"];
            
            message = [[dic objectForKey:@"RSPMSG"] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
        
            
            //结果码是F2 -->>验证mac 信息失败
            //结果码是 F0 ---->>> 密码错误 或超次
            
            //00 --->> 支付成功
            
            
            //            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ZHIFU_PWDWrong"];
            
            //            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ZHIFU_MACWrong"];
            
            NSInteger pwdWrong = [[NSUserDefaults standardUserDefaults] integerForKey:@"ZHIFU_PWDWrong"];
            
            NSInteger macWrong = [[NSUserDefaults standardUserDefaults] integerForKey:@"ZHIFU_MACWrong"];
            
            
            if ([resultCode isEqualToString:@"F2"]) {
                CCLog(@"统计mac信息失败 ");
                
                macWrong ++;
                
                [[NSUserDefaults standardUserDefaults] setInteger:macWrong forKey:@"ZHIFU_MACWrong"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
                
            }
            
            
            
            
            if ([resultCode isEqualToString:@"F0"]) {
                
                CCLog(@"统计密码失败");
                
                pwdWrong++;
                [[NSUserDefaults standardUserDefaults] setInteger:pwdWrong forKey:@"ZHIFU_PWDWrong"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
            }
            
            
            
            
            if ([resultCode isEqualToString:@"00"]) {
                                
                if (IsShowBusinessDebugLog) {
                    
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"手机支付成功" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
            
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
            } else{
                
                if (IsShowBusinessDebugLog) {
                    
                    
                    SHOW_AlertViewWith_Message(@"手机支付失败，请重试");
                    
                }
                SHOW_AlertViewWith_Message(message);

                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                }
                
            }
        } else{
            CCLog(@"解析有错误");
            
            SHOW_AlertViewWith_Message(message);

            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        SHOW_AlertViewWith_WrongNetWorkMessage;
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:messageDic];
        }

        
    }];
    
    [formRequst startAsynchronous];

}

+ (void) payTransWithProductId:(NSString *)productId withPhoneId:(NSString *)phoneId withAccNo:(NSString *)accNo withPwd:(NSString *)pwd withOrdamt:(NSString *)ordamt withMerNo:(NSString *)merNo withCheckCode:(NSString *)checkCode withRetTransCode:(NSString *)retTransCode withTxamt:(NSString *)txamt withdelegate:(id<ServiceDelegate>)delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10033.front")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
    //timer = @"0715162431";
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *userId =nil;
    
    if (IsCeshiData) {
        userId =UserID_CeshiValue;
    } else{
        userId = Default_UserId_Value;
    }
    
    NSString *tmpSign = [NSString stringWithFormat:@"%@%@%@%@%@",@"F10033",CHlCdNumber_value,timer, [Util dotMoney:ordamt],DefaultSecretKeyValue_Business];
    CCLog(@"tmpSign=%@",tmpSign);
    
    [dic setObject:GET_SIGN(tmpSign) forKey:@"MAC"];
    
    [dic setObject:@"F10033" forKey:KEY_TrCd];

    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];

    [dic setObject:userId forKey:KEY_userId];
    
    [dic setObject:timer forKey:KEY_TrTime];

    [dic setObject:productId forKey:@"PrdOrdNo"];//产品订单号
    
    [dic setObject:@"02" forKey:@"payType"];
    
    [dic setObject:retTransCode forKey:@"retTransCod"];

    [dic setObject:accNo forKey:@"accNo"];//银行卡号 按照文档应改为accNo

    [dic setObject:pwd forKey:@"pwd"];//银行密码

    [dic setObject:phoneId forKey:@"phoneID"];//刷卡器号

    [dic setObject:[Util dotMoney:ordamt] forKey:@"txAmt"];//交易金额

    [dic setObject:checkCode forKey:@"checkCode"];

    [dic setObject:merNo forKey:@"MerNo"];//商户编号
    
    [dic setObject:@"ZXBI" forKey:@"termTypeCode"];//

    [dic setObject:@"TRACK" forKey:@"cardType"];//

    [self createPostURL:dic request:formRequst];
    
    [formRequst setCompletionBlock:^{
        
        [formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RSPCD"];
            
            message = [dic objectForKey:@"RSPMSG"]; //RSPMSG
            //                       URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            NSInteger pwdWrong = [[NSUserDefaults standardUserDefaults] integerForKey:@"ZHIFU_PWDWrong"];
            
            NSInteger macWrong = [[NSUserDefaults standardUserDefaults] integerForKey:@"ZHIFU_MACWrong"];
            
            
            if ([resultCode isEqualToString:@"F2"]) {
                CCLog(@"统计mac信息失败 ");
                
                macWrong ++;
                
                [[NSUserDefaults standardUserDefaults] setInteger:macWrong forKey:@"ZHIFU_MACWrong"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            
            if ([resultCode isEqualToString:@"F0"]) {
                
                CCLog(@"统计密码失败");
                
                pwdWrong++;
                [[NSUserDefaults standardUserDefaults] setInteger:pwdWrong forKey:@"ZHIFU_PWDWrong"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            if ([resultCode isEqualToString:@"00"]) {
                
                if (IsShowBusinessDebugLog) {
                    
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"手机支付成功" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
            } else{
                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(@"手机支付失败，请重试");
                    
                }
                message = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
                //SHOW_AlertViewWith_Message(message);
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
                
            }
        } else{
            CCLog(@"解析有错误");
            message = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
            //SHOW_AlertViewWith_Message(message);
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        SHOW_AlertViewWith_WrongNetWorkMessage;
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:messageDic];
        }
        
        
    }];
    
    [formRequst startAsynchronous];
    
}


+ (void) payOrderWithSerialNo:(NSString *)serialNo withPhoneId:(NSString *)phoneId withAccNo:(NSString *)accNo withPwd:(NSString *)pwd withOrdamt:(NSString *)ordamt withCheckCode:(NSString *)checkCode withRetTransCode:(NSString *)retTransCode withdelegate:(id<ServiceDelegate>)delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10025.front")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *userId =nil;
    
    NSString *userMobile = nil;
    
    if (IsCeshiData) {
        userId =UserID_CeshiValue;
        userMobile = @"13161188680";
    } else{
        userId = Default_UserId_Value;
        userMobile  =Default_UserMobile_Value;
    }
    [dic setObject:@"F10025" forKey:KEY_TrCd];

    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];
    
    [dic setObject:timer forKey:KEY_TrTime];
    //    userId  @"12110600001"
    [dic setObject:userId forKey:KEY_userId];
    
    [dic setObject:phoneId forKey:@"phoneID"];//刷卡器号
    
    [dic setObject:accNo forKey:@"accNo"];//银行卡号 按照文档应改为accNo
    
    [dic setObject:pwd forKey:@"pwd"];//银行密码
    //摘要密文
    [dic setObject:checkCode forKey:@"checkCode"];
    
    [dic setObject:serialNo forKey:@"serialNo"];//商户编号
    //回调交易码
    [dic setObject:retTransCode forKey:@"retTransCod"];
    /////////
    [dic setObject:@"02" forKey:@"payType"];
    
    [dic setObject:userMobile forKey:@"loginName"];

    [dic setObject:ordamt forKey:@"ORDAMT"];//交易金额
        
    [self createPostURL:dic request:formRequst];
    
    [formRequst setCompletionBlock:^{
        
        [formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RSPCD"];
            
            message = [[dic objectForKey:@"RSPMSG"] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"00"]) {
                
                if (IsShowBusinessDebugLog) {
                    
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"手机支付成功" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
            } else{
                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(@"手机支付失败，请重试");
                }
                
                SHOW_AlertViewWith_Message(message);
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
                    [delegate requestDidFinishedWithFalseMessage:messageDic]; 
                }
                
            }
        } else{
            CCLog(@"解析有错误");
            
            SHOW_AlertViewWith_Message(message);
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        SHOW_AlertViewWith_WrongNetWorkMessage;
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:messageDic];
        }
        
    }];
    
    [formRequst startAsynchronous];
    
}
@end
