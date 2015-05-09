//
//  DJYAnimationFactory.m
//  ipaycard
//
//  Created by Davidsph on 6/6/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYAnimationFactory.h"

#import "BaseViewController.h"

//支付界面 动画
#define ALL_PAY_FRAME CGRectMake(16, -10, 50, 30)

//IC购电部分动画
#define ALL_IC_FRAME  CGRectMake(25,iOS7?118:98 , 275, 250) 

//PBOC部分动画
#define ALL_PBOC_FRAME  CGRectMake(25,iOS7?93:(iPhone5?73:53), 275, 250) //29 9

//Gift动画
#define Gift_FRAME  CGRectMake(25, 0, 275, 250)


@implementation DJYAnimationFactory

+ (DjyBaseView *) getAnimationViewByAniType:(enum AnimationType) type  deviceType:(enum DeviceType)deviceType withFrame:(CGRect)frame andBusType:(enum BusType)busType{
    
    
    DjyBaseView *baseAnimationView = nil;
    
    switch (type) {
            
        case DJY_PluginAniType:
            
            baseAnimationView = [[DjyPluginAniView alloc] initWithFrame:ALL_PAY_FRAME animationtype:deviceType];
            
            break;
            
        case DJY_GetDeviceInfoAniType:
            
            baseAnimationView = [[DjyGetDeviceInfoAniView alloc] initWithFrame:ALL_PAY_FRAME animationtype:deviceType];
            break;
            
        case DJY_ReadCardInfoAniType:
            
            baseAnimationView =[[DjyReadCardAniView alloc] initWithFrame:CGRectMake(15, 0, 66, 54) animationtype:deviceType];
            
            break;
        case DJY_InputPWDAniType:
            baseAnimationView = [[DjyInputPwdAniView alloc] initWithFrame:CGRectMake(19, 11, 62, 52)];
            break;
            
        case DJY_IC_PluginaAniType: //插入刷卡器
            if (busType == 1) {
                baseAnimationView = [[DJYICPluginInAniView alloc]initWithFrame:ALL_PBOC_FRAME animationtype:ZFT_S_TYPE andBusType:busType];
            }else if(busType == 4){
                baseAnimationView = [[DJYICPluginInAniView alloc] initWithFrame:frame animationtype:deviceType andBusType:busType];
            }else{
                baseAnimationView = [[DJYICPluginInAniView alloc] initWithFrame:ALL_IC_FRAME animationtype:ZFT_S_TYPE];
            }
            break;
        case DJY_IC_ReadCardAniType: //读取卡信息
            if (busType == 1) {
                baseAnimationView  =[[DJYICReadCardInfoAniView alloc] initWithFrame:ALL_PBOC_FRAME animationtype:ZFT_S_TYPE andBusType:busType];
            }else{
                baseAnimationView  =[[DJYICReadCardInfoAniView alloc] initWithFrame:ALL_IC_FRAME animationtype:ZFT_S_TYPE andBusType:busType];
            }
            break;
        case DJY_IC_SignInAniType: //签到
            if (busType == 1) {
                baseAnimationView = [[DJYICSignInAniView alloc] initWithFrame:ALL_PBOC_FRAME animationtype:ZFT_S_TYPE];
            }else if(busType == 4){
                baseAnimationView = [[DJYICSignInAniView alloc] initWithFrame:frame animationtype:deviceType andBusType:busType];
            }else{
                baseAnimationView = [[DJYICSignInAniView alloc] initWithFrame:ALL_IC_FRAME animationtype:ZFT_S_TYPE];
            }
            break;
        case DJY_ICPluginICCardAniType: //插入ic卡
            if (busType == 1) {
                baseAnimationView = [[DJYICPluginICCardAniView alloc] initWithFrame:ALL_PBOC_FRAME animationtype:ZFT_S_TYPE andBusType:busType];
            }else{
                baseAnimationView = [[DJYICPluginICCardAniView alloc] initWithFrame:ALL_IC_FRAME animationtype:ZFT_S_TYPE andBusType:busType];
            }

            break;
        case  DJY_IC_REWriteCardAniType: //写卡
        {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DJYReWriteCardDataAniView" owner:nil options:nil];
            baseAnimationView = [array objectAtIndex:0];
            [baseAnimationView changeBackImage:busType];
            baseAnimationView.frame = ALL_IC_FRAME;
            break;
        }
            
        case Gift_PluginaAniType: //插入刷卡器
        {
            if (deviceType == ZFT_S_TYPE) {
                baseAnimationView = [[DJYICPluginInAniView alloc] initWithFrame:Gift_FRAME animationtype:ZFT_S_TYPE];
            }else{
                baseAnimationView = [[DJYICPluginInAniView alloc] initWithFrame:Gift_FRAME animationtype:ZFT_I_TYPE];
            }

            break;
        }
        case Gift_SignInAniType: //签到
        {
            if (deviceType == ZFT_S_TYPE) { //ALL_IC_FRAME
                baseAnimationView = [[DJYICSignInAniView alloc] initWithFrame:Gift_FRAME animationtype:ZFT_S_TYPE];
            }else{
                baseAnimationView = [[DJYICSignInAniView alloc] initWithFrame:Gift_FRAME animationtype:ZFT_I_TYPE];
            }
            break;
        }
        case Gift_PluginCardAniType: //刷卡
        {
            if (busType == 4 ) {
                baseAnimationView = [[GiftPluginCardAniType alloc]initWithFrame:frame animationtype:deviceType andBusType:busType];
            }else{
                if (deviceType == ZFT_S_TYPE) {  //GiftPluginCardAniType DJYICPluginICCardAniView
                    baseAnimationView = [[GiftPluginCardAniType alloc]initWithFrame:Gift_FRAME animationtype:ZFT_S_TYPE];
                }else{
                    baseAnimationView = [[GiftPluginCardAniType alloc]initWithFrame:Gift_FRAME animationtype:ZFT_I_TYPE];
                }
            }
            break;
        }
        case Gift_ReadCardAniType:  //获取卡信息
        {
            baseAnimationView = [[DJYICReadCardInfoAniView alloc]initWithFrame:Gift_FRAME animationtype:ZFT_I_TYPE];

            break;
        }
            
        default:
            break;
    }
    
        
    return baseAnimationView;
    
}




@end
