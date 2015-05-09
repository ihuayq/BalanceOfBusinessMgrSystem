//
//  LoginViewController.h
//  jxtuan
//
//  Created by 融通互动 on 13-8-19.
//  Copyright (c) 2013年 aaa. All rights reserved.
//


#import "HP_BaseViewController.h"
#import "HP_Common4IOS.h"
#import "HP_UITextField.h"

@interface LoginViewController : HP_BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    HP_UITextField * nameTextField;
    HP_UITextField * passwordTextField;
}

@property(nonatomic,retain)HP_UITextField * nameTextField;
- (void)setUserName:(NSString *)name;
@end
