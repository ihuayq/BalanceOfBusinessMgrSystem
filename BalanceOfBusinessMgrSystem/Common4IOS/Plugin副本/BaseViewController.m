//
//  BaseViewController.m
//  ipaycard
//
//  Created by han bing on 13-1-3.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "BaseViewController.h"

#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation BaseViewController
- (void)installUncaughtExceptionHandler
{
    InstallUncaughtExceptionHandler();
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self installUncaughtExceptionHandler];
    //InitCrashReport();
   // [NdUncaughtExceptionHandler setDefaultHandler];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"图层-46.png"]];
    
    //[[UINavigationBar appearance]setBarTintColor:UIColorFromRGB(0x067AB5)];

    if(isIOS7)
    {
        //self.view.bounds = CGRectMake(0, -30, self.view.frame.size.width, self.view.frame.size.height );
        //self.modalPresentationCapturesStatusBarAppearance = NO;
        //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:202/255.0 green:47/255.0 blue:41/255.0 alpha:1.0]];

        self.automaticallyAdjustsScrollViewInsets = YES;//那么它会自动设置相应的内边距
        self.edgesForExtendedLayout = UIRectEdgeAll ;
        self.extendedLayoutIncludesOpaqueBars = YES;//视图将会延伸至导航栏区域
        self.modalPresentationCapturesStatusBarAppearance = NO;

        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [self.navigationController.navigationBar setTranslucent:YES];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topback"] forBarMetrics:UIBarMetricsDefault];
        [self setNeedsStatusBarAppearanceUpdate];
        
    }else{
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.navigationController.navigationBar.translucent = YES;
        //[self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:202/255.0 green:47/255.0 blue:41/255.0 alpha:1.0]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleback"] forBarMetrics:UIBarMetricsDefault];

        //self.view.frame = CGRectMake(0, 0, MainWidth,APP_ScreenHeight-20);
        //self.wantsFullScreenLayout = NO;
    }

    MPVolumeView *volumeView  = [[MPVolumeView alloc] initWithFrame:CGRectMake(-200, -200, 1, 1)];
    volumeView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:volumeView];
    
    bussBaseType  = [BussArray sharedInstance];

    //CCLog(@"init= %@  %@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(scrollView.frame));

    kbBar = [[KeyBoardBar alloc] init];
    
    hud = [[ATMHud alloc] initWithDelegate:self];
    hud.blockTouches  = YES;
    hud.shadowEnabled = YES;
    hud.allowSuperviewInteraction = NO;
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
    singleRecognizer.numberOfTapsRequired = 1;
    singleRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:singleRecognizer];
    
}
- (void)setBarTitle:(NSString*)title{
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    t.font = [UIFont boldSystemFontOfSize:20.0];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = UITextAlignmentCenter;
    t.text =title;
    self.navigationItem.titleView = t;
    
}
- (void)handleSingleTapFrom:(UITapGestureRecognizer *)recognizer {
    for (UITextField *temText in self.view.subviews) {
        [temText resignFirstResponder];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITextField *temText in self.view.subviews) {
        [temText resignFirstResponder];
    }
}

-(void) showPushMessage{
    SysInfo *si = [SysInfo newInstence];
   
    [Util showMsg:[NSString stringWithFormat:@"您的订单号为：%@的交易需要支付",[si.pushData objectForKey:@"prdOrdNo"]]];
    si.pushData = nil;
}

-(void) showPushView{
    SysInfo *si = [SysInfo newInstence];
    NSString *pushDataUserId = [si.pushData objectForKey:@"userId"];
    NSString *pushTrdType = [si.pushData objectForKey:@"retTransCod"];
    NSString *pushTrdId = [si.pushData objectForKey:@"prdOrdNo"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strUserId = [defaults objectForKey:@"userloginid"];
    /**
    '465507','支付宝账户充值'
    '465507','支付宝订单支付'
    '464011','手机充值'
    **/
    if ([pushDataUserId isEqualToString:strUserId]) {
        AutherInfo *au = [AutherInfo newInstence];
        au.USERID = strUserId;
        NSMutableDictionary *tradeInfo = [[NSMutableDictionary alloc] init];
        [tradeInfo setObject:pushTrdId forKey:@"prdordno"];
        
        NSURL *reqUrl;
        if ([pushTrdType isEqualToString:@"464011"]) {
            reqUrl = [NSURL URLWithString:[Util joinParameterToUrl:TRADEDETAILMOBILE tradePara:[self setCommitParameter:tradeInfo]]];
        }else{
            reqUrl = [NSURL URLWithString:[Util joinParameterToUrl:TRADEDETAILALIPAY tradePara:[self setCommitParameter:tradeInfo]]];
        }
        
        NSDictionary *requestResult = [self netCommit:reqUrl];
        if ([[requestResult objectForKey:@"RSPCD"] isEqualToString:REQUESTSUCESS]) {
            TradeDetail *td = [TradeDetail newInstence];
            [td setTdDetail:requestResult];
            
            UIViewController *vCtl = [VCControl backViewController:TrdDetail];
            [self.navigationController pushViewController:vCtl animated:YES];
        }else{
            [Util showMsg:[requestResult objectForKey:@"RSPMSG"]];
        }
    }
}

-(NSMutableDictionary *) setCommitParameter:(NSMutableDictionary *) paramDict
{
    NSMutableDictionary *baseInfo = [[NSMutableDictionary alloc] init];
    [baseInfo setObject:[Util getDayString] forKey:@"TrDt"];
    AutherInfo *au = [AutherInfo newInstence];
    if (![au.USERID isEqualToString:@""] && au.USERID != nil) {
        [baseInfo setObject:au.USERID forKey:@"userId"];
    }
    if (![au.LOGINID isEqualToString:@""] && au.LOGINID != nil) {
        [baseInfo setObject:au.LOGINID forKey:@"loginName"];
    }
    [baseInfo setObject:@"00000001" forKey:@"ChlCd"];
    
    NSArray *paramKeys = [paramDict allKeys];
    for (int i = 0; i < [paramKeys count]; i++) {
        [baseInfo setObject:[paramDict objectForKey:[paramKeys objectAtIndex:i]] forKey:[paramKeys objectAtIndex:i]];
    }
    return baseInfo;
}

-(NSDictionary *) netCommit:(NSURL *) requestUrl{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:requestUrl cachePolicy:0 timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *json = [data objectFromJSONData];
    
    if (json != nil) {
        return json;
    }
    return nil;
}

-(void) showWaitAnimation{
    [self.navigationController.view addSubview:hud.view];
    [hud setCaption:@"处理中，请稍候。。。"];
    [hud setActivity:YES];
    [hud show];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    //注册推送接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPushMessage) name:@"receive_push_online" object:nil];
    //注册后台接收通知通知，receive_push_data_notifation
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPushView) name:@"receive_push_data_notifation" object:nil];
}

//结束刷卡动画
-(void) showAnimation{
    if ([NSStringFromClass(self.class) isEqualToString:@"PayOrderViewController"]) {
        swipeShow = [[cardSwipeAlertView alloc] initWithFrame:CGRectMake(-10, -50, 305, 150)];
        swipeShow.csd = self;
        [swipeShow show];
    }
}

#pragma mark -- CardSwipeDelegate
-(void) stopSwipe{
    [swipeShow dismissWithClickedButtonIndex:[swipeShow cancelButtonIndex] animated:NO];
}

-(void)keyboardDidShow:(NSNotification *) noti{
    if (keybaordVisible) {
        return;
    }
    NSDictionary *info = [noti userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];

    CGSize keyboardSize = [aValue CGRectValue].size;

    CGRect viewFrame = self.view.frame;
    viewFrame.size.height -= keyboardSize.height;
    //self.view.frame = viewFrame;
    NSLog(@"通知1= %@  %@ %f",NSStringFromCGRect(viewFrame),NSStringFromCGRect(self.view.frame),keyboardSize.height);
    keybaordVisible = YES;
    
}

-(void)keyboardDidHide:(NSNotification *) noti{
    if (!keybaordVisible) {
        return;
    }
    keybaordVisible = NO;
}

-(void)keyboardWillHide:(NSNotification *) noti{
    
    NSDictionary *info = [noti userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keybaordSize = [aValue CGRectValue].size;
    CGRect viewFrame = self.view.frame;
    //CCLog(@"通知2 = %@",NSStringFromCGRect(viewFrame));
    
    viewFrame.size.height += keybaordSize.height;
    //self.view.frame = viewFrame;
    //CCLog(@"通知2 = %@  %@",NSStringFromCGRect(viewFrame), NSStringFromCGRect(self.view.frame));
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //self.view.contentOffset = CGPointZero;
    [UIView commitAnimations];
    
}

#pragma mark textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTxtF = textField;
    [textField setInputAccessoryView:kbBar.view];
    [kbBar showBar:textField]; //KeyBoardTopBar的实例对象调用显示键盘方法
    
    CGRect frame = textField.superview.frame;
    int offset = frame.origin.y + (iOS7?30:180) - (self.view.frame.size.height - 216.0);//键盘高度252
    NSLog(@"代理1=%d 位置 %@",offset,NSStringFromCGRect(frame));
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0){
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, iOS7?0:0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    NSLog(@"代理2= %@",NSStringFromCGRect(self.view.frame));
    [UIView commitAnimations];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self keyboardDidHide:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"receive_push_online" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"receive_push_data_notifation" object:nil];
    [super viewWillDisappear:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 
#pragma mark BarStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
