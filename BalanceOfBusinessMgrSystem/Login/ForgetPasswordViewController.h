//
//  ForgetPasswordViewController.h
//  jxtuan
//
//  Created by 融通互动 on 13-8-20.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "HP_BaseViewController.h"
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

@interface ForgetPasswordViewController : HP_BaseViewController<UITextFieldDelegate>
{
    HP_UITextField * telTextField;
    
    //验证码
    HP_UITextField * passCodeTextField;
    
    //密码确认
    HP_UITextField * passwordTextField;
    HP_UITextField * passwordTextField2;
    
    
    
    UIButton *sendCheckCodeButton;
    UILabel * sendCheckCodeLabel;
    int nCout;
    NSTimer* timer;
}

@end
