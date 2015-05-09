//
//  DJYDebugSettingConfigure.h
//  ipaycard
//
//  Created by Davidsph on 4/8/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#ifndef ipaycard_DJYDebugSettingConfigure_h
#define ipaycard_DJYDebugSettingConfigure_h

//设置网络请求是否 自动显示 alertview的开关 1 自动提示 0 手动

#define ISShowAlertView_InNetworkRequest 0

//是否 用测试数据 来请求网络  1表示模拟数据  0 表示真实数据
#define IsCeshiData 0

//是否显示 内部调试信息  1 显示 0 不显示
#define IsShowNativeDebugLog 0

//是否显示 业务有关调试信息

#define IsShowBusinessDebugLog 0

//测试用的 身份账号 
#define IDCardNnum_debug @"110101201301019337"

#endif
