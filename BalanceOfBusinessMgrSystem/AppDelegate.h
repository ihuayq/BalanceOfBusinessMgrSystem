//
//  AppDelegate.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/5.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
{
    UINavigationController * nc;
    LoginViewController * login;
    
    
    UIScrollView* topScrollView;
    UIPageControl* topPageControl;
    int currentPage;
    HP_UIImageView* bigSquareImageView;
    
    NSString* loginStatusString;
    NSMutableDictionary* userDict;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)LoginViewController * login;

- (NSMutableDictionary*)parseURL:(NSString *)urlStr;
@end

