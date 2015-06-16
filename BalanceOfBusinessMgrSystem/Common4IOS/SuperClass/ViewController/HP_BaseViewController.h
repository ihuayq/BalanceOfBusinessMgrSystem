//
//  HP_BaseViewController.h
//  shise
//
//  Created by Yi Xu on 12-10-30.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//



@protocol PopViewControllerDelegate <NSObject>

-(void)onPopViewControllerDelegate:(NSMutableDictionary *)dictionary fromViewController:(UIViewController *)viewController;

@end

#import <UIKit/UIKit.h>
#import "FMBaseViewController.h"

#define NAVIGATION_OUTLET_HEIGHT self.navigation.frame.origin.y+ self.navigation.frame.size.height

@interface HP_BaseViewController : FMBaseViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,PopViewControllerDelegate>
{
@private
    NSMutableDictionary *passNameValuePair;
    
    UIAlertView *progressView;
    
}

//传送数据Dictionary
@property (strong, nonatomic) NSMutableDictionary *passNameValuePair;

//返回数据代理
@property(nonatomic,assign) NSObject<PopViewControllerDelegate> *delegate;

@property (strong, nonatomic) UIAlertView *progressView;;

//获得屏幕Rect
-(CGRect) getScreenRect;

//获得屏幕Size
-(CGSize) getScreenSize;

//获得屏幕缩放比例，360/480
-(CGFloat) getScreenScale;

//简单的系统提示框
-(void)showSimpleAlertViewWithTitle:(NSString *)title alertMessage:(NSString *)msg cancelButtonTitle:(NSString *) cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(void)showSimpleAlertViewWithTitle:(NSString *)title tag:(int)tag alertMessage:(NSString *)msg cancelButtonTitle:(NSString *) cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

//简单的debug提示框
-(void)showDebugAlertViewWithMessage:(NSString *)msg isContinue:(BOOL) isContinue;

//简单的加载提示框
-(void)showSimpleProgressViewWithMessage:(NSString *)msg;

-(void)showProgressViewWithMessage:(NSString *)msg;

-(void)showMBProgressHUDWithMessage:(NSString *)msg;
-(void)hidMBProgressHUD;

//获得NSUserDefaults对象
-(NSUserDefaults *)getNSUserDefaults;

//打印日志
-(void)logMessage:(NSString *)msg;
//删除null
-(NSString*)delStringNull:(id)object;
//清除字典里的null 空字符
-(NSMutableDictionary* )delStringNullOfDictionary:(NSDictionary *)object;



- (BOOL)checkStringIs:(NSString *)str withmessage:(NSString *)message;

//验证姓名
- (BOOL)checkName:(NSString *)str;
//验证身份证
- (BOOL)checkshenfenzhengString:(NSString *)str;
//验证手机号
- (BOOL)checkMobileString:(NSString *)string;
//验证密码
- (BOOL)checkPassWordString:(NSString *)str;

//验证邮箱
- (BOOL)checkEmailString:(NSString *)EmailString;

//验证邮编
- (BOOL)checkPostcodeString:(NSString *)string;

- (BOOL)checkPassCode:(NSString *)str;
@end

