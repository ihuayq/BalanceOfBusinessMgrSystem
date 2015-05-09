//
//  SetPayMoneyPasswordViewController.h
//  AllBelieve
//
//  Created by fengxiaoguang on 14-3-9.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import "HP_BaseViewController.h"
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"
@interface SetPayMoneyPasswordViewController : HP_BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    NSMutableDictionary* transmitDict;//传递过来的参数
    
    
    HP_UITextField * passwordTextField;
    HP_UITextField * passwordTextField2;
    
    
}

@property(nonatomic,retain)NSMutableDictionary* transmitDict;

@end