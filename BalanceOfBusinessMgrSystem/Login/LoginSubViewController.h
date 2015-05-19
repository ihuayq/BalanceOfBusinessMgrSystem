//
//  LoginSubViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/18.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_Common4IOS.h"
#import "HP_UITextField.h"

@interface LoginSubViewController : HP_BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    HP_UITextField * nameTextField;
    HP_UITextField * passwordTextField;
}

@end
