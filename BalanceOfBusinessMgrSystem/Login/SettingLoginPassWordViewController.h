//
//  SettingLoginPassWordViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/6.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//


#import "FMBaseViewController.h"
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"
@class HP_UITextField;

@interface SettingLoginPassWordViewController : HP_BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    NSMutableDictionary* transmitDict;//传递过来的参数
    
    
    HP_UITextField * passwordTextField;
    HP_UITextField * passwordTextField2;
    HP_UITextField * passCodeTextField3;
    HP_UIButton *sendCheckCodeButton;
    
    
    
}

@property(nonatomic,strong)UILabel *sendLabel;
@property(nonatomic,retain)NSMutableDictionary* transmitDict;

@end