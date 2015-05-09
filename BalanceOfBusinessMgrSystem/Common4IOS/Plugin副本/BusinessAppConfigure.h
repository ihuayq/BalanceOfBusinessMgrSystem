//
//  BusinessAppConfigure.h
//  ipaycard
//
//  Created by Davidsph on 4/9/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#ifndef ipaycard_BusinessAppConfigure_h
#define ipaycard_BusinessAppConfigure_h


#define KEY_TrCd @"TrCd"  //交易代码

#define KEY_ChlCd @"ChlCd" //渠道代码 

#define KEY_userId @"userId" //用户ID 

#define KEY_TrTime @"TrDt" //交易时间

#define KEY_OrderNo @"prdOrdNo" //产品订单号

#define CHlCdNumber_value @"00000001"//000001

#define UserID_CeshiValue @"12071200001"

#define UserID_UATValue @"12110700001"

#define UserID_CeshiOrderId @"0313041000000023"

#define KEY_IsSuccess @"isSuccess"

//获取的订单号 key 订单支付的时候需要  

#define KEY_ProductId @"PRDORDNO"

//获取手续费时用到的参数

#define KEY_PRORATE @"PRORATE"

//业务接口 返回标识码 信息

#define KEY_resultCode_Business @"RSPCD"

#define KEY_message_Business @"RSPMSG" 

/*******
 
 刷卡器相关 
 
 ********/

#define KEY_Card_phoneID @"phoneID"

#define GET_Card_phoneID_Vlaue


#define  Default_UserName_Value [[NSUserDefaults standardUserDefaults] stringForKey:KEY_Default_AccountName]
#define Default_UserMobile_Value [[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_MOBILE]

#define Default_PhoneInfo_Value [NSString stringWithFormat:@"phoneInfo [os=%@, phone_type=%@, screen_size=%.0f*%.0f, is_jailbreak=false, app_type=iOS, app_version=%@]",[UIDevice currentDevice].systemVersion,[UIDevice currentDevice].model,MainWidth*2,2*MainHeight,[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]


//#define Default_Phone_Imei [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"imei"]]

#define Default_UserBalance [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"balance"]]


#endif
