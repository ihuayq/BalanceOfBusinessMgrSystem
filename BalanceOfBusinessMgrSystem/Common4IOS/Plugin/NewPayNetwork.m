//
//  NewPayNetwork.m
//  ipaycard
//
//  Created by fei on 13-4-24.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "NewPayNetwork.h"

@implementation NewPayNetwork

+ (void) payWithData:(NewPayNetworkData *)payData withDelegate:(id<ServiceDelegate>)delegate{
    
    CCLog(@"function %s line = %d",__FUNCTION__,__LINE__);
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc]init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequest  = [ASIFormDataRequest requestWithURL:[NSURL URLWithString :GET_RIGHT_URL_WITH_Index(@"F10155.front")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:30];
    
    NSString *tmpSign = [NSString stringWithFormat:@"%@%@%@%@",@"F10155",CHlCdNumber_value,timer, DefaultSecretKeyValue_Business];
    
    [dic setObject:GET_SIGN(tmpSign) forKey:@"MAC"];
    NSString *userId =nil;
    
    if (IsCeshiData) {
        
        userId =UserID_CeshiValue;
    } else{
        userId = Default_UserId_Value;
        
    }
    
    [dic setObject:@"F10155" forKey:KEY_TrCd];
    
    [dic setObject:CHlCdNumber_value forKey:KEY_ChlCd];
    
    [dic setObject:timer forKey:KEY_TrTime];
    //PRY代理 STP中台
    if ([payData.number isEqualToString:@"1037"]||[payData.number isEqualToString:@"1038"]||[payData.number isEqualToString:@"1039"]||[payData.number isEqualToString:@"1040"]
        ||[payData.number isEqualToString:@"1041"]||[payData.number isEqualToString:@"1042"]||[payData.number isEqualToString:@"1043"]||[payData.number isEqualToString:@"1044"]||
        [payData.number isEqualToString:@"1045"]||[payData.number isEqualToString:@"1034"]||[payData.number isEqualToString:@"1047"]) {
       
        payData.servcode = @"PRY";
        //信用卡还款 无 merno
    }else {
        payData.servcode = @"STP";
    }
    [dic setObject:payData.servcode forKey:@"servCode"];

    [dic setObject:payData.termtypecode forKey:@"termTypeCode"];
    //磁条卡：TRACK  接触IC：TOUCH   非接IC：NONTOUCH
    [dic setObject:payData.cardtype forKey:@"cardType"];

    [dic setObject:userId forKey:KEY_userId];//userId
    
    [dic setObject:payData.termid  forKey:@"termid"];
    
    [dic setObject:payData.accno  forKey:@"accno"];
    
    [dic setObject:payData.passwd  forKey:@"passwd"];

    [dic setObject:payData.checkcode  forKey:@"checkCode"];

    [dic setObject:payData.serialno  forKey:@"serialNo"];
    
    [dic setObject:payData.rettranscod  forKey:@"RetTransCod"];
    
    //[dic setObject:payData.paytype  forKey:@"payType"]; 

    //手机和 PBOC [payData.number isEqualToString:@"1033"]
            
    if ([payData.number isEqualToString:@"1034"]||[payData.number isEqualToString:@"1037"]||[payData.number isEqualToString:@"1038"]||[payData.number isEqualToString:@"1039"]||[payData.number isEqualToString:@"1040"]) {
        //手机可选
        [dic setObject:payData.txamt  forKey:@"txAmt"];
    }
    
    if ([payData.number isEqualToString:@"1041"]||[payData.number isEqualToString:@"1042"]||[payData.number isEqualToString:@"1047"]) {
        [dic setObject:payData.txamt  forKey:@"txAmt"];
    }
    
    if ([payData.number isEqualToString:@"1046"]) {
        [dic setObject:[Util transfromReceiveMoney:payData.txamt]  forKey:@"txAmt"];
        [dic setObject:payData.merno  forKey:@"MerNo"];
    }
    if ([payData.number isEqualToString:@"1031"]||[payData.number isEqualToString:@"1032"]||[payData.number isEqualToString:@"1033"]) {
        //手机可选
        [dic setObject:payData.txamt  forKey:@"txAmt"];
        [dic setObject:payData.merno  forKey:@"MerNo"];
    }
    //PBOC
    if ([payData.number isEqualToString:@"1044"]) {
        
        [dic setObject:payData.bankcode  forKey:@"bankCode"];
        
        [dic setObject:payData.accamt  forKey:@"accAmt"];
        
        [dic setObject:payData.version  forKey:@"version"];
        
        [dic setObject:payData.charset  forKey:@"charset"];
        
        [dic setObject:payData.transtype  forKey:@"transType"];
        
        [dic setObject:payData.icdata  forKey:@"ICData"];
        
        [dic setObject:payData.cardnumber  forKey:@"cardNumber"];
        
        [dic setObject:payData.orderamount  forKey:@"orderAmount"];
        
        [dic setObject:payData.signmethod  forKey:@"signMethod"];
        
        [dic setObject:payData.iccardseqnumber  forKey:@"ICCardSeqNumber"];
    }
    
    [self createPostURL:dic request:formRequest];
    
    formRequest.timeOutSeconds = 60;
    
    [formRequest setCompletionBlock:^{
        
        [formRequest setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data  = [formRequest responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        
        NSDictionary *temDic  = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            CCLog(@"json解析格式正确");
            NSString *resultCode = [temDic objectForKey:@"RSPCD"];
            
            message  = [[temDic objectForKey:@"RSPMSG"]URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"00"]) {
                
                if (delegate && [delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:temDic];
                }
            }else{
                message = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    [delegate requestDidFinishedWithFalseMessage:temDic];
                }
            }
        }else {
            CCLog(@"解析有错误");
            
            if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                [messageDic setObject:OUTTIME_Message_NetWork forKey:@"RSPMSG"];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }
        }
        
    }];
    [formRequest setFailedBlock:^{
        CCLog(@"失败code= %d message =%@",[formRequest responseStatusCode],[formRequest responseStatusMessage]);
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [messageDic setObject:OUTTIME_Message_NetWork forKey:@"RSPMSG"];
            [delegate requestDidFailed:messageDic];
        }
    }];
    [formRequest startAsynchronous];
    
}

+(void)createPostURL:(NSMutableDictionary *)params request:(ASIFormDataRequest *) request{
    
    NSString *postString=@"";
    
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
        [request setPostValue:value forKey:key];
    }
    
    CCLog(@"请求参数列表 = %@ ",params);

}
 
+ (void) newPayWithData:(NewPayNetworkData *)payData withDelegate:(id<ServiceDelegate>)delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    __block NSString *message = nil;
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]]; 
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:@"2.0" forKey:kJXTVersion_key];
    [dict setObject:kJXT_unifypay_type forKey:kJXTService_type];
    [dict setObject:@"unify.transfer.pay" forKey:kJXTSub_type];
    
    if (payData.payrtmobile.length != 0) {
        [dict setObject:payData.payrtmobile forKey:@"reveiver_mobile"];
        if (payData.payrtmobile.length != 0) {
            [dict setObject:payData.paydesc forKey:kJXT_desc];
            NSMutableDictionary *descInfoDic = [[NSMutableDictionary alloc]init];
            [descInfoDic setObject:payData.paydesc forKey:@"text"];
            [descInfoDic setObject:payData.transmoney forKey:@"order_amount"];
            NSError *parseError = nil;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:descInfoDic options:NSJSONWritingPrettyPrinted error:&parseError];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [dict setObject:jsonString forKey:@"content"];
        }
    }
    
    [dict setObject:payData.termtypecode forKey:kJXT_term_type];
    [dict setObject:payData.termid  forKey:kJXT_termid_key];
    [dict setObject:Default_UserMobile_Value forKey:kJXTMobile]; //Default_UserMobile_Value
    [dict setObject:payData.txamt  forKey:kJXT_trx_amount];
    
    [dict setObject:payData.serialno  forKey:kJXT_req_id];
    [dict setObject:@"999999"  forKey:kJXT_merchant_id];
    [dict setObject:payData.accno  forKey:kJXTCard_magnet];
    [dict setObject:payData.passwd  forKey:kJXT_card_pwd];
    [dict setObject:payData.checkcode  forKey:kJXT_check_code];
    [dict setObject:payData.rettranscod  forKey:kJXT_callback_code];

    [dict setObject:Default_Phone_Imei forKey:kJXT_imei];
    [dict setObject:payData.phoneinfo forKey:kJXT_phone_info];
    [dict setObject:@"gps" forKey:kJXT_gps];
    NSString *signTemp = [DNWrapper getRightString_BysortArray_dic:dict];
    NSLog(@"签名加密前===%@",signTemp);
    [dict setObject:GET_SIGN(signTemp) forKey:@"sign"];
    
    [self createPostURL:dict request:formRequst];
    
    formRequst.timeOutSeconds = 60;
    
    [formRequst setCompletionBlock:^{
        
        NSData *responseData = [formRequst responseData];
        NSError *error = nil;

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        
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
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
                
                [messageDic setObject:OUTTIME_Message_NetWork forKey:KEY_message];
                [delegate requestDidFailed:messageDic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
                
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [messageDic setObject:OUTTIME_Message_NetWork forKey:KEY_message];
            [delegate requestDidFailed:messageDic];
        }
        
    }];
    
    [formRequst startAsynchronous];

}
@end
