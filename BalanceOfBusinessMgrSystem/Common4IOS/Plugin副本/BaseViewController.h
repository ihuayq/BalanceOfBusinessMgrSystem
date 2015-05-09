//
//  BaseViewController.h
//  ipaycard
//
//  Created by han bing on 13-1-3.
//  Copyright (c) 2013年 han bing. All rights reserved.
//


#define NOTOPENSHOWMSG  @"该功能尚未开放，敬请期待。"    //未开放功能提示

#import <UIKit/UIKit.h>
#import "KeyBoardBar.h"
#import "ATMHud.h"
#import "navItem.h"
#import "cardSwipeAlertView.h"
#import "WebUrl.h"
#import "Util.h"
#import "AutherInfo.h"
//#import "AlipayPayOrder.h"
#import "MobileRechargeOrder.h"
//#import "AlipayRechargeOrder.h"
#import "SysInfo.h"
#import "VCControl.h"
#import "TradeDetail.h"
#import "BussArray.h"
#import "iConsole.h"
#import "JSONKit.h"
#import "RCLabel.h"

#import "UncaughtExceptionHandler.h"
#import "NdUncaughtExceptionHandler.h"
#import "ZftQiposLib.h"
//#import "SwiperDelegate.h"

#define TRDTYPEMOBILE @"手机充值"
#define TRDTYPEALIPAYPAY @"支付宝订单支付"
#define TRDTYPEALIPAYRECHARGE @"支付宝充值"

@interface BaseViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,CardSwipeDelegate>
{
    BussArray *bussBaseType;

    KeyBoardBar *kbBar;
    BOOL keybaordVisible;
    UITextField *currentTxtF;
    ATMHud *hud;
    navItem *navItemView;
    cardSwipeAlertView *swipeShow;
    NSString *curNavImageName;
}

-(void) showWaitAnimation;
-(NSDictionary *) netCommit:(NSURL *) requestUrl;
-(NSMutableDictionary *) setCommitParameter:(NSMutableDictionary *) paramDict;
- (void)setBarTitle:(NSString*)title;

@end
