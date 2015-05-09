//
//  LoginInNetworkHelper.m
//  ipaycard
//
//  Created by Davidsph on 4/6/13.
//  Copyright (c) 2013 han bing. All rights reserved.
//

#import "LoginInNetworkHelper.h"
#import "Util.h"
//#import "CommonFunction.h"

@implementation LoginInNetworkHelper

//用户是否注册 查询
#pragma mark -
#pragma mark 用户是否注册 ****************查询 ok

+ (void) isRegeisterWithMobile:(NSString *) mobile  andDelegate:(id<ServiceDelegate>) delegate;{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
     __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    [formRequst setRequestMethod:@"POST"];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:ZFT_version_Value forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.user.reg.qry" forKey:KEY_service_type];
    
    [dic setObject:mobile forKey:@"mobile"];
    
    CREATE_POST_URL(dic, formRequst);
    
    [formRequst setCompletionBlock:^{
        
        NSData *data = [formRequst responseData];
        
        NSString *tmp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        CCLog(@"网络返回的数据为：%@",tmp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [tmp objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [dic objectForKey:KEY_message];
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            CCLog(@"结果码为%@",resultCode);
            
            //1003代表手机未注册 进入注册界面
            if ([resultCode  isEqualToString:@"1003"]) {
                
                if (IsShowBusinessDebugLog) {
                    
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"手机号未注册" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                    
                }
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [messageDic setObject:@"未注册" forKey:KEY_message];
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
            } else if ([resultCode isEqualToString:@"1000"]) {
                
                //1000代表 该手机已经被注册过 直接登录
                if (IsShowBusinessDebugLog) {
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"手机号已被注册" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]){
                    [messageDic setObject:@"注册" forKey:KEY_message];
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            }else{
                
                SHOW_AlertViewWith_Message(message);
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]){
                    
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                }
            }
            
        } else{
            CCLog(@"解析有错误");
            
            CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);
            
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
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]){
            
            [delegate requestDidFailed:messageDic];
            
        }
    }];
    
    [formRequst startAsynchronous];
    
}

#pragma mark -
#pragma mark 登录  ******************ok

//登录 操作
+ (void) loginWithPassWd:(NSString *) passwd  andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *mobile = nil;
    NSString *pwd = nil;
    
    //    pwd = GET_3DES(passwd);
    NSData *enData = [[NSData alloc] init];
    pwd = [enData encrypyConnect:passwd];
    CCLog(@"登录密码3des加密后是%@",pwd);
    mobile =Default_UserMobile_Value;
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:ZFT_version_Value forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.user.login" forKey:KEY_service_type];
    
    [dic setObject:mobile forKey:@"mobile"];
    
    [dic setObject:pwd forKey:@"login_pwd"];
    
    CREATE_POST_URL(dic, formRequst);
    
    [formRequst setCompletionBlock:^{      
        
        NSData *data =[formRequst responseData];
        
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
                        
            message = [dic objectForKey:KEY_message];
    
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            CCLog(@"结果码为%@",resultCode);
            
            if ([resultCode isEqualToString:@"0000"] ) {
                
                NSString *userId = [dic objectForKey:@"provider_user_id"];
                NSString *credStatu = [dic objectForKey:@"cred_validate_status"];
                NSString *realName = [dic objectForKey:@"real_name"];
                NSString *idcardNo = [dic objectForKey:@"idcard_no"];
                NSString  *mobileNumber= [dic objectForKey:@"mobile"];
                NSString  *isforcePwd = [dic objectForKey:@"is_force_pwd"];
        
                NSString  *credImageA = [dic objectForKey:@"cred_img_a"];
                NSString  *credImageB = [dic objectForKey:@"cred_img_b"];
             
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(@"登录成功");
                }
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    [messageDic setObject:@"成功" forKey:KEY_message];
                    [messageDic setObject:userId forKey:@"provider_user_id"];
                    [messageDic setObject:credStatu forKey:@"cred_validate_status"];
                    [messageDic setObject:realName forKey:@"real_name"];
                    [messageDic setObject:idcardNo forKey:@"idcard_no"];
                    [messageDic setObject:mobileNumber forKey:@"mobile"];
                    [messageDic setObject:isforcePwd forKey:@"is_force_pwd"];
                   
                    [messageDic setObject:credImageA forKey:@"cred_img_a"];
                    [messageDic setObject:credImageB forKey:@"cred_img_b"];
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            }else{
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
        
        //CCLog(@"失败 code = %d message = %@", [formRequst responseStatusCode], [formRequst responseStatusMessage]);

        [messageDic setObject:WRONG_Message_NetWork forKey:KEY_message];
        
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:messageDic];
        }
        
    }];
    
    [formRequst startAsynchronous];
    
}
#pragma mark -
#pragma mark 密码修改
+ (void) changePwdWith:(NSString *) oldPwd  NewPwd:(NSString *)newpwd   yaCode:(NSString *)yaCode  PwdType:(NSString *)pwdtype SmsType:(NSString *)smstype andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSString *mobile = nil;
    
    if (IsCeshiData) {
        
        mobile = @"13161188680";
        
    } else{
        
        mobile = Default_UserMobile_Value;
    }
    
    NSData *data = [[NSData alloc] init];
    NSString *newpass = [data encrypyConnect:newpwd];

    NSString  *oldpass = [data encrypyConnect:oldPwd];
    
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:ZFT_version_Value forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.pwd.modify" forKey:KEY_service_type];
    
    [dic setObject:mobile forKey:@"mobile"];
    [dic setObject:pwdtype forKey:@"pwd_type"];
    [dic setObject:oldpass forKey:@"old_pwd"];
    [dic setObject:newpass forKey:@"new_pwd"];
    [dic setObject:yaCode forKey:@"sms_verify_code"];
    [dic setObject:smstype forKey:@"sms_type"];
    
    CREATE_POST_URL(dic, formRequst);
    
    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(@"找回密码成功！");
                    
                }
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                    
                }
                
            } else if([resultCode isEqualToString:@"8001"]){
               
               //SHOW_AlertViewWith_Message(@"短信验证码错误,请重试！");
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                    
                }
                
            } else if([resultCode isEqualToString:@"1013"]){
                
                
                //SHOW_AlertViewWith_Message(@"登陆密码不能与支付密码相同！");
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                    
                }
                
            } else{
                
                //SHOW_AlertViewWith_WrongNetWorkMessage;
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
            }
            
        } else{
            CCLog(@"解析有错误");
            
            SHOW_AlertViewWith_WrongNetWorkMessage;
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                
                [delegate requestDidFinishedWithFalseMessage:nil];
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
    delegate = nil;
    
    
}

//找回密码 设置新密码
#pragma mark -
#pragma mark 找回密码 设置新密码

+ (void) updatePassWdWithNewPasswd:(NSString *) newPasswd  yaCode:(NSString *)yaCode  CredNum:(NSString *)credNum PwdType:(NSString *)pwdtype  SmsType:(NSString *)smstype andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSString *mobile = nil;
    
    if (IsCeshiData) {
        
        mobile = @"13161188680";
        
    } else{
        
        mobile = Default_UserMobile_Value;
    }
    
    //    NSString *pwd = GET_3DES(newPasswd);
    NSData *data = [[NSData alloc] init];
    NSString *pwd = [data encrypyConnect:newPasswd];
    NSLog(@"userMobile====%@",mobile);
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:ZFT_version_Value forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.pwd.reset" forKey:KEY_service_type];
    
    [dic setObject:mobile forKey:@"mobile"];
    [dic setObject:credNum forKey:@"idcard_no"];
    
    [dic setObject:yaCode forKey:@"sms_verify_code"];
    [dic setObject:smstype forKey:@"sms_type"];
    
    [dic setObject:pwd forKey:@"new_pwd"];
    [dic setObject:pwdtype forKey:@"pwd_type"];
    
    CREATE_POST_URL(dic, formRequst);
    
    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
                
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(@"找回密码成功！");
                }
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
                
            } else {
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }
                
            }
        } else{
            CCLog(@"解析有错误");
            
            SHOW_AlertViewWith_WrongNetWorkMessage;
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
                
                [delegate requestDidFailed:nil];
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
    delegate = nil;
}

//注册
#pragma mark -
#pragma mark 注册 ****************已OK

+ (void) registerWithName:(NSString *) name idCard:(NSString *) idCard yaCode:(NSString *)yzCode LoginP:(NSString *)loginPass PayP:(NSString *)payPass andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSString *mobile = nil;
    
    if (IsCeshiData) {
        
        mobile = @"13161188680";
        
    } else{
        
        mobile =Default_UserMobile_Value;
    }
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    NSString  *strVer = [Util getVersionInteger];
    [dic setObject:strVer forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.user.reg" forKey:KEY_service_type];
    
    [dic setObject:idCard forKey:@"idcard_no"];
    
    [dic setObject:name forKey:@"real_name"];
    
    [dic setObject:mobile forKey:@"mobile"];
    
    [dic setObject:yzCode forKey:@"sms_verify_code"];
    
    //全部走新用户
    [dic setObject:@"USER_REG" forKey:@"sms_type"];
    if ([[strVer substringWithRange:NSMakeRange(0, 1)] intValue] > 1) {
        NSData *data = [[NSData alloc] init];
        NSString *loginP = [data encrypyConnect:loginPass];
        NSString  *payP = [data encrypyConnect:payPass];
        
        [dic setObject:loginP forKey:@"login_pwd"];
        [dic setObject:payP forKey:@"pay_pwd"];
    }
    NSLog(@"dic =%@",dic);
    CREATE_POST_URL(dic, formRequst);
    
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        
        
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            CCLog(@"json解析格式正确");
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                if (IsShowBusinessDebugLog) {
                    
                    [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"用户已成功注册,登录后处理" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                }
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    NSString *userId = [dic objectForKey:@"provider_user_id"];
                    NSString  *mobile = [dic objectForKey:@"mobile"];
                    [messageDic setObject:mobile forKey:@"mobile"];
                    [messageDic setObject:userId forKey:@"provider_user_id"];
                    [messageDic setObject:[dic objectForKey:@"rsp_code"] forKey:@"rsp_code"];
                    [delegate requestDidFinishedWithRightMessage:messageDic];
                    
                }
                
            }  else if([resultCode isEqualToString:@"8004"]){
                
                [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"用户身份证不符合规范" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [messageDic setObject:@"" forKey:KEY_message];
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                    
                }
                
            }else if([resultCode isEqualToString:@"1000"]){
                
                [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:@"用户已经注册,可直接登录" delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [messageDic setObject:@"" forKey:KEY_message];
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                    
                }
                                
            } else if([resultCode isEqualToString:@"8001"]){
                
                SHOW_AlertViewWith_Message(@"验证码错误");
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)])
                {
                    
                    [messageDic setObject:@"" forKey:KEY_message];
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                }
            } else{
               
                SHOW_AlertViewWith_Message(message);
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]){
                    
                    [messageDic setObject:@"" forKey:KEY_message];
                    [delegate requestDidFinishedWithFalseMessage:messageDic];
                }

            }
            
        } else{
            
            CCLog(@"解析有错误");
            
            SHOW_AlertViewWith_WrongNetWorkMessage;
            
            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]){
                
                [messageDic setObject:@"" forKey:KEY_message];
                [delegate requestDidFinishedWithFalseMessage:messageDic];
            }

        }        
    }];
    
    [formRequst setFailedBlock:^{
        
        CCLog(@"失败");
        
        SHOW_AlertViewWith_WrongNetWorkMessage;
        if (delegate&&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [delegate requestDidFailed:nil];
        }
        
    }];
    
    [formRequst startAsynchronous];
    
}

#pragma mark -
#pragma mark 用户设置密码 **************Ok

+ (void) setPassWd:(NSString *) pwd andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    CCLog(@"3des加密之前 %@",pwd);
    
//    NSString *desPwd =GET_3DES(pwd);
    NSData *data = [[NSData alloc] init];
    NSString *desPwd = [data encrypyConnect:pwd];
    
    CCLog(@"3des加密之后 %@",desPwd);
    NSString *mobile;
    CCLog(@"%@",formRequst);
    
    if (IsCeshiData) {
        
        mobile = @"13161188680";
        
    }else{
        mobile = Default_UserMobile_Value;
    }
    
    mobile = Default_UserMobile_Value;
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    [dic setObject:ZFT_version_Value forKey:KEY_version];
    [dic setObject:@"icardpay.app.user.pwd.init" forKey:KEY_service_type];
    [dic setObject:desPwd forKey:@"login_pwd"];
    [dic setObject:mobile forKey:@"mobile"];
    NSString *signTmp =[DNWrapper getRightString_BysortArray_dic:dic];
    CCLog(@"签名加密前:%@",signTmp);
    CCLog(@"签名加密后:%@",GET_SIGN(signTmp));
    
    [formRequst setPostValue:kJXT_appkey_value forKey:KEY_app_key];
    
    [formRequst setPostValue:ZFT_version_Value forKey:KEY_version];
    
    [formRequst setPostValue:@"icardpay.app.user.pwd.init" forKey:KEY_service_type];
    
    [formRequst setPostValue:desPwd forKey:@"login_pwd"];
    
    [formRequst setPostValue:mobile forKey:@"mobile"];
    
    [formRequst setPostValue:GET_SIGN(signTmp) forKey:KEY_sign];
    
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                if (IsShowBusinessDebugLog) {
                    
                    SHOW_AlertViewWith_Message(@"设置密码成功");
                    
                }
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    
                    [delegate requestDidFinishedWithRightMessage:dic];
             
                }                
                
            } else  if([resultCode isEqualToString:@"1001"]){
                
                SHOW_AlertViewWith_Message(@"用户不存在，设置密码失败");
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                    
                }

            } else{                
                
                if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)])
                {
                    
                    [delegate requestDidFinishedWithFalseMessage:dic];
                }

            }            
            
        } else{
            
            CCLog(@"解析有错误");
            
            SHOW_AlertViewWith_WrongNetWorkMessage;

            if (delegate&&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)])
            {
                
                [messageDic setObject:@"" forKey:KEY_message];
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

//获取验证码

#pragma mark -
#pragma mark 获取验证码 *****************已ok
+ (void) getSecretCodeWithMobile:(NSString *)receivedMobile  With:(NSString *)smsType andDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:ZFT_version_Value forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.user.verifycode.dis" forKey:KEY_service_type];
    
    [dic setObject:receivedMobile forKey:@"mobile"];
   
    [dic setObject:smsType forKey:@"sms_type"];
    
    CREATE_POST_URL(dic, formRequst);
    NSLog(@"smsType=%@ dic=%@",smsType,dic);
    
    [formRequst setRequestMethod:@"POST"];

    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                NSLog(@"成功");
                
            }else{
                NSLog(@"失败");
            }
            
        }
        else{
            CCLog(@"解析有错误");
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        NSLog(@"失败");
        SHOW_AlertViewWith_WrongNetWorkMessage;
        if (IsShowBusinessDebugLog) {
           SHOW_AlertViewWith_WrongNetWorkMessage;
        }
    }];
    
    [formRequst startAsynchronous];
    
}
#pragma mark - 更新
+ (void) updateVersions:(NSString *) versions  andDelegate:(id<ServiceDelegate>) delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:versions forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.vresion.qry" forKey:KEY_service_type];
    
    [dic setObject:@"IOS" forKey:KEY_system];
    
    NSString *signTmp =[DNWrapper getRightString_BysortArray_dic:dic];
            
    [formRequst setPostValue:@"IOS" forKey:KEY_system];
    
    [formRequst setPostValue:@"icardpay.app.vresion.qry" forKey:KEY_service_type];

    [formRequst setPostValue:versions forKey:KEY_version];

    [formRequst setPostValue:kJXT_appkey_value forKey:KEY_app_key];

    [formRequst setPostValue:GET_SIGN(signTmp) forKey:KEY_sign];
    
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            }
            
        }
        else{
            CCLog(@"解析有错误");
            if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                [delegate requestDidFinishedWithFalseMessage:dic];
            }

        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        //SHOW_AlertViewWith_WrongNetWorkMessage;
        if (delegate &&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:dic];
        }

        
    }];
    
    [formRequst startAsynchronous];

}
#pragma mark - 第一次登陆获取网络数据
+ (void)requestTradeHistoryListDataWithMobile:(NSString *)mobile
                                      pageNum:(int)pageNum andDelegate:(id<ServiceDelegate>) delegate{
    
    NSLog(@"————————————数据库请求");
    CCLog(@"登录手机号%@",mobile);
    CCLog(@"页数%d",pageNum);
    __weak ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10055.front")]];
    formRequest.stringEncoding = NSUTF8StringEncoding;
    NSString *userId = Default_UserId_Value;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    [dic setObject:@"F10055" forKey:@"TrCd"];
    [dic setObject:userId forKey:KEY_userId];
    [dic setObject:CHlCdNumber_value forKey:KEY_ChlCd];
    NSString *currentTime = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    [dic setObject:currentTime forKey:KEY_TrTime];
    [dic setObject:@"ALL" forKey:@"bizType"];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@",@"F10055",CHlCdNumber_value,currentTime,Default_UserId_Value,DefaultSecretKeyValue_Business];
    [dic setObject:GET_SIGN(sign) forKey:@"MAC"];
    [dic setObject:@"1000" forKey:@"pageSize"];//每一页记录数,默认30 当pageSize和pageNum不为空，按用户传的返回,比如200条记录
    //    [dic setObject:@"30" forKey:@"cdDate"];//默认30天的数据
    [dic setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"pageNum"];//当前页 默认是1
    [formRequest setTimeOutSeconds:30];
    
    [DJYBaseNetworkHelp createPostURL:dic request:formRequest];
    
    [formRequest setCompletionBlock:^{
        
        NSData *data =[formRequest responseData];
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:@"RSPCOD"];
            CCLog(@"结果码为%@",resultCode);
            if ([resultCode isEqualToString:@"00000"]) {
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            }
            
        }
        else{
            CCLog(@"解析有错误");
            if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                [delegate requestDidFinishedWithFalseMessage:dic];
            }
            
        }
        
    }];
    
    [formRequest setFailedBlock:^{
        
        if (delegate &&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            
            [delegate requestDidFailed:nil];
        }
        
    }];
    
    [formRequest startAsynchronous];
    
}

#pragma mark - 获取信息
+(NSString *) getRightString_BysortArray_dic:(NSDictionary *) dic{
    
    CCLog(@"aaaaawuliao");
    
    NSMutableString *rightString =[NSMutableString stringWithString:@""];
    
    NSArray *_sortedArray= [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    //CCLog(@"未排序:%@",_sortedArray);
    
    for (NSString *key in _sortedArray) {
        
        [rightString appendFormat:@"%@",[dic objectForKey:key]];
    }
    
    return [rightString stringByAppendingFormat:@"%@",ZFT_otherSecret];
    
}

+ (void) getInfo:(NSString *) versions andDelegate:(id<ServiceDelegate>) delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
        
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Info_Name]];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];

    [dic setObject:Default_UserMobile_Value forKey:@"mobile"];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:versions forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.user.qry" forKey:KEY_service_type];
        
    NSString *signTmp =[self getRightString_BysortArray_dic:dic];
    
    CCLog(@"[[UIDevice currentDevice]  systemName]=%@",[[UIDevice currentDevice]  systemName]);
    
    [formRequst setPostValue:Default_UserMobile_Value forKey:@"mobile"];
        
    [formRequst setPostValue:@"icardpay.app.user.qry" forKey:KEY_service_type];
    
    [formRequst setPostValue:versions forKey:KEY_version];
    
    [formRequst setPostValue:kJXT_appkey_value forKey:KEY_app_key];
    
    [formRequst setPostValue:GET_SIGN(signTmp) forKey:KEY_sign];
    
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            }
        }
        else{
            CCLog(@"解析有错误");
            if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                [delegate requestDidFinishedWithFalseMessage:dic];
            }
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        SHOW_AlertViewWith_WrongNetWorkMessage;
        if (delegate &&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:dic];
        }
        
    }];
    
    [formRequst startAsynchronous];
    
}
+ (void)getUserAccountwithMobile:(NSString *)mobileNum   BalancDelegate:(id<ServiceDelegate>) delegate{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:ZFT_version_Value forKey:KEY_version];
    
    [dic setObject:kJXT_accbalance_type forKey:KEY_service_type];
    
    [dic setObject:mobileNum forKey:@"mobile"];
    [dic setObject:Default_Phone_Imei forKey:kJXT_imei];
    [dic setObject:Default_PhoneInfo_Value  forKey:kJXT_phone_info];
    [dic setObject:@"gps" forKey:kJXT_gps];
    
    CREATE_POST_URL(dic, formRequst);
    
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            }
            
        }
        else{
            CCLog(@"解析有错误");
            if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                [delegate requestDidFinishedWithFalseMessage:dic];
            }
            
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        SHOW_AlertViewWith_WrongNetWorkMessage;
        if (delegate &&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:dic];
        }
        
    }];
    
    [formRequst startAsynchronous];
}

+ (void) getUserStatus:(NSString *)userIden andDelegate:(id<ServiceDelegate>) delegate{
    
    __weak ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:GET_RIGHT_URL_WITH_Index(@"F10216.front")]];
    formRequest.stringEncoding = NSUTF8StringEncoding;
    NSString *userId = Default_UserId_Value;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    [dic setObject:@"F10216" forKey:@"TrCd"];
    [dic setObject:userId forKey:KEY_userId];
    [dic setObject:CHlCdNumber_value forKey:KEY_ChlCd];
    NSString *currentTime = [DJYUilityHelper getCurrentTimeWithSpecialFormat];
    [dic setObject:currentTime forKey:KEY_TrTime];

    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@",@"F10216",CHlCdNumber_value,currentTime,Default_UserId_Value,DefaultSecretKeyValue_Business];
    [dic setObject:GET_SIGN(sign) forKey:@"MAC"];
    
    [formRequest setTimeOutSeconds:30];
    [DJYBaseNetworkHelp createPostURL:dic request:formRequest];
    
    [formRequest setCompletionBlock:^{
        
        NSData *data =[formRequest responseData];
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            CCLog(@"json解析格式正确");
            NSString *resultCode =[dic objectForKey:@"RSPCD"];
            
            CCLog(@"结果码为%@",resultCode);
            
            if ([resultCode isEqualToString:@"00"]) {
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            }
            
        }
        else{
            CCLog(@"解析有错误");
            if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                [delegate requestDidFinishedWithFalseMessage:dic];
            }
            
        }
        
    }];
    
    [formRequest setFailedBlock:^{
        
        if (delegate &&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:dic];
        }
        
    }];
    
    [formRequest startAsynchronous];

}

+ (void)getUserInfowithMobile:(NSString *)mobileNum andDelegate:(id<ServiceDelegate>) delegate{
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    __block NSString *message = nil;
    
    __weak ASIFormDataRequest *formRequst = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASE_Domain_Name]];
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    
    [dic setObject:kJXT_appkey_value forKey:KEY_app_key];
    
    [dic setObject:ZFT_newversion_Value forKey:KEY_version];
    
    [dic setObject:@"icardpay.app.user.qry" forKey:KEY_service_type];
    
    [dic setObject:mobileNum forKey:@"mobile"];
    
    CREATE_POST_URL(dic, formRequst);
    
    [formRequst setRequestMethod:@"POST"];
    
    [formRequst setCompletionBlock:^{
        
        NSData *data =[formRequst responseData];
        NSString *temp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
        
        CCLog(@"网络返回的数据为：%@",temp);
        
        NSError *error = nil;
        
        NSDictionary *dic = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
        
        if (!error) {
            
            CCLog(@"json解析格式正确");
            
            NSString *resultCode =[dic objectForKey:KEY_resultCode];
            
            message = [[dic objectForKey:KEY_message] URLDecodedString];
            
            CCLog(@"结果码为%@",resultCode);
            
            CCLog(@"服务器返回的信息为：%@",message);
            
            if ([resultCode isEqualToString:@"0000"]) {
                
                if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithRightMessage:)]) {
                    [delegate requestDidFinishedWithRightMessage:dic];
                }
            }
            
        }
        else{
            CCLog(@"解析有错误");
            if (delegate &&[delegate respondsToSelector:@selector(requestDidFinishedWithFalseMessage:)]) {
                [delegate requestDidFinishedWithFalseMessage:dic];
            }
            
        }
        
    }];
    
    [formRequst setFailedBlock:^{
        
        SHOW_AlertViewWith_WrongNetWorkMessage;
        if (delegate &&[delegate respondsToSelector:@selector(requestDidFailed:)]) {
            [delegate requestDidFailed:dic];
        }
        
    }];
    
    [formRequst startAsynchronous];

}

@end

