//
//  HP_BaseTabBarController.h
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//



#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )



#import <UIKit/UIKit.h>

@interface HP_BaseTabBarController : UITabBarController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
@private
    NSMutableDictionary *passNameValuePair;
    
    UIAlertView *progressView;
    
}

//传送数据Dictionary
@property (strong, nonatomic) NSMutableDictionary *passNameValuePair;

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

-(void)hideTabBar;

-(void)showMBProgressHUDWithMessage:(NSString *)msg;
-(void)hidMBProgressHUD;

//获得NSUserDefaults对象
-(NSUserDefaults *)getNSUserDefaults;

//向NSUserDefaults对象存入NSMutableDictionary
-(void) setDictionaryForNSUserDefaults:(NSMutableDictionary *) dictionary forKey:(NSString *)key;

//向NSUserDefaults对象存入id
-(void) setObjectForNSUserDefaults:(id) object forKey:(NSString *)key;

//向NSUserDefaults对象存入NSString
-(void) setStringForNSUserDefaults:(NSString *) string forKey:(NSString *)key;

//从NSUserDefaults获得id对象
-(id) getObjectFromNSUserDefaultsForKey:(NSString *)key;

//从NSUserDefaults获得NSString对象
-(NSString *) getStringFromNSUserDefaultsForKey:(NSString *)key;

//从NSUserDefaults获得NSDictionary对象
-(NSDictionary *) getDictionaryFromNSUserDefaultsForKey:(NSString *)key;
//删除null
-(NSString*)delStringNull:(id)object;
//清除字典里的null 空字符
-(NSMutableDictionary* )delStringNullOfDictionary:(NSDictionary *)object;

- (BOOL)checkStringIs:(NSString *)str withmessage:(NSString *)message;
//验证身份证
- (BOOL)checkshenfenzhengString:(NSString *)str;
//验证手机号
- (BOOL)checkMobileString:(NSString *)string;

//验证邮箱
- (BOOL)checkEmailString:(NSString *)EmailString;

//验证邮编
- (BOOL)checkPostcodeString:(NSString *)string;
@end
