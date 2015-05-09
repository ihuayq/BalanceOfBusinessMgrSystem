//
//  DJYBankTransferHelper.m
//  ipaycard
//
//  Created by Davidsph on 4/15/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYBankTransferHelper.h"

@implementation DJYBankTransferHelper

+ (void) checkCardBelongToWithCradNum:(NSString *) cardNum
                          andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10190.front")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
    NSString *userId =nil;
    
    if (IsCeshiData) {
        
        userId =UserID_CeshiValue;
        
    } else{
        
        userId = Default_UserId_Value;
    }
    
    CCLog(@"cardNum=%@",cardNum);
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:@"F10190" forKey:KEY_TrCd];
    
    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];

    [dic setObject:userId forKey:KEY_userId];
    
    [dic setObject:timer forKey:KEY_TrTime];
    
    [dic setObject:cardNum forKey:@"cardNo"];
    
    NSString *tmpSign = [NSString stringWithFormat:@"%@%@%@%@%@",@"F10190",CHlCdNumber_value,timer,cardNum,DefaultSecretKeyValue_Business];
    
    [dic setObject:GET_SIGN(tmpSign) forKey:@"MAC"];
    
    [self createPostURL:dic request:formRequst];
    
    [formRequst setCompletionBlock:^{
        
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RSPCD"];
            
            message = [dic objectForKey:@"RSPMSG"];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"00"]) {

                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(message);
                }
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
            } else{
                                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
                
            }
        } else{
            CCLog(@"解析有错误");
            
            SHOW_AlertViewWith_WrongNetWorkMessage;
            
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
            
            
            [delegate requestDidFailed:nil];
        }
        
        
        
    }];
    
    [formRequst startAsynchronous];
    
}

+(void)checkBankadress:(NSString *)searchType  andDelegate:(id<ServiceDelegate>) delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    __block NSString *message = nil;
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dict setObject:kJXT_appkey_value forKey:kJXTApp_key];
    [dict setObject:kJXT_newver_value forKey:kJXTVersion_key];
    [dict setObject:kJXT_cardbindinfo_type forKey:kJXTService_type];
    [dict setObject:Default_UserMobile_Value forKey:kJXTMobile]; //Default_UserMobile_Value
    [dict setObject:searchType forKey:kJXT_search_type];
   
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

+ (void)limitBanktranfer:(NSString *)bizType   andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10235.front")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
    NSString *userId =nil;
    
    if (IsCeshiData) {
        
        userId =@"12110600001";
        
    } else{
        
        userId = Default_UserId_Value;
        
    }
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:@"F10235" forKey:KEY_TrCd];
    
    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];
    //    userId
    [dic setObject:Default_UserId_Value forKey:KEY_userId];
    
    [dic setObject:timer forKey:KEY_TrTime];
    
    [dic setObject:bizType  forKey:@"bizType"];
    
    NSString *tmpSign = [NSString stringWithFormat:@"%@%@%@%@%@",@"F10235",CHlCdNumber_value,timer,userId,DefaultSecretKeyValue_Business];
    
    [dic setObject:GET_SIGN(tmpSign) forKey:@"MAC"];
    
    [self createPostURL:dic request:formRequst];
    
    [formRequst setCompletionBlock:^{
        
        //[formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RSPCD"];
            
            message = [dic objectForKey:@"RSPMSG"];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"00"]) {
                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(message);
                    
                }
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
            } else{
                
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
                
            }
        } else{
            CCLog(@"解析有错误");
            //SHOW_AlertViewWith_WrongNetWorkMessage;
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
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
}


+ (void) calculateMoneyRateWithBankInfo:(DJYBankTransferData *) bankData andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10031.front")]];
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
    NSString *userId =nil;
    
    NSString *cardNum = nil;
    
    NSString *bankName = nil;
    
    NSString *money  = nil;
    
    NSString *bankCode = nil;
    
    if (IsCeshiData) {
        
        userId =@"12110600001";
        
        cardNum = @"6212260200022492769";
        
        bankName = @"工商银行";
        
        bankCode = @"ICBC";
        
        money = @"30";
    } else{
        
        userId = Default_UserId_Value;
        
        cardNum = bankData.cardNum;
        
        bankName = bankData.bankName;
        
        bankCode =bankData.bankCode;
        
        money =bankData.transferMoney; //交易金额 
        
    }
    
    CCLog(@"________bankData.transferMoney=%@",bankData.transferMoney);
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:@"F10031" forKey:KEY_TrCd];
    
    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];
    //    userId
    [dic setObject:userId forKey:KEY_userId];
    
    [dic setObject:timer forKey:KEY_TrTime];
    
    [dic setObject:bankName forKey:@"bankname"]; //银行名称
    
    [dic setObject:money forKey:@"TxAmt"]; //交易金额
    
    [dic setObject:bankCode forKey:@"bankCode"]; //银行编码
    
    [dic setObject:cardNum forKey:@"confirmAccno"]; //收款人 银行卡号
    
    [dic setObject:@"0" forKey:@"feet"]; //手续费付款方式 0 表示自己付 
    
    NSString *tmpSign = [NSString stringWithFormat:@"%@%@%@%@%@",@"F10031",CHlCdNumber_value,timer,userId,DefaultSecretKeyValue_Business];
    
    [dic setObject:GET_SIGN(tmpSign) forKey:@"MAC"];
    
    
    [self createPostURL:dic request:formRequst];
    
    [formRequst setCompletionBlock:^{
        
        //[formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RSPCD"];
            
            message = [dic objectForKey:@"RSPMSG"];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"00"]) {
                
                
                NSString *bankName = [dic objectForKey:@"BANKNAME"];
                NSString *bankCode =[dic objectForKey:@"BANKCODE"];
                
                NSString *fee = [dic objectForKey:@"PAYFEE"];
                
                CCLog(@"查询到的银行名字为 : %@ 代号 : %@ 手续费:%@",bankName,bankCode,fee);
                
                [messageDic setObject:bankName forKey:@"BANKCODENAME"];
                [messageDic setObject:bankCode forKey:@"BANKCODE"];
                
                [messageDic setObject:fee forKey:@"PAYFEE"];
                
                
                
                //获取到的数据 供提交转账订单接口使用
                
                
                bankData.payFee = [dic objectForKey:@"PAYFEE"];
                
                bankData.payAmt = [dic objectForKey:@"PAYAMT"];
                bankData.payRealAmt = [dic objectForKey:@"PAYREALAMT"];
                
                
                //收款相关
                
                bankData.receiptAmt = [dic objectForKey:@"RECEIPTAMT"];
                bankData.receiptFee = [dic objectForKey:@"RECEIPTFEE"];
                bankData.receiptRealAmt = [dic objectForKey:@"RECEIPTREALAMT"];
                

                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(message);
                           
                }
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [messageDic setObject:dic forKey:KEY_message];
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            } else{
                
                SHOW_AlertViewWith_Message(message);
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                }
                
            }
        } else{
            CCLog(@"解析有错误");
            SHOW_AlertViewWith_WrongNetWorkMessage;

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
            
            [delegate requestDidFailed:nil];
        }
        
        
        
    }];
    
    [formRequst startAsynchronous];
    
    
}






+ (void) commitBankTransferBusinessWithTransferData:(DJYBankTransferData *) transferDate
                                        andDelegate:(id<ServiceDelegate>) delegate{
    
  
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10032.front")]];
    
     NSString *userId =nil;
    
    NSString *timer = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    
     NSString *bankName = nil;//银行 
     
    NSString *transferMoney = nil; //交易金额
   
    
    NSString *province = nil;
    
    NSString *city = nil;
    
    NSString *cardBelong = nil; //开户行名称
    
    NSString *feet = nil; //交易方式
    
    
    NSString *cardNum = nil; //收款人银行卡号 
    
    NSString *name = nil; //收款人姓名 
    
    NSString *getMoney = nil; //收款金额
    
    NSString *receiveFee = nil;//收款手续费
    
    NSString *realGetMoney = nil; // 实际收款金额
    
    NSString *realTransferMoney  = nil; //实际付款金额 
   
    
    NSString *fee = nil; //手续费
    
    NSString *phoneNoteFlag = nil;//是否发送短信标志 
    
    NSString *bankCode = nil; //银行编码 
    
    NSString *txamt = nil; //MAC需要
    
    if (IsCeshiData) {
        
        userId = UserID_CeshiValue;
        
        bankName = @"工商银行";
        
        transferMoney = @"10";
        
        province = @"北京";
        
        city = @"北京";
        
        cardBelong = @"九龙山支行";
        
        feet = @"0";
        
        cardNum = @"6212260200022492769";
        
        name = @"董雪莹";
        
        getMoney = transferMoney;
        
        receiveFee = @"0";
        
        realGetMoney = transferMoney;
        
        fee =@"2";
        
 
        realTransferMoney = @"12";
        
        phoneNoteFlag =@"0";
        
        bankCode =@"ICBC";
        
    } else{
        
        userId = Default_UserId_Value;
        
        bankName = transferDate.bankName;
        
        transferMoney =transferDate.transferMoney;
        
        province = transferDate.bankProvince;
        
        city = transferDate.bankCity;
        
        cardBelong = transferDate.bankName_belong;
        
        feet = @"0";
        
        cardNum = transferDate.cardNum;
        
        name = transferDate.name;
        
        getMoney = transferDate.receiptAmt;
        
        receiveFee = transferDate.receiptFee;
        
        realGetMoney = transferDate.receiptRealAmt;
        
        realTransferMoney = transferDate.payRealAmt;
        
        fee = transferDate.payFee; 
        
        phoneNoteFlag = @"0";
        
        bankCode = transferDate.bankCode;
        
        txamt = transferDate.txamt;
        
    }
      
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *tmpSign = [NSString stringWithFormat:@"%@%@%@%@%@",@"F10032",CHlCdNumber_value,timer,txamt,DefaultSecretKeyValue_Business];
    
    CCLog(@"temSIgn=%@",tmpSign);

    
    [dic setObject:GET_SIGN(tmpSign) forKey:@"MAC"];
    
    [dic setObject:@"F10032" forKey:KEY_TrCd];
    
    [dic setObject:CHlCdNumber_value  forKey:KEY_ChlCd];
    
    [dic setObject:userId forKey:KEY_userId];
    
    [dic setObject:timer forKey:KEY_TrTime];
    
    [dic setObject:bankName forKey:@"bankname"]; //银行名称
    
    [dic setObject:txamt forKey:@"TxAmt"]; //交易金额
    
    
    [dic setObject:province forKey:@"province"];
    
    [dic setObject:city forKey:@"city"];
    
    [dic setObject:cardBelong forKey:@"cardNet"];
    
    [dic setObject:feet forKey:@"feet"];
    
    [dic setObject:cardNum forKey:@"confirmAccno"];
    
    [dic setObject:name forKey:@"cardname"];
    
    [dic setObject:getMoney  forKey:@"receiptAmt"];
    
    [dic setObject:receiveFee forKey:@"receiptFee"];
    
    [dic setObject:realGetMoney forKey:@"receiptRealAmt"];
    
    [dic setObject:realTransferMoney forKey:@"payRealAmt"];
    
    [dic setObject:fee forKey:@"fee"];
    
    [dic setObject:phoneNoteFlag forKey:@"phoneNoteFlag"];
    
    [dic setObject:bankCode forKey:@"fbankno"];
    
    CCLog(@"刷卡支付这个页面dic=%@",dic);
    
    
    [self createPostURL:dic request:formRequst];
    
    [formRequst setCompletionBlock:^{
        
        
        //[formRequst setStringEncoding:NSUTF8StringEncoding];
        
        NSString *data = [formRequst responseString];
        
        CCLog(@"网络返回的数据为：%@",data);
        
        NSError *error = nil;
        NSDictionary *dic = [data objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RSPCD"];
            
            message = [dic objectForKey:@"RSPMSG"];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"00"]) {                
           
                NSString *productId =[dic objectForKey:@"SERIALNO"];
                
                CCLog(@"卡卡转账成功后返回的订单号为:%@",productId);
                
                
                [messageDic setObject:productId forKey:KEY_ProductId];
                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(message);
                    
                }
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [messageDic setObject:dic forKey:KEY_message];
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            } else{
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
                
            }
        } else{
            CCLog(@"解析有错误");
            SHOW_AlertViewWith_Message(@"发生错误");

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
            
            
            [delegate requestDidFailed:nil];
        }
        
                
    }];
    
    [formRequst startAsynchronous];
    
    
}

@end
