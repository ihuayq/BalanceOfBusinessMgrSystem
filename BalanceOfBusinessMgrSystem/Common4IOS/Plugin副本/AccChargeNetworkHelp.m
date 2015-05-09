//
//  AccChargeNetworkHelp.m
//  ipaycard
//
//  Created by RenLongfei on 14-3-11.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//
#import "DJYCardInfoSingle.h"
#import "PayInfo.h"
#import "AccChargeNetworkHelp.h"

@implementation AccChargeNetworkHelp

+ (void)payAccChargeWithData : (NewPayNetworkData *)newPayData andDelegate : (id<ServiceDelegate>)delegate
{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    __block NSString *message = nil;
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name_Recharge]];
    
//    ChlCd = 00000001;         写死
//    MAC = 840eef5070bb7ff3c0ace3f35a8b007f;
//    PrdOrdType = 01;          写死
//    TrCd = F10215;            写死
//    TrDt = 1029104456;
//    UserId = 14052600102;
//    loginName = 18611073528;
    
//    cardType = TOUCH;
//    ICCardSeqNumber = 001;
//    ICDATA = 9F2608997D8E21188505459F2701809F101307010103A00000010A01000000000080CC38A99F3704000000009F360200E7950580000400089A031410299C01009F02060000000000015F2A02015682027C009F1A0201569F03060000000000009F3303A048009F34031F00029F3501349F1E0831323334353637388408A0000003330101019F090200209F410400000001;
//    accno = CA9A6BE4301ABB83B146D9F99D1EECCB4CA6D4C95C1D357379890609D97CFD1379890609D97CFD1379890609D97CFD1379890609D97CFD1379890609D97CFD1379890609D97CFD1379890609D97CFD13;
    

//    checkCode = E59CD3EC4067ACF992D8D4D996455069;
//    passwd = DCD11B08898AF81B846FDB4D96C58BED;
//    payOrdNo = P014102900000317;
//    termTypeCode = ZXBS;
//    termid = 21000020010181;
    
    DJYCardInfoSingle *cardInfo = [DJYCardInfoSingle newCardInfoInstance];
    PayInfo* pi=[PayInfo newInstence];
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    [dict setObject:CHlCdNumber_value forKey:kJX_ChlCd];
    NSString *sign=[NSString stringWithFormat:@"%@%@%@%@%@",kJX_F10215,CHlCdNumber_value,[NNString getCurrentTimeWithSpecialFormat:@"MMddHHmmss"],Default_UserMobile_Value,DefaultSecretKeyValue_Business];
    [dict setObject:GET_SIGN(sign) forKey:kJX_MAC];
    
    [dict setObject:@"01" forKey:@"PrdOrdType"];
    [dict setObject:kJX_F10215 forKey:kJX_TrCd];
    [dict setObject:[NNString getCurrentTimeWithSpecialFormat:@"MMddHHmmss"] forKey:kJX_TrDt];
    [dict setObject:[[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_MOBILE] forKey:kJX_loginName];
    [dict setObject:[[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_ID] forKey:kJX_userId];
    [dict setObject:newPayData.cardtype forKey:@"cardType"];
    if ([newPayData.cardtype isEqualToString:@"TOUCH"])
    {
        NSString *s=[NSString stringWithFormat:@"0%@",cardInfo.yu_23];
        [dict setObject:s forKey:@"ICCardSeqNumber"];
        
        //55域数据 截掉开头00
        NSString *str=[NSString stringWithFormat:@"%@",[cardInfo.icData substringWithRange:NSMakeRange(2, cardInfo.icData.length-2)]];
        //再去掉末尾12个字符长度
        NSInteger StrLength=str.length-12;
        NSString *str1=[NSString stringWithFormat:@"%@",[str substringWithRange:NSMakeRange(0, StrLength)]];
        CCLog(@"str1============%@",str1);
        [dict setObject:str1 forKey:@"ICDATA"];
    }
    [dict setObject:newPayData.accno  forKey:@"accno"];
    [dict setObject:newPayData.passwd  forKey:@"passwd"];
    [dict setObject:newPayData.checkcode forKey:@"checkCode"];
    [dict setObject:newPayData.serialno   forKey:@"payOrdNo"];
    [dict setObject:[pi.payDetail objectForKey:@"termTypeCode"] forKey:@"termTypeCode"];
    [dict setObject:newPayData.termid forKey:@"termid"];
    
    
    
    NSString *signTemp = [DNWrapper getRightString_BysortArray_dic:dict];
    NSLog(@"签名加密前===%@",signTemp);
    [dict setObject:GET_SIGN(signTemp) forKey:@"sign"];
    
    [dict setObject:[[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:PLATFORMUSERID] forKey:@"platformuserid"];
    
    [self createPostURL:dict request:formRequst];
    
    formRequst.timeOutSeconds = 60;
    
    [formRequst setCompletionBlock:^{
        
        NSError *error = nil;
        
        NSData *responseData = [formRequst responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        
        if (!error) {
            
            //CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"rsp_code"];
            message = [dic objectForKey:@"rsp_msg"];
            CCLog(@"支付 结果码为=%@ ,  服务器返回的信息为=%@",resultCode,message);
            
            
            
            if ([resultCode isEqualToString:@"0000"])
            {
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)])
                {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            }
            else
            {
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
            }
        } else{
            CCLog(@"支付 错误");
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

+ (void)bindingCardWithData : (DAccData *)accData andDelegate : (id <ServiceDelegate>)delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    __block NSString *message = nil;
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:kJXT_newver_value forKey:kJXTVersion_key];
    [dict setObject:kJXT_cardbind_type forKey:kJXTService_type];
    [dict setObject:Default_UserMobile_Value forKey:kJXTMobile];
    [dict setObject:accData.provinceStr forKey:kJXTProvince];
    [dict setObject:accData.cityStr forKey:kJXTCity];
    [dict setObject:accData.branchName forKey:@"bank_name"];//开户行
    [dict setObject:accData.bankNet forKey:kJXTSubBranch];
    [dict setObject:accData.bankCode forKey:@"bank_abbr"];
    [dict setObject:accData.accNum forKey:kJXT_card_no];
    [dict setObject:accData.accName forKey:kJXT_real_name];
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

+(void)unbindingCardWithData:(DAccData *)accUBData andDelegate:(id<ServiceDelegate>)delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    __block NSString *message = nil;
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]]; 
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:kJXT_newver_value forKey:kJXTVersion_key];
    [dict setObject:kJXT_cardunbind_type forKey:kJXTService_type];
    [dict setObject:@"18210227044" forKey:kJXTMobile];
    [dict setObject:accUBData.accNum forKey:kJXT_card_no];
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
