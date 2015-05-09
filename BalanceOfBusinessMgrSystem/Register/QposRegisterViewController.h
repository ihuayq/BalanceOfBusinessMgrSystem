//
//  QposRegisterViewController.h
//  AllBelieve
//
//  Created by tsmc on 14-3-20.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "HP_BaseViewController.h"
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

@interface QposRegisterViewController : HP_BaseViewController <UITextFieldDelegate>
{
    NSMutableDictionary* transferDict;
    NSMutableDictionary *dataDict;
    
    
    HP_UITextField * telTextField;
    HP_UITextField * passwordTextField;
    HP_UITextField * passCodeTextField;
    
    UIButton *sendCheckCodeButton;
    UILabel * sendCheckCodeLabel;
    int jishuqi;
    NSTimer* timer;
    NSString* returnCodeSTring;//服务器返回
    
    UIButton *selectButton;
    BOOL isSelectAgreement;
}

@property(nonatomic,retain)NSMutableDictionary* transferDict;
@property(nonatomic, assign)LoginViewController *loginVC;

@end
