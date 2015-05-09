//
//  TipConfigure.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/10/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#ifndef MyFlight2_0_TipConfigure_h
#define MyFlight2_0_TipConfigure_h

#import"UIQuickHelp.h"

#define AlertView_Title_Message @"提示"

//密码输入规则提示语
#define Pwd_Rule_Alert_Message @"密码应为6-20位数字或英文字符"

//确认按钮 文字提示
#define Ok_ButtonTitle_Alert_Message  @"知道了"

#define WRONG_Message_NetWork @"您的网络不给力哦，请稍后再试"

#define OUTTIME_Message_NetWork @"网络请求失败"

//#define SHOW_AlertViewWith_WrongNetWorkMessage if (ISShowAlertView_InNetworkRequest)/ 
//{[UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:WRONG_Message_NetWork delegate:nil \cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil];}

#define SHOW_AlertViewWith_WrongNetWorkMessage [UIQuickHelp showAlertViewWithTitle:AlertView_Title_Message message:WRONG_Message_NetWork delegate:nil cancelButtonTitle:Ok_ButtonTitle_Alert_Message otherButtonTitles:nil]

#define SHOW_AlertViewWith_Message(message) [UIQuickHelp showAlertViewWithMessage:(message)]

#endif
