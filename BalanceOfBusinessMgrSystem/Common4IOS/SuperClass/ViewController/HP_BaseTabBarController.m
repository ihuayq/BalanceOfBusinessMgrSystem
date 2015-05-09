//
//  HP_BaseTabBarController.m
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import "HP_BaseTabBarController.h"
#import "HP_UserDefaultsUtils.h"


@interface HP_BaseTabBarController ()

@end

@implementation HP_BaseTabBarController

@synthesize passNameValuePair;
@synthesize progressView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    //[[BaiduMobStat defaultStat] pageviewStartWithName:[NSString stringWithFormat:@"%@",[self class]]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    //[[BaiduMobStat defaultStat] pageviewEndWithName:[NSString stringWithFormat:@"%@",[self class]]];
}


// getScreenValue 获得屏幕相关数值
-(CGRect) getScreenRect{
    return [[UIScreen mainScreen]bounds];
}

-(CGSize) getScreenSize{
    return [self getScreenRect].size;
}

-(CGFloat) getScreenScale{
    return [UIScreen mainScreen].scale;
}

-(CGFloat) getScreenWidthPixels{
    return [self getScreenScale] * [self getScreenSize].width;
}

-(CGFloat) getScreenHeightPixels{
    return [self getScreenScale] * [self getScreenSize].height;
}

// 返回参数 放入dictionary
-(void) onPopViewControllerDelegate:(NSMutableDictionary *)dictionary{
    //popViewController 返回参数 放入dictionary
}

// 显示简单的alertView
-(void)showSimpleAlertViewWithTitle:(NSString *)title alertMessage:(NSString *)msg cancelButtonTitle:(NSString *) cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles,nil];
    [alertView show];
}

// 显示简单的debugView
-(void)showDebugAlertViewWithMessage:(NSString *)msg isContinue:(BOOL) isContinue{
    
    [self showSimpleAlertViewWithTitle:@"Debug" alertMessage:msg cancelButtonTitle:@"确定" otherButtonTitles:nil];
    if(!isContinue){
        return;
    }
}

// 显示简单的progressView
-(void)showSimpleProgressViewWithMessage:(NSString *)msg{
    progressView = [[UIAlertView alloc] initWithTitle:nil message: msg delegate: self cancelButtonTitle: nil otherButtonTitles: nil];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    activityView.frame = CGRectMake(120.f, 48.0f, 37.0f, 37.0f);
    
    [progressView addSubview:activityView];
    
    [activityView startAnimating];
    [progressView show];
}

-(void)hideTabBar{
    [self.tabBarController.tabBar setHidden:YES];

    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    [contentView setFrame:CGRectMake(0,0, ScreenWidth , ScreenHeight)];
}

-(NSUserDefaults *)getNSUserDefaults{
    return [NSUserDefaults standardUserDefaults];
}

-(void) setDictionaryForNSUserDefaults:(NSMutableDictionary *) dictionary forKey:(NSString *)key{
    [[self getNSUserDefaults] setObject:dictionary forKey:key];
}

-(void) setObjectForNSUserDefaults:(id) object forKey:(NSString *)key{
    [[self getNSUserDefaults] setObject:object forKey:key];
}

-(void) setStringForNSUserDefaults:(NSString *) string forKey:(NSString *)key{
    [[self getNSUserDefaults] setObject:string forKey:key];
}

-(id) getObjectFromNSUserDefaultsForKey:(NSString *)key{
    return [[self getNSUserDefaults] objectForKey:key];
}

-(NSString *) getStringFromNSUserDefaultsForKey:(NSString *)key{
    return [[self getNSUserDefaults] stringForKey:key];
}

-(NSDictionary *) getDictionaryFromNSUserDefaultsForKey:(NSString *)key{
    return [[self getNSUserDefaults] dictionaryForKey:key];
}
-(NSString*)delStringNull:(id)object
{
    
    if ([object isEqual:[NSNull null]])
    {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if (object==nil)
    {
        return @"";
    }
    return object;
    
}
-(NSMutableDictionary* )delStringNullOfDictionary:(NSDictionary *)object
{
    NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
    
    for (NSString *key in object)
    {
        [Dict setObject:[self delStringNull:[object objectForKey:key]] forKey:key];
    }
    
    return Dict;
}
- (BOOL)checkStringIs:(NSString *)str withmessage:(NSString *)message
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    
    return YES;
}

- (BOOL)checkshenfenzhengString:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入身份证" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (msgstring.length!=18)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"身份证输入不正确" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    
    for (int i=0; i<str.length-1; i++)
    {
        if (!isdigit([str characterAtIndex:i]))
        {
            UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"身份证输入不正确" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
            [alertview show];
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)checkMobileString:(NSString *)string
{
    
    NSString* msgstring=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入手机号" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = PhoneNoRegex;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alert show];
        return NO;
        
    }
    return YES;
    
}
- (BOOL)checkEmailString:(NSString *)EmailString
{
    NSString* msgstring=[EmailString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入邮箱" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    if (![emailTest evaluateWithObject:EmailString])
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"邮箱格式不正确" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    return YES;
}
- (BOOL)checkPostcodeString:(NSString *)string
{
    
    NSString* msgstring=[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入邮政编码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (msgstring.length!=6)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"邮政编码位数是6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if ([msgstring intValue]<0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"邮政编码输入不正确" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    return YES;
}

@end
