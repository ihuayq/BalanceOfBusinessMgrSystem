//
//  RTTransNetworkhelp.m
//  ipaycard
//
//  Created by RenLongfei on 14-2-17.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "RTTransNetworkhelp.h"

@implementation RTTransNetworkhelp

+ (void)caculateRTTransFeeWithData: (DJYBankTransferData *)rtTransFeeData andDelegate: (id <ServiceDelegate>)delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    __block NSString *message = nil;
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name ]];
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:@"2.0" forKey:kJXTVersion_key];
    [dict setObject:kJXT_transferfee_type forKey:kJXTService_type];
    [dict setObject:Default_UserMobile_Value forKey:kJXTMobile];//18210227044  Default_UserMobile_Value
    [dict setObject:rtTransFeeData.cardNum  forKey:kJXT_trans_in_card];
    [dict setObject:rtTransFeeData.transferMoney forKey:kJXT_trans_amount];

    [dict setObject:Default_Phone_Imei forKey:kJXT_imei];
    [dict setObject:rtTransFeeData.phoneInfo forKey:kJXT_phone_info];
    [dict setObject:@"gps" forKey:kJXT_gps];
    NSString *signTemp = [DNWrapper getRightString_BysortArray_dic:dict];
    NSLog(@"签名加密前===%@",signTemp);
    [dict setObject:GET_SIGN(signTemp) forKey:@"sign"];
    
    [self createPostURL:dict request:formRequst];
    
    formRequst.timeOutSeconds = 60;
    
    [formRequst setCompletionBlock:^{
        
        NSData *responseData = [formRequst responseData];
        NSError *error = nil;

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"rsp_code"];
            
            message = [dic objectForKey:@"rsp_msg"];
            
            CCLog(@"结果码为%@ dic=%@",resultCode,dic);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]){
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            } else{
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
            }
        } else{
            SHOW_AlertViewWith_Message(message);
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
                
                [messageDic setObject:message forKey:KEY_message];
                [delegate requestDidFailed:messageDic];
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

+ (void)commitRTTransWithData:(DJYBankTransferData *)rtTransConfirmData andDelegate:(id<ServiceDelegate>)delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    __block NSString *message = nil;
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];

    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:@"2.0" forKey:kJXTVersion_key];
    [dict setObject:kJXT_transferord_type forKey:kJXTService_type];
    [dict setObject:Default_UserMobile_Value forKey:kJXTMobile];//18210227044 Default_UserMobile_Value
    [dict setObject:rtTransConfirmData.cardNum  forKey:kJXT_trans_in_card];
    [dict setObject:rtTransConfirmData.transferMoney forKey:kJXT_trans_amount];
    [dict setObject:rtTransConfirmData.name forKey:kJXT_trans_in_name];
    [dict setObject:rtTransConfirmData.bankName forKey:kJXT_trans_in_bank_name];

    [dict setObject:rtTransConfirmData.payFee forKey:kJXT_trans_fee];
    if ( rtTransConfirmData.transinMobile.length !=0) {
        [dict setObject:rtTransConfirmData.transinMobile forKey:kJXT_trans_in_mobile];
    }
    if (rtTransConfirmData.readme.length !=0) {
        [dict setObject:rtTransConfirmData.readme forKey:kJXT_desc];
    }

    [dict setObject:Default_Phone_Imei forKey:kJXT_imei];
    [dict setObject:rtTransConfirmData.phoneInfo forKey:kJXT_phone_info];
    [dict setObject:@"gps" forKey:kJXT_gps];
    NSString *signTemp = [DNWrapper getRightString_BysortArray_dic:dict];
    NSLog(@"签名加密前===%@",signTemp);
    [dict setObject:GET_SIGN(signTemp) forKey:@"sign"];
    
    [self createPostURL:dict request:formRequst];
    
    formRequst.timeOutSeconds = 60;
    
    [formRequst setCompletionBlock:^{
        
        NSError *error = nil;

        NSData *responseData = [formRequst responseData];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"rsp_code"];
            
            message = [dic objectForKey:@"rsp_msg"];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]){
                    
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
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
                
                [messageDic setObject:message forKey:KEY_message];
                [delegate requestDidFailed:messageDic];
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
