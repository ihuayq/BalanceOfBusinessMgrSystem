//
//  BMCreateTransactionpPasswordViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/19.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

#pragma 设置交易密码
@interface BMCreateTransactionpPasswordViewController :HP_BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
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
