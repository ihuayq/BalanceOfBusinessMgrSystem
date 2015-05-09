//
//  ExitAlert.h
//  ipaycard
//
//  Created by fei on 13-4-8.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ServiceDelegate.h"

@protocol ExitAlertDelegate <NSObject>
@optional
- (void)alertV:(UIAlertView *)alertV clickedBtnAtIndex:(NSInteger)btnIndex;
@end

@interface ExitAlert : UIAlertView<UITextFieldDelegate, ServiceDelegate>{
    id EADelegate;
    NSUserDefaults *userinfo;
}
@property (nonatomic) id EADelegate;
@property(nonatomic, retain) UITextField* firstPwd;
@property(nonatomic, retain) UITextField* secondPwd;
@property(nonatomic, retain) UILabel *temLabel;
@property(nonatomic, retain) UIButton *temBtn;
@property(nonatomic, retain) UIButton *cacelBtn;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... ;
@end
