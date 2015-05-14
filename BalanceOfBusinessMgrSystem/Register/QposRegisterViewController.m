//
//  QposRegisterViewController.m
//  AllBelieve
//
//  Created by tsmc on 14-3-20.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import "QposRegisterViewController.h"
#import "GlobalDefine.h"


@interface QposRegisterViewController ()

@end

@implementation QposRegisterViewController
@synthesize transferDict;
@synthesize loginVC;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        transferDict=[[NSMutableDictionary alloc]initWithCapacity:0];
        
        dataDict = [[NSMutableDictionary alloc] init];
        jishuqi=60;

    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];//取消定时器
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    
    dataDict=transferDict;
    
    [self initData];
    
    [self initUI];
}


- (void)initData//判断Qpos 是否注册
{
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络不可用，请检查您的网络后重试" delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:7];
    
    [connDictionary setObject:[self delStringNull:[dataDict objectForKey:QPOS_PHONE_NO] ]forKey:@"mobile"];
    [connDictionary setObject:[self delStringNull:[dataDict objectForKey:QPOS_MERCHANT_NO]] forKey:@"platformmerno"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,checkmerchantisexistURL];
    
    [self showProgressViewWithMessage:@"正在加载..."];
    
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
    {
        NSLog(@"%@",responseJSONDictionary);
        if([ret isEqualToString:@"100"])
        {
            if ([[responseJSONDictionary objectForKey:@"user_status"] isEqualToString:@"noexist"])
            {//不存在
                telTextField.text = [dataDict objectForKey:QPOS_PHONE_NO];
                [telTextField setUserInteractionEnabled:NO];
            }
            else if ([[responseJSONDictionary objectForKey:@"user_status"] isEqualToString:@"exist"])
            {//存在
                
                [self.navigationController popViewControllerAnimated:NO];
            }
        }
        else
        {
            
        }
    } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error ,NSString * msg)
    {
        NSLog(@"error:%@",error.debugDescription);
        if (![request isCancelled])
        {
            [request cancel];
        }
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
        alertView.tag = 999;
        [alertView show];
    }];
    [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
}


-(void) initUI
{
    //[self.view setBackgroundColor:[HP_UIColorUtils colorWithHexString:BG_COLOR]];
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_bg"] forBarMetrics:UIBarMetricsDefault];
    //[self.view setBackgroundColor:[UIColor blackColor]];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    [bgView setBackgroundColor:[HP_UIColorUtils colorWithHexString:BG_COLOR]];
    [self.view addSubview:bgView];
    
    
    HP_UIImageView *backgroundImageView = [[HP_UIImageView alloc] init];
    [backgroundImageView  setFrame:CGRectMake(0, 0,MainWidth, MainHeight)];
    [backgroundImageView setImage:[UIImage imageNamed:@""]];
    [bgView addSubview:backgroundImageView];
    
    
    HP_UIView *topBarView = [[HP_UIView alloc] init];
    [topBarView setFrame:CGRectMake(0, 0, MainWidth, 64)];
    [topBarView setBackgroundColor:[HP_UIColorUtils colorWithHexString:TOPBAR_COLOR]];
    //topBarView.layer.shadowColor = [[UIColor blackColor] CGColor];
    //topBarView.layer.shadowOpacity = .5;
    //topBarView.layer.shadowOffset = CGSizeMake(0,3);
    [bgView addSubview:topBarView];
    
    
    
    UILabel *topBarTextLable = [[UILabel alloc] initWithFrame:CGRectMake((MainWidth-200)/2, 20, 200, 40)];
    topBarTextLable.text = @"注册";
    topBarTextLable.textAlignment = NSTextAlignmentCenter;
    topBarTextLable.backgroundColor =[UIColor clearColor];
    topBarTextLable.textColor = [UIColor whiteColor];
    topBarTextLable.font = [UIFont systemFontOfSize:18];
    //topBarTextLable.font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    //topBarTextLable.shadowOffset=CGSizeMake(1, 1);
    //topBarTextLable.shadowColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    [topBarView addSubview:topBarTextLable];
    
    
    HP_UIButton *backButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 17, 45, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_highlight"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(goToBackView) forControlEvents:UIControlEventTouchUpInside];
    [topBarView addSubview:backButton];
    
    
    
    
    
    UILabel * telLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 70, 30)];
    telLabel.text = @"手机号:";
    telLabel.textAlignment = NSTextAlignmentLeft;
    telLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telLabel.font = [UIFont systemFontOfSize:14];
    telLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:telLabel];
    
    telTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(110, 100, 180, 30)];
    [telTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    telTextField.backgroundColor = [UIColor whiteColor];
    telTextField.clearButtonMode = UITextFieldViewModeAlways;
    telTextField.placeholder = @"请输入手机号";
    telTextField.font = [UIFont systemFontOfSize:14];
    telTextField.delegate = self;
    telTextField.keyboardType = UIKeyboardTypeNumberPad;
    telTextField.borderStyle = UITextBorderStyleRoundedRect;
    telTextField.userInteractionEnabled = NO;
    [bgView addSubview:telTextField];
    
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100+40, 70, 30)];
    passwordLabel.text = @"登录密码:";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:passwordLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(110, 100+40, 180, 30)];
    [passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入登录密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.secureTextEntry=YES;
    [bgView addSubview:passwordTextField];
    
    UILabel * tishiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100+75, MainWidth, 30)];
    tishiLable.text =mima_tishiyu_6_20;
    tishiLable.textAlignment = NSTextAlignmentCenter;
    tishiLable.textColor = [HP_UIColorUtils colorWithHexString:TOPBAR_COLOR];
    tishiLable.font = [UIFont systemFontOfSize:14];
    tishiLable.backgroundColor = [UIColor clearColor];
    [bgView addSubview:tishiLable];
    
    UILabel * checkwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 210, 70, 30)];
    checkwordLabel.text = @"验证码:";
    checkwordLabel.textAlignment = NSTextAlignmentLeft;
    checkwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    checkwordLabel.font = [UIFont systemFontOfSize:14];
    checkwordLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:checkwordLabel];
    
    passCodeTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(110, 210, 100, 30)];
    [passCodeTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passCodeTextField.backgroundColor = [UIColor whiteColor];
    passCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    passCodeTextField.placeholder = @"请输入验证码";
    passCodeTextField.font = [UIFont systemFontOfSize:14];
    passCodeTextField.delegate = self;
    passCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    passCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    passCodeTextField.secureTextEntry=NO;
    [bgView addSubview:passCodeTextField];
    
    
    sendCheckCodeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [sendCheckCodeButton setBackgroundColor:[UIColor redColor]];
    [sendCheckCodeButton setFrame:CGRectMake(220, 210, 70, 30)];
    [sendCheckCodeButton addTarget:self action:@selector(touchSendCheckCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:sendCheckCodeButton];
    
    sendCheckCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    sendCheckCodeLabel.textAlignment = NSTextAlignmentCenter;
    sendCheckCodeLabel.backgroundColor = [UIColor clearColor];
    sendCheckCodeLabel.text = @"点击获取";
    sendCheckCodeLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    sendCheckCodeLabel.font = [UIFont systemFontOfSize:15];
    [sendCheckCodeButton addSubview:sendCheckCodeLabel];
    
    
    isSelectAgreement=NO;
    selectButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
    [selectButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [selectButton setBackgroundColor:[UIColor clearColor]];
    [selectButton setFrame:CGRectMake(30, 258, 21, 18)];
    [selectButton addTarget:self action:@selector(touchSelectButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectButton];
    
    
    UILabel * iHaveReadLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 110, 30)];
    iHaveReadLabel.textAlignment = NSTextAlignmentCenter;
    iHaveReadLabel.backgroundColor = [UIColor clearColor];
    iHaveReadLabel.text = @"我已阅读并同意";
    iHaveReadLabel.textColor =[HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    iHaveReadLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:iHaveReadLabel];
    
    HP_UILabel* allBelieveAgreementLabel1 = [[HP_UILabel alloc] initWithFrame:CGRectMake(150, 250, 140, 30)];
    allBelieveAgreementLabel1.textAlignment = NSTextAlignmentCenter;
    allBelieveAgreementLabel1.backgroundColor = [UIColor clearColor];
    allBelieveAgreementLabel1.text = @"《众信平台服务协议";
    allBelieveAgreementLabel1.textColor = [HP_UIColorUtils colorWithHexString:ZISE_QIAN];
    [allBelieveAgreementLabel1 setIsUnderline:YES];
    [allBelieveAgreementLabel1 setUnderLineColor:[HP_UIColorUtils colorWithHexString:ZISE_QIAN]];
    allBelieveAgreementLabel1.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:allBelieveAgreementLabel1];
    
    HP_UILabel * allBelieveAgreementLabel2 = [[HP_UILabel alloc] initWithFrame:CGRectMake(50, 270, 100, 30)];
    allBelieveAgreementLabel2.textAlignment = NSTextAlignmentCenter;
    allBelieveAgreementLabel2.backgroundColor = [UIColor clearColor];
    allBelieveAgreementLabel2.text = @"（用户版）》";
    allBelieveAgreementLabel2.textColor = [HP_UIColorUtils colorWithHexString:ZISE_QIAN];
    [allBelieveAgreementLabel2 setIsUnderline:YES];
    [allBelieveAgreementLabel2 setUnderLineColor:[HP_UIColorUtils colorWithHexString:ZISE_QIAN]];
    allBelieveAgreementLabel2.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:allBelieveAgreementLabel2];
    
    UIButton *agreementButton1 = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [agreementButton1 setBackgroundColor:[UIColor clearColor]];
    [agreementButton1 setFrame:CGRectMake(150, 250, 140, 30)];
    [agreementButton1 addTarget:self action:@selector(touchAgreementButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:agreementButton1];
    
    UIButton *agreementButton2 = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [agreementButton2 setBackgroundColor:[UIColor clearColor]];
    [agreementButton2 setFrame:CGRectMake(50, 270, 100, 30)];
    [agreementButton2 addTarget:self action:@selector(touchAgreementButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:agreementButton2];
    
    
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"001_2"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"001_2"] forState:UIControlStateHighlighted];
    [registerButton setFrame:CGRectMake(30, 310, MainWidth-2*30, 30)];
    [registerButton addTarget:self action:@selector(touchRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"免费注册" forState:UIControlStateNormal];
    [bgView addSubview:registerButton];
    
    
    
    
    
}
-(void)touchSelectButton
{
    if (isSelectAgreement)
    {
        isSelectAgreement=NO;
        [selectButton setBackgroundImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
        
    }
    else
    {
        isSelectAgreement=YES;
        [selectButton setBackgroundImage:[UIImage imageNamed:@"y"] forState:UIControlStateNormal];
        
    }
    
    
}
-(void)touchAgreementButton//协议书
{
    
    AgreementViewController* agreementVC=[[AgreementViewController alloc]init];
    agreementVC.type=0;
    [self.navigationController pushViewController:agreementVC animated:YES];
    
    
}
-(void)goToBackView
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchSendCheckCodeButton//请求验证码
{
    
    if (![self checkTel:telTextField.text])
    {
        return;
    }
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    
    [self touchesBegan:nil withEvent:nil];
    
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [connDictionary setObject:[dataDict objectForKey:QPOS_PHONE_NO] forKey:@"mobile"];
    [connDictionary setObject:[dataDict objectForKey:QPOS_MERCHANT_NO] forKey:@"platformmerno"];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:@"0" forKey:@"status"];

    [connDictionary setObject:@"register" forKey:@"type"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
    
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,sendcodeURL];
    
    
    [self showProgressViewWithMessage:@"正在获取验证码..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             //returnCodeSTring=[self delStringNull:[responseJSONDictionary objectForKey:@"code"]];
             
             [self timeCountdown];
             timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
         }
         else
         {
             
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg) {
         
         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
    
    
    
}
- (BOOL)checkTel:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入手机号码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = PhoneNoRegex;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alert show];
        return NO;
        
    }
    return YES;
    
}
- (BOOL)checkPassword:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (msgstring.length<6)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"密码输入少于6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    return [self checkPassWordString:str];
    
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
    //    if (![msgstring isEqualToString:returnCodeSTring])
    //    {
    //        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"验证码输入有误" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
    //        [alertview show];
    //        return NO;
    //    }
    if (msgstring.length<6)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"验证码输入有误" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    return YES;
    
}

-(void)touchRegisterButton//  注册
{
    
    
    if (![self checkTel:telTextField.text])
    {
        return;
    }
    if (![self checkPassword:passwordTextField.text])
    {
        return;
        
    }
    if (![self checkPostcodeString:passCodeTextField.text])
    {
        return;
    }
    if (!isSelectAgreement)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"你还没同意服务协议" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    
    [self touchesBegan:nil withEvent:nil];
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [connDictionary setObject:telTextField.text forKey:@"mobile"];
    [connDictionary setObject:passCodeTextField.text forKey:@"code"];
    
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    
    [connDictionary setObject:encodedValue forKey:@"passwd"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
    
    [connDictionary setObject:string3des forKey:@"passwd"];
    
    
    NSLog(@"connDictionary:%@",connDictionary);
    
    
    
    NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,checkuserisexistURL];
    
    
    [self showProgressViewWithMessage:@"正在注册中..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             
             if ([[responseJSONDictionary objectForKey:USER_STATUS] isEqualToString:@"exist"])//是否平台注册过 （注册过不用再设置支付密码）
             {
                 NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
                 [Dict setObject:[responseJSONDictionary objectForKey:@"userid"] forKey:USER_ID];
                 [Dict setObject:[responseJSONDictionary objectForKey:MOBILE] forKey:USER_MOBILE];
                 [Dict setObject:[responseJSONDictionary objectForKey:AUTHSTATUS] forKey:AUTHSTATUS];
                 [Dict setObject:[responseJSONDictionary objectForKey:BANKBINDSTAUS] forKey:BANKBINDSTAUS];
                 [Dict setObject:[responseJSONDictionary objectForKey:PLATFORMUSERID] forKey:PLATFORMUSERID];
                 [Dict setObject:[responseJSONDictionary objectForKey:USERTYPE] forKey:USERTYPE];
                 [Dict setObject:[responseJSONDictionary objectForKey:USER_STATUS] forKey:USER_STATUS];
                 [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:USERINFO];
                 [[self getNSUserDefaults] setObject:@"1" forKey:LOGIN_STATUS];//0未登陆、1的登陆
                 [[NSUserDefaults standardUserDefaults]setObject:telTextField.text forKey:LAST_LOGIN_NAME];
                 [[NSUserDefaults standardUserDefaults] setObject:Register_First forKey:Register_First];
                 MainViewController * mainview=[[MainViewController alloc]init];
                 [self.navigationController pushViewController:mainview animated:YES];
             }
             else
             {
                 
                 SetPayMoneyPasswordViewController* SPMPVC=[[SetPayMoneyPasswordViewController alloc]init];
                 [SPMPVC.transmitDict setObject:telTextField.text forKey:USER_MOBILE];
                 [SPMPVC.transmitDict setObject:passwordTextField.text forKey:USER_PASSWORD];
                 
                 if ([[dataDict objectForKey:QPOS_PHONE_NO]isEqualToString:telTextField.text])//用qpos 手机号注册了
                 {
                     [SPMPVC.transmitDict setObject:QPOS forKey:QPOS];
                     [SPMPVC.transmitDict setObject:[dataDict objectForKey:QPOS_MERCHANT_NO] forKey:QPOS_MERCHANT_NO];
                     [SPMPVC.transmitDict setObject:[dataDict objectForKey:QPOS_PHONE_NO] forKey:QPOS_PHONE_NO];
                 }
                 [self.navigationController pushViewController:SPMPVC animated:YES];
             }
             
         }
         else
         {
             
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg) {
         
         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}
-(void)timeCountdown
{
    NSLog(@"%d\n",jishuqi);
    
    if (jishuqi>0)
    {
        jishuqi=jishuqi-1;
        sendCheckCodeLabel.text=[NSString stringWithFormat:@"获取(%d)",jishuqi];
        [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"senddj"] forState:UIControlStateNormal];
        [sendCheckCodeButton setEnabled:NO];
    }
    else if (jishuqi==0)
    {
        
        sendCheckCodeLabel.text=@"点击获取";
        [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
        [sendCheckCodeButton setEnabled:YES];
        jishuqi=60;
        [timer invalidate];//取消定时器
        
    }
    
    
    
}
#pragma mark -
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==telTextField)
    {
        if (string.length > 0)
        {
            return telTextField.text.length < 11;
        }
    }
    if (textField==passwordTextField)
    {
        if (string.length > 0)
        {
            if ([string isEqualToString:@" "])
            {
                return NO;
            }
            return passwordTextField.text.length < 20;
        }
    }
    if (textField==passCodeTextField)
    {
        if (string.length > 0)
        {
            if ([string isEqualToString:@" "])
            {
                return NO;
            }
            return passCodeTextField.text.length < 6;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [telTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [passCodeTextField resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
