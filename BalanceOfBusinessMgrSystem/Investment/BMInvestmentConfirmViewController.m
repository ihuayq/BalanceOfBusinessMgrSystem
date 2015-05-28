//
//  BMInvestmentConfirmViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/28.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMInvestmentConfirmViewController.h"

@interface BMInvestmentConfirmViewController (){
    UIWebView *manualProductWebView;
    
    UIButton *okButton;
    
    int nCout;
    NSTimer* timer;
}

@end

@implementation BMInvestmentConfirmViewController

-(void)viewWillAppear:(BOOL)animated
{
    nCout = 8;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    nCout = 0;
    [self timeCountdown];
    //[timer invalidate];//取消定时器
    
}

-(void)timeCountdown
{
    NSLog(@"%d\n",nCout);
    
    if (nCout>0)
    {
        nCout=nCout-1;
        [okButton setTitle:[NSString stringWithFormat:@"确定 %d",nCout] forState:UIControlStateDisabled];
        [okButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateNormal];
        [okButton setEnabled:NO];
    }
    else if (nCout==0)
    {
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
        [okButton setEnabled:YES];
        nCout=8;
        [timer invalidate];//取消定时器
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"预约购买须知";
    
    //超额宝介绍
    manualProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(40, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 40*2, 180)];
    [manualProductWebView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [manualProductWebView.layer setBorderWidth:0.5f];
    [self.view addSubview:manualProductWebView];
    
    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"我要投资" ofType:@"html"];
    NSString *htmlString1= [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
    [manualProductWebView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
    
    //确定
    okButton = [HP_UIButton buttonWithType:UIButtonTypeRoundedRect];
    [okButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    //    [okButton setBackgroundColor:[UIColor redColor]];
    [okButton setFrame:CGRectMake(40,manualProductWebView.frame.origin.y+ manualProductWebView.frame.size.height + 40, MainWidth-2*40, 40)];
    [okButton addTarget:self action:@selector(touchDatingButton) forControlEvents:UIControlEventTouchUpInside];
    okButton.enabled = false;
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton.layer setMasksToBounds:YES];
    [okButton.layer setCornerRadius:okButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [okButton.layer setBorderWidth:1.0]; //边框宽度
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
//    [okButton.layer setBorderColor:colorref];//边框颜色
//    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:okButton];
    
    [self timeCountdown];
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
}

-(void)requestNetWork{
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:@"1" forKey:@"status"];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,DrawCashURL];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    //NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,getbalanceURL];
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求预约..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             
             //[self setAppointmentInfo:YES];

             //[[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"appointment"];
             //发送网络请求，请求预约
             //[[[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功，成功投资金额可能需要一定时间才能显示，谢谢您的使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
         }
         else
         {
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error,NSString * msg) {
         NSLog(@"error:%@",error.debugDescription);
         if (![request isCancelled])
         {
             [request cancel];
         }
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
