//
//  ErrorLogUpload.m
//  ipaycard
//
//  Created by RenLongfei on 13-12-31.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "ErrorLogUpload.h"

@implementation ErrorLogUpload

+ (void) uploadErrorLogWithLog:(NSString *)logErrorStr andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:@"1.0" forKey:kJXTVersion_key];
    [dict setObject:kJXT_log_upload_type forKey:kJXTService_type];
    CCLog(@"Mobile=%@  %@",Default_UserMobile_Value, Default_UserId_Value);
    [dict setObject:Default_UserMobile_Value forKey:kJXTMobile];//13938229177 13621331342
    [dict setObject:@"TXF-APP1.0.0" forKey:@"log_type"];
    [dict setObject:GET_SIGN(logErrorStr) forKey:@"log_content"];
    [dict setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"imei"]] forKey:kJXT_imei];
    [dict setObject:Default_PhoneInfo_Value forKey:kJXT_phone_info];
    [dict setObject:@"gps" forKey:kJXT_gps];
    
    NSString *signTemp = [DNWrapper getRightString_BysortArray_dic:dict];
    NSLog(@"签名加密前===%@",signTemp);
    [dict setObject:GET_SIGN(signTemp) forKey:@"sign"];

    [self createPostURL:dict request:formRequst];
    
    formRequst.timeOutSeconds = 60;
    
    [formRequst setCompletionBlock:^{
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"rsp_code"];
            
            message = [dic objectForKey:@"rsp_msg"];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            } else{
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
            }
        } else{
            CCLog(@"解析有错误");
            SHOW_AlertViewWith_Message(message);
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [messageDic setObject:message forKey:KEY_message];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        SHOW_AlertViewWith_WrongNetWorkMessage;
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [delegate requestDidFailed:nil];
        }
        
    }];
    
    [formRequst startAsynchronous];

}

@end
