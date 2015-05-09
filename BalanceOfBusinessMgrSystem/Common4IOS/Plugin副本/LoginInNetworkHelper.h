//
//  LoginInNetworkHelper.h
//  ipaycard
//
//  Created by Davidsph on 4/6/13.
//  Copyright (c) 2013 han bing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJYBaseNetworkHelp.h"

@interface LoginInNetworkHelper : DJYBaseNetworkHelp


//用户是否注册 查询 ok 

+ (void) isRegeisterWithMobile:(NSString *) mobile  andDelegate:(id<ServiceDelegate>) delegate;


//登录 操作 
+ (void) loginWithPassWd:(NSString *) passwd  andDelegate:(id<ServiceDelegate>) delegate;


//注册  
+ (void) registerWithName:(NSString *) name idCard:(NSString *) idCard yaCode:(NSString *)yzCode LoginP:(NSString *)loginPass PayP:(NSString *)payPass andDelegate:(id<ServiceDelegate>) delegate;

//用户设置密码
+ (void) setPassWd:(NSString *) pwd andDelegate:(id<ServiceDelegate>) delegate;


//获取验证码
+ (void) getSecretCodeWithMobile:(NSString *)receivedMobile  With:(NSString *)smsType andDelegate:(id<ServiceDelegate>) delegate;

//修改支付 登录密码
+ (void) changePwdWith:(NSString *) oldPwd  NewPwd:(NSString *)newpwd   yaCode:(NSString *)yaCode  PwdType:(NSString *)pwdtype SmsType:(NSString *)smstype andDelegate:(id<ServiceDelegate>) delegate;

//找回密码 即设置新密码 ok 
+ (void) updatePassWdWithNewPasswd:(NSString *) newPasswd  yaCode:(NSString *)yaCode  CredNum:(NSString *)credNum PwdType:(NSString *)pwdtype  SmsType:(NSString *)smstype andDelegate:(id<ServiceDelegate>) delegate;

+ (void) updateVersions:(NSString *) versions  andDelegate:(id<ServiceDelegate>) delegate;
//获取版本信息
+ (void) getInfo:(NSString *) versions andDelegate:(id<ServiceDelegate>) delegate;

//第一次登陆获取网络数据
+ (void)requestTradeHistoryListDataWithMobile:(NSString *)mobile
                                      pageNum:(int)pageNum andDelegate:(id<ServiceDelegate>) delegate;

//获取用户数据
+ (void) getUserStatus:(NSString *)userIden andDelegate:(id<ServiceDelegate>) delegate;

//获取用户的可用余额
+ (void)getUserAccountwithMobile:(NSString *)mobileNum   BalancDelegate:(id<ServiceDelegate>) delegate;

//获取用户信息
+ (void)getUserInfowithMobile:(NSString *)mobileNum andDelegate:(id<ServiceDelegate>) delegate;

@end
