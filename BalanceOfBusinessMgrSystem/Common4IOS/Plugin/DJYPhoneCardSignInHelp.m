//
//  DJYPhoneCardSignInHelp.m
//  ipaycard
//
//  Created by Davidsph on 4/9/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYPhoneCardSignInHelp.h"
#import "AppConfigure.h"

@implementation DJYPhoneCardSignInHelp

+ (NSString *)getRightString_BysortArray_dic:(NSDictionary *)dic
{
    NSMutableString *rightString =[NSMutableString stringWithString:@""];
    
    NSArray *_sortedArray= [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
    for (NSString *key in _sortedArray) {
        
        [rightString appendFormat:@"%@",[dic objectForKey:key]];
        
    }
    
    return [rightString stringByAppendingFormat:@"%@",kJXT_consume_sercert_key];
    
}
//MD5加密
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result);
    //%02X X 表示以十六进制形式输出  02 表示不足两位，前面补0输出；出过两位，不影响
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}

+ (BOOL)makeLiftCardSignatureWithMachineNum:(NSString *)number  random:(NSString *)randomNum  checkCode:(NSString *)checkCode delegate:(id<ServiceDelegate>)delegate
{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block BOOL isSuccess = false;
    
    __block NSString *message = nil;
    
    NSString *machineCode = [NSString stringWithFormat:@"%@%@",number,randomNum];
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString: BASE_Domain_Name ]];
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDic setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [requestDic setObject:@"1.0" forKey:kJXTVersion_key];
    [requestDic setObject:kJXT_sign_service_type forKey:kJXTService_type];
    [requestDic setObject:machineCode forKey:kJXT_machine_code];
    [requestDic setObject:checkCode forKey:kJXT_check_code];
    NSString *signTemp = [DJYPhoneCardSignInHelp getRightString_BysortArray_dic:requestDic];
    NSString *signature = [DJYPhoneCardSignInHelp md5:signTemp];
    [requestDic setObject:signature forKey:@"sign"];//签名
    [self createPostURL:requestDic request:formRequst];
    
    [formRequst setTimeOutSeconds:60];
    
    [formRequst setCompletionBlock:^{
        
        [formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        NSLog(@"礼品卡签到返回---%@",dic);
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"rsp_code"];
            
            message = [[dic objectForKey:@"rsp_msg"] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                //服务器返回的分散因子 取得后需写入到刷卡器中
                
                if (IsShowBusinessDebugLog) {
                    
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"签到成功" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
                isSuccess = true;
                
            } else{
                if (IsShowBusinessDebugLog) {
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"签到失败" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
                isSuccess = false ;
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
            }
            
        } else{
            CCLog(@"解析有错误");
            
            //SHOW_AlertViewWith_WrongNetWorkMessage;
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [delegate requestDidFinishedWithFalseMessage:dic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        //SHOW_AlertViewWith_WrongNetWorkMessage;
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [delegate requestDidFailed:nil];
        }
        
    }];
    
    [formRequst startAsynchronous];
    
    return  isSuccess;
}

+ (BOOL) makePhoneCardSignInWithMachineNum:(NSString *) number  random:(NSString *) randomNum  checkCode:(NSString *) checkCode delegate:(id<ServiceDelegate>) delegate{
    
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block BOOL isSuccess = false;
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10017.front?")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *userId =nil;
    
    NSString *userMobile = nil;

    if (IsCeshiData) {
        userId =UserID_CeshiValue;
        userMobile = @"13161188680";
        
    } else{
        
        userId = Default_UserId_Value;
    }

    CCLog(@"刷卡器签到操作中 userID = %@ mobile= %@",Default_UserId_Value,Default_UserMobile_Value);
    
    [dic setObject:@"F10017" forKey:KEY_TrCd];
    
    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];
    [dic setObject:userId forKey:KEY_userId];

    [dic setObject:timer forKey:KEY_TrTime];
    
    [dic setObject:number forKey:@"phoneID"];
    
    [dic setObject:randomNum forKey:@"Random"];
    
    [dic setObject:checkCode forKey:@"checkCode"];

    
    [self createPostURL:dic request:formRequst];
    
    
    [formRequst setCompletionBlock:^{
        
        
        [formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RETCODE"];
            
            message = [[dic objectForKey:@"RSPMSG"] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"1"]) {
                
                //服务器返回的分散因子 取得后需写入到刷卡器中 
                NSString *RETBYTE = [dic objectForKey:@"RETBYTE"];
                
                [messageDic setObject:RETBYTE forKey:@"RETBYTE"];
                
                [messageDic setObject:@"签到" forKey:@"requestType"];
                
                if (IsShowBusinessDebugLog) {
                    
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"签到成功" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                                        
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
                isSuccess = true;
                
            } else{
                if (IsShowBusinessDebugLog) {
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"签到失败" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
                isSuccess = false ;
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
            }
            
        } else{
            CCLog(@"解析有错误");
            
            //SHOW_AlertViewWith_WrongNetWorkMessage;

            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [delegate requestDidFinishedWithFalseMessage:dic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        //SHOW_AlertViewWith_WrongNetWorkMessage;
                
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [delegate requestDidFailed:dic];
        }
        
    }];
    
    [formRequst startAsynchronous];
    
    
    return  isSuccess;
    
}

+ (BOOL)makeNewSignWithMachineNum:(NSString *)number  random:(NSString *)randomNum  checkCode:(NSString *)checkCode delegate:(id<ServiceDelegate>)delegate
{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block BOOL isSuccess = false;
    
    __block NSString *message = nil;
    
    NSString *machineCode = [NSString stringWithFormat:@"%@%@",number,randomNum];
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString: BASE_Domain_Name]];
    
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    [requestDic setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [requestDic setObject:@"1.0" forKey:kJXTVersion_key];
    [requestDic setObject:kJXT_sign_service_type forKey:kJXTService_type];
    [requestDic setObject:machineCode forKey:kJXT_machine_code];
    [requestDic setObject:checkCode forKey:kJXT_check_code];
    NSString *signTemp = [DJYPhoneCardSignInHelp getRightString_BysortArray_dic:requestDic];
    NSString *signature = [DJYPhoneCardSignInHelp md5:signTemp];
    [requestDic setObject:signature forKey:@"sign"];//签名
    
    NSLog(@"requestDic=%@",requestDic);
    [self createPostURL:requestDic request:formRequst];
    [formRequst setTimeOutSeconds:60];
    
    [formRequst setCompletionBlock:^{
        
        [formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        if (!error) {
            
            //CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"rsp_code"];
            
            message = [[dic objectForKey:@"rsp_msg"] URLDecodedString];
            
            CCLog(@"结果码为=%@ 服务器返回的信息为=%@",resultCode,message);
            
            
            
            if ([resultCode isEqualToString:@"0000"])
            {
                
                //服务器返回的分散因子 取得后需写入到刷卡器中
                
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)])
                {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
                isSuccess = true;
                
            } else{

                isSuccess = false ;
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
            }
            
        } else{
            CCLog(@"解析有错误");
            
            //SHOW_AlertViewWith_WrongNetWorkMessage;
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [delegate requestDidFinishedWithFalseMessage:dic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        //SHOW_AlertViewWith_WrongNetWorkMessage;
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [delegate requestDidFailed:nil];
        }
        
    }];
    
    [formRequst startAsynchronous];
    
    return  isSuccess;
}


@end
