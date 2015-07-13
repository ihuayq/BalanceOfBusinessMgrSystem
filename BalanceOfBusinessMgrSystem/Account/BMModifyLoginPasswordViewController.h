//
//  BMModifyLoginPasswordViewController.h
//  BalanceOfBusinessMgrSystem_1.1.0
//
//  Created by huayq on 15/7/13.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBaseViewController.h"
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

@interface BMModifyLoginPasswordViewController : HP_BaseViewController{
    HP_UITextField * passwordTextField;
    HP_UITextField * passwordTextField2;
    HP_UITextField * passCodeTextField3;
    HP_UIButton *sendCheckCodeButton;
    HP_UITextField *oldPasswordTextField;
}

@end
