//
//  TrainNetHelper.m
//  ipaycard
//
//  Created by RenLongfei on 14-1-2.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "TrainNetHelper.h"

@implementation TrainNetHelper
+ (void)commitTicketWithData:(TrainData *)trainConfirmData andDelegate:(id<ServiceDelegate>)delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    __block NSString *message = nil;
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSString *invoiceInfo;
    if (trainConfirmData.withBill) {
        invoiceInfo = [NSString stringWithFormat:@"%@%@%@",trainConfirmData.billTitle,trainConfirmData.detailAddress, trainConfirmData.billInfo];
    }else {
        invoiceInfo = @"";
    }
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:@"1.0" forKey:kJXTVersion_key];
    [dict setObject:kJXT_query_train_create_order_type forKey:kJXTService_type];
    [dict setObject:Default_UserMobile_Value forKey:kJXTMobile];//13938229177 13621331342
    [dict setObject:trainConfirmData.train_queryid  forKey:kJXT_query_id];
    [dict setObject:trainConfirmData.train_id forKey:kJXT_train_id];
    [dict setObject:trainConfirmData.receiveNumString forKey:kJXT_buyer_mobile];
    [dict setObject:trainConfirmData.jsonString forKey:kJXT_rec_list];
    [dict setObject:trainConfirmData.totalAmountString forKey:kJXT_trx_amount];
    [dict setObject:invoiceInfo forKey:@"invoice_info"];
    [dict setObject:Default_Phone_Imei forKey:kJXT_imei];
    [dict setObject:trainConfirmData.phoneInfo forKey:kJXT_phone_info];
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

+ (void) payTrainTicketWithData:(NewPayNetworkData*)payNetworkData andDelegate:(id<ServiceDelegate>) delegate{

    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:@"1.0" forKey:kJXTVersion_key];
    [dict setObject:kJXT_query_train_ticket_pay_type forKey:kJXTService_type];
    [dict setObject:Default_UserMobile_Value forKey:kJXTMobile];//13938229177 13621331342
    [dict setObject:payNetworkData.termtypecode forKey:kJXT_term_type];
    [dict setObject:payNetworkData.termid forKey:kJXT_termid_key];
    [dict setObject:payNetworkData.txamt forKey:kJXT_trx_amount];
    [dict setObject:payNetworkData.merno  forKey:kJXT_merchant_id];
    [dict setObject:payNetworkData.serialno   forKey:kJXT_req_id];
    [dict setObject:payNetworkData.accno  forKey:kJXTCard_magnet];
    [dict setObject:payNetworkData.passwd  forKey:kJXT_card_pwd];
    [dict setObject:payNetworkData.checkcode forKey:kJXT_check_code];
    [dict setObject:payNetworkData.rettranscod  forKey:kJXT_callback_code];
    [dict setObject:Default_Phone_Imei forKey:kJXT_imei];
    [dict setObject:Default_PhoneInfo_Value forKey:kJXT_phone_info];
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
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [messageDic setObject:OUTTIME_Message_NetWork forKey:KEY_message];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [messageDic setObject:OUTTIME_Message_NetWork forKey:KEY_message];

            [delegate requestDidFailed:nil];
        }
        
    }];
    
    [formRequst startAsynchronous];

}

@end
