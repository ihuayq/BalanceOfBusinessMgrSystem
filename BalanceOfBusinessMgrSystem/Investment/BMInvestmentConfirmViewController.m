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
    UILabel * buttonLabel;
    
    int nCout;
    NSTimer* timer;
}

@end

@implementation BMInvestmentConfirmViewController

-(void)viewWillAppear:(BOOL)animated
{

    
}

-(void)viewWillDisappear:(BOOL)animated
{
}

-(void)timeCountdown
{
    NSLog(@"%d\n",nCout);
    
    if (nCout>0)
    {
        nCout=nCout-1;
        buttonLabel.text = [NSString stringWithFormat:@"%d",nCout];
        [okButton setEnabled:NO];
    }
    else if (nCout==0)
    {
        [buttonLabel removeFromSuperview];
        [okButton setEnabled:YES];
        nCout=8;
        [timer invalidate];//取消定时器
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    nCout = 0;
    //[self timeCountdown];
    [timer invalidate];//取消定时器
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"预约购买须知";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    //超额宝介绍
    manualProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(10, NAVIGATION_OUTLET_HEIGHT + 10, MainWidth - 10*2, MainHeight - 180)];
    [manualProductWebView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [manualProductWebView.layer setBorderWidth:0.5f];
    [self.view addSubview:manualProductWebView];
    
    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"tishi" ofType:@"html"];
    NSString *htmlString1= [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
    [manualProductWebView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
    
    //确定
    okButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [okButton setBackgroundColor:[UIColor clearColor]];
    [okButton setFrame:CGRectMake(40,manualProductWebView.frame.origin.y+ manualProductWebView.frame.size.height + 20, MainWidth-2*40, 40)];
    [okButton addTarget:self action:@selector(touchDatingButton) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    okButton.titleLabel.textColor = [UIColor whiteColor];
    [okButton.layer setMasksToBounds:YES];
    [okButton.layer setCornerRadius:okButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    okButton.enabled = false;
    [self.view addSubview:okButton];
    
    buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 30, 30)];
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    buttonLabel.font = [UIFont systemFontOfSize:26];
    buttonLabel.backgroundColor = [UIColor clearColor];
    [okButton addSubview:buttonLabel];
    
    nCout = 8;
    [self timeCountdown];
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
}

-(void)touchDatingButton{
    [self requestNetWork];
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
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求预约..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];

             [self setAppointmentInfo:YES];
             UIAlertView * alertView =  [[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功，成功投资金额可能需要一定时间才能显示，谢谢您的使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
             alertView.tag = 1025;
             [alertView show];
         }
         //相同账号同时登陆，返回错误
         else if([ret isEqualToString:reLoginOutFlag])
         {
             [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
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

// 在这里处理UIAlertView中的按钮被单击的事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    NSLog(@"buttonIndex is : %i",(int)buttonIndex);
    
    if (alertView.tag == 1025) {
        switch (buttonIndex) {
            case 0:{
                //radioAgreement.hidden = true;
                //[registerButton setTitle:@"取消预约" forState:UIControlStateNormal];
                ////向资产界面传递资产的变动信息
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"cancelSuccess", nil];
                //创建通知
                NSNotification *notification =[NSNotification notificationWithName:@"AppointmentChange" object:nil userInfo:dict];
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }break;
            default:
                break;
        }
    }
    else if(alertView.tag == LoginOutViewTag){
        NSLog(@"buttonIndex is : %i",(int)buttonIndex);
        switch (buttonIndex) {
            case 0:{
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_TYPE] isEqualToString:@"0"]) {
                    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"login",@"0",@"isSupplyer", nil];
                    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
                else{
                    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"login",@"1",@"isSupplyer", nil];
                    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
            }break;
            default:
                break;
        }
    }
}

-(void)setAppointmentInfo:(BOOL)bHasAppointment{
    if (!bHasAppointment) {
        //[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] setObject:@"0" forKey:@"appointment"];
        NSMutableDictionary*data = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO]];
        [data setObject:@"0" forKey:@"appointment"];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERINFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{

        //[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] setObject:@"1" forKey:@"appointment"];
        NSMutableDictionary*data = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO]];
        [data setObject:@"1" forKey:@"appointment"];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERINFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
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
