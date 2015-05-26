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
    HP_UITextField * passwordTextField;
    HP_UITextField * passwordTextField2;
    HP_UITextField * passCodeTextField3;
    HP_UIButton *sendCheckCodeButton;
    
    
    int nCout;
    NSTimer* timer;
}

@property(nonatomic,assign) BOOL type;//0表示创建，1表示忘记
@property(nonatomic,strong)UILabel *sendLabel;
@property(nonatomic,strong) NSString *title;

//@property(nonatomic,retain)NSMutableDictionary* transmitDict;

@end
