//
//  PublicConfigure.h
//  ipaycard
//
//  Created by Davidsph on 4/6/13.
//  Copyright (c) 2013 han bing. All rights reserved.
//

#ifndef ipaycard_PublicConfigure_h
#define ipaycard_PublicConfigure_h

#import "DNWrapper.h"


//记录用户是否是 设置过密码

#define KEY_ISUser_SettingPwd @"issettingPwd"

#define Default_ISUser_SettingPwdValue  [[NSUserDefaults standardUserDefaults] boolForKey:KEY_ISUser_SettingPwd]


//当前系统版本
#define CURRENT_SYSTEM_VERSION [UIDevice currentDevice].systemVersion


#define APP_ScreenHeight [[UIScreen mainScreen] bounds].size.height  //屏幕高度

#define APP_ScreenWidth [[UIScreen mainScreen] bounds].size.width //屏幕宽度


#define APP_StateBarHeight 20.000000  //状态栏高度

#define APP_NavgationBarHeight 44.000000 //导航栏高度

#define APP_MainHeight  APP_ScreenHeight-APP_StateBarHeight //主高度

#define APP_MainWidth APP_ScreenWidth //主宽度

#define  APP_MainHeight_withNavBar APP_MainHeight-APP_NavgationBarHeight

#define APP_Version  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


//判断是否是iphone5 手机

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iOS7 (CURRENT_SYSTEM_VERSION.doubleValue >= 7.0)

/*******

 获取 网络访问相关 公用参数  
 ********/


#define ZFT_otherSecret @"9964DYByKL967c3308imytCB"

#define ZFT_version_Value @"1.0"

#define ZFT_newversion_Value @"2.0"

#define KEY_app_key @"app_key"  //接入方编号

#define KEY_version  @"version" //版本号

#define KEY_service_type @"service_type"

#define KEY_system @"app_system"

#define KEY_sign @"sign" //接口名称

//#define GET_SIGN(string)  [DNWrapper getMD5String:string]

#define GET_SIGN(string)  [DNWrapper md5:(string)]

#define GET_3DES(string) [DNWrapper encrypt:string]

//网络拼接参数 
#define CREATE_POST_URL(PARAMDic,formRequst) [DNWrapper createPostURL:dic request:formRequst]

//公共返回结果字段标志

#define KEY_result  @"result"
#define KEY_resultCode  @"rsp_code" //返回码
#define KEY_message @"rsp_msg" //返回描述

#define KEY_back @"RSPCD" //返回状态
#define KEY_orders @"ORDERS" //list 数据

//用户相关

#define KEY_Default_Version @"inside_version"  //账号名字  供显示用 用户输入什么 记录什么

#define KEY_Default_AccountName @"userName"  //账号名字  供显示用 用户输入什么 记录什么

#define KEY_Default_Password @"user_password"  //账号密码 用户输入的密码

#define KEY_Default_MemberId @"user_memberId" //用户id 交易的时候 会使用 


#define KEY_Default_IsUserLogin @"isUser_Login"  //用户是否已经登录

#define KEY_Default_IsRememberPwd @"isRememberPwd" //是否记住密码

#define KEY_Default_UserMobile @"userMobile" //手机号

#define KEY_Default_IdCardNo @"idCardNo" //身份证

#define KEY_Default_IsAuth @"isAuthorized" //是否认证身份证
#define kEY_IS_Forece_Pwd  @"is_force_pwd"

#define KEY_Default_Code @"user_code" //用户code
#define KEY_Default_Token  @"userToken" //token

#define KEY_Test_UserId  @"12071200001" //token  13012100001  12071200001

#define  KEY_AuthorCode  @"authorCode"

//#define Default_UserMobile_Value [[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_MOBILE]

//用户是否已经登录
#define Default_IsUserLogin_Value  [[NSUserDefaults standardUserDefaults] boolForKey:KEY_Default_IsUserLogin]
//用户token
//#define Default_Token_Value [[NSUserDefaults standardUserDefaults] stringForKey:KEY_Default_Token]

#define Default_UserId_Value [[NSUserDefaults standardUserDefaults] stringForKey:KEY_Default_MemberId]

#define Default_isAuth_Value [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Default_IsAuth]


#endif
