//
//  ForgetPassword2ViewController.h
//  jxtuan
//
//  Created by 融通互动 on 13-10-18.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "HP_BaseViewController.h"
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

@interface ForgetPassword2ViewController : HP_BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    NSMutableDictionary* transmitDict;//传递过来的参数
    
    
    HP_UITextField * passwordTextField;
    HP_UITextField * passwordTextField2;
    
   
}

@property(nonatomic,retain)NSMutableDictionary* transmitDict;

@end
