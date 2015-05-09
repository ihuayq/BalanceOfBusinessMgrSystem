//
//  DJYAnimationFactory.h
//  ipaycard
//
//  Created by Davidsph on 6/6/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DjyBaseView.h"
#import "DjyPluginAniView.h"
#import "DjyGetDeviceInfoAniView.h"
#import "DjyReadCardAniView.h"
#import "DjyInputPwdAniView.h"

#import "DJYICPluginInAniView.h"
#import "DJYICReadCardInfoAniView.h"
#import "DJYICSignInAniView.h"
#import "DJYICPluginICCardAniView.h"
#import "DJYReWriteCardDataAniView.h"
#import "GiftPluginCardAniType.h"



//动画类型 
enum AnimationType {
    
    DJY_PluginAniType = 0, //插入动画 
    DJY_GetDeviceInfoAniType = 1, //获取设备信息动画 
    DJY_ReadCardInfoAniType = 2, //刷卡动画
    DJY_InputPWDAniType = 3, //输入密码动画
    
    DJY_IC_PluginaAniType = 4, //IC卡插入刷卡器动画
    
    DJY_IC_SignInAniType = 5, //IC卡获取设备信息签到动画
    
    DJY_ICPluginICCardAniType = 6, //IC卡插入IC卡购电动画
    
    DJY_IC_ReadCardAniType = 7, //IC卡扫描卡片动画
    
    DJY_IC_REWriteCardAniType = 8, //IC卡补写卡动画
    
    Gift_PluginaAniType = 9, //礼品卡插入刷卡器动画
    
    Gift_SignInAniType = 10, //获取设备信息签到动画

    Gift_PluginCardAniType = 11, //礼品卡刷卡动画

    Gift_ReadCardAniType = 12, //礼品卡处理卡信息


};

//设备类型 
enum DeviceType {
    ZFT_I_TYPE = 0,
    ZFT_S_TYPE = 1
};

enum BusType {
    ICBus = 0,
    PBOCBus = 1,
    ETCBus = 2,
    GiftBus = 3,
    PTBus = 4
};


@interface DJYAnimationFactory : NSObject


+(DjyBaseView *) getAnimationViewByAniType:(enum AnimationType)type  deviceType:(enum DeviceType) deviceType withFrame:(CGRect )frame andBusType:(enum BusType)busType;


@end
