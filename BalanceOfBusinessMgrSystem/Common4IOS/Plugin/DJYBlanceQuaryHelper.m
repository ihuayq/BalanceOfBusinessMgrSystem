//
//  DJYBlanceQuaryHelper.m
//  ipaycard
//
//  Created by Davidsph on 4/12/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYBlanceQuaryHelper.h"

@implementation DJYBlanceQuaryHelper


+ (void)quaryCardBalanceWithTermid:(NSString *) termid
                         checkCode:(NSString *) checkCode
                           cardNum:(NSString *)cardNum
                        andCardPwd:(NSString *)passwd
                          delegate:(id<ServiceDelegate>) delegate{
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    CCLog(@"cardNum = %@ pwd = %@ termid = %@",cardNum,passwd,termid);
    
    __block NSString *message = nil;
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];

    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10020.front")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
    NSString *userId =nil;
    
    if (IsCeshiData) {
        
        userId =UserID_CeshiValue;
    } else{
        
        userId = Default_UserId_Value;
    }
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *tmpSign = [NSString stringWithFormat:@"%@%@%@%@%@",@"F10020",CHlCdNumber_value,timer,userId, DefaultSecretKeyValue_Business];
    //termid
    [dic setObject:GET_SIGN(tmpSign) forKey:@"MAC"];

    [dic setObject:@"F10020" forKey:KEY_TrCd];
    
    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];
    
    [dic setObject:userId forKey:KEY_userId];
    
    [dic setObject:timer forKey:KEY_TrTime];
    
    [dic setObject:termid forKey:@"termid"];
    
    [dic setObject:cardNum forKey:@"accNo"];
    
    [dic setObject:checkCode forKey:@"checkCode"];
    
    [dic setObject:passwd forKey:@"passwd"];
    
    [self createPostURL:dic request:formRequst];
    
    [formRequst setCompletionBlock:^{
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode_Business];
            
            message = [[dic objectForKey:KEY_message_Business] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"00"]) {
                                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(@"查询银行卡余额成功");
                    
                }
                    
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
            } else{
                message = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
                
            }
        } else{
            CCLog(@"解析有错误");

            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [messageDic setObject:OUTTIME_Message_NetWork forKey:@"RSPMSG"];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [messageDic setObject:OUTTIME_Message_NetWork forKey:@"RSPMSG"];
            [delegate requestDidFinishedWithFalseMessage:messageDic];
        }
        
    }];
    
    [formRequst startAsynchronous];    
    
}


@end
