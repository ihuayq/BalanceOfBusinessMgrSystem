//
//  HP_BaseViewController.m
//  shise
//
//  Created by Yi Xu on 12-10-30.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import "HP_BaseViewController.h"


@interface HP_BaseViewController ()<MBProgressHUDDelegate>{
	MBProgressHUD *HUD;
}


@end

@implementation HP_BaseViewController

@synthesize passNameValuePair;
@synthesize progressView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
//    [[BaiduMobStat defaultStat] pageviewStartWithName:[NSString stringWithFormat:@"%@",[self class]]];
}

-(void)viewDidDisappear:(BOOL)animated
{
//    [[BaiduMobStat defaultStat] pageviewEndWithName:[NSString stringWithFormat:@"%@",[self class]]];
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
-(void)showSimpleAlertViewWithTitle:(NSString *)title tag:(int)tag alertMessage:(NSString *)msg cancelButtonTitle:(NSString *) cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles,nil];
    alertView.tag = tag;
    [alertView show];
}

// 显示简单的alertView
-(void)showSimpleAlertViewWithTitle:(NSString *)title alertMessage:(NSString *)msg cancelButtonTitle:(NSString *) cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles,nil];
    [alertView show];
}

// 显示简单的debugView
-(void)showDebugAlertViewWithMessage:(NSString *)msg isContinue:(BOOL) isContinue
{
    
    [self showSimpleAlertViewWithTitle:@"Debug" alertMessage:msg cancelButtonTitle:@"确定" otherButtonTitles:nil];
    if(!isContinue)
    {
        return;
    }
}

// 在这里处理UIAlertView中的按钮被单击的事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex is : %i",(int)buttonIndex);
    if(alertView.tag == LoginOutViewTag){
        switch (buttonIndex) {
            case 0:{
//                if ([[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_TYPE] isEqualToString:@"0"]) {
//                    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"login",@"0",@"isSupplyer", nil];
//                    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
//                    [[NSNotificationCenter defaultCenter] postNotification:notification];
//                }
//                else{
//                    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"login",@"1",@"isSupplyer", nil];
//                    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
//                    [[NSNotificationCenter defaultCenter] postNotification:notification];
//                }
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"4",@"login", nil];
                NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }break;
            default:
                break;
        }
    }
}

// 显示简单的progressView
-(void)showSimpleProgressViewWithMessage:(NSString *)msg
{
    progressView = [[UIAlertView alloc] initWithTitle:nil message: msg delegate: self cancelButtonTitle: nil otherButtonTitles: nil];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    activityView.frame = CGRectMake(120.f, 48.0f, 37.0f, 37.0f);
    
    [progressView addSubview:activityView];
    
    [activityView startAnimating];
    [progressView show];
}

-(void)showProgressViewWithMessage:(NSString *)msg
{
    progressView = [[UIAlertView alloc] initWithTitle:nil
                    
                                              message: msg
                    
                                             delegate: self
                    
                                    cancelButtonTitle: nil
                    
                                    otherButtonTitles: nil];
    
    
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    activityView.frame = CGRectMake(120.f, 48.0f, 37.0f, 37.0f);
    
    [progressView addSubview:activityView];
    
    [activityView startAnimating];
    [progressView show];
}


-(void)showMBProgressHUDWithMessage:(NSString *)msg
{
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    
//    HUD.delegate = self;
//    HUD.mode = MBProgressHUDModeText;
//    HUD.minSize = CGSizeMake(135.f, 135.f);
//    HUD.labelText = msg;
//  [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
//    HUD= [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
    // Configure for text only and offset down
    //HUD.mode = MBProgressHUDModeText;
    HUD.labelText = msg;
    HUD.minSize = CGSizeMake(75.f, 75.f);
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
   
}

-(void)hidMBProgressHUD
{
    //[HUD hide:YES];
    [HUD hide:YES afterDelay:0.1];
}

- (void)showMBProgressHUDWithCustomView:(NSString *)msg withImage:(NSString *)imageName
{
    
    HUD= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    if (imageName.length == 0 ) {
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    }
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = msg;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

-(NSUserDefaults *) getNSUserDefaults
{
    return [NSUserDefaults standardUserDefaults];
}
-(void)logMessage:(NSString *)msg
{
    
    NSLog(@"%@ - %@",[self class],msg);
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
    
    if ([object count])
    {
        for (NSString *key in object)
        {
            [Dict setObject:[self delStringNull:[object objectForKey:key]] forKey:key];
        }
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

- (BOOL)checkPassWordString:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
//    if (msgstring.length<6)
//    {
//        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"密码输入少于6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alertview show];
//        return NO;
//    }

    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![^0-9a-zA-Z]+$).{6,20}$"];//6-16位 至少含有数字和字母
//    BOOL isMatch = [pred evaluateWithObject:str];
//    
//    if (!isMatch)
//    {
//        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"密码输入为%@",mima_tishiyu_6_20] delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alertview show];
//        return NO;
//    }
    
    return YES;
}

- (BOOL)checkshenfenzhengString:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入身份证号" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
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

//验证姓名
- (BOOL)checkName:(NSString *)str{
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入姓名" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
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

- (BOOL)checkPassCode:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入验证码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (msgstring.length<4)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"验证码输入有误" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    
    return YES;
    
}
@end
