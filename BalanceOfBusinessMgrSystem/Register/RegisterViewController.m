//
//  RegisterViewController.m
//  jxtuan
//
//  Created by fengxiaoguang on 13-7-22.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "RegisterViewController.h"
#import "ControllerConfig.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
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
    [self initUI];
}

-(void) initUI
{
    //[self.view setBackgroundColor:[HP_UIColorUtils colorWithHexString:BG_COLOR]];
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_bg"] forBarMetrics:UIBarMetricsDefault];
    //[self.view setBackgroundColor:[UIColor blackColor]];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    [bgView setBackgroundColor:[HP_UIColorUtils colorWithHexString:BG_COLOR]];
    [self.view addSubview:bgView];
    
    
    HP_UIImageView *backgroundImageView = [[HP_UIImageView alloc] init];
    [backgroundImageView  setFrame:CGRectMake(0, 0,MainWidth, MainHeight)];
    [backgroundImageView setImage:[UIImage imageNamed:@""]];
    [self.view addSubview:backgroundImageView];
    
    
    HP_UIView *topBarView = [[HP_UIView alloc] init];
    [topBarView setFrame:CGRectMake(0, 0, MainWidth, 64)];
    [topBarView setBackgroundColor:[HP_UIColorUtils colorWithHexString:TOPBAR_COLOR]];
    //topBarView.layer.shadowColor = [[UIColor blackColor] CGColor];
    //topBarView.layer.shadowOpacity = .5;
    //topBarView.layer.shadowOffset = CGSizeMake(0,3);
    [self.view addSubview:topBarView];
    

    
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
    

    
    HP_UIImageView *bg1ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, 90,MainWidth-40, 40)];
    [bg1ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:bg1ImageView];
    
    UILabel * telLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 90, 70, 40)];
    telLabel.text = @"手机号:";
    telLabel.textAlignment = NSTextAlignmentLeft;
    telLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telLabel.font = [UIFont systemFontOfSize:14];
    telLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:telLabel];
    
    telTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, 90, 200, 40)];
    [telTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    telTextField.backgroundColor = [UIColor clearColor];
    telTextField.clearButtonMode = UITextFieldViewModeAlways;
    telTextField.placeholder = @"请输入手机号";
    telTextField.font = [UIFont systemFontOfSize:14];
    telTextField.delegate = self;
    telTextField.keyboardType = UIKeyboardTypeNumberPad;
    telTextField.borderStyle = UITextBorderStyleNone;
    [bgView addSubview:telTextField];

    
    HP_UIImageView *bg2ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, 140,MainWidth-40, 40)];
    [bg2ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:bg2ImageView];
    
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100+40, 70, 40)];
    passwordLabel.text = @"登录密码:";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:passwordLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, 100+40, 200, 40)];
    [passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入登录密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.secureTextEntry=YES;
    [bgView addSubview:passwordTextField];
    
    UILabel * tishiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100+75, MainWidth, 40)];
    tishiLable.text =mima_tishiyu_6_20;
    tishiLable.textAlignment = NSTextAlignmentCenter;
    tishiLable.textColor = [HP_UIColorUtils colorWithHexString:TOPBAR_COLOR];
    tishiLable.font = [UIFont systemFontOfSize:14];
    tishiLable.backgroundColor = [UIColor clearColor];
    [bgView addSubview:tishiLable];
    
    
    
    HP_UIImageView *bg3ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, 210,MainWidth-40, 40)];
    [bg3ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:bg3ImageView];
    
    
    UILabel * inviteCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 210, 70, 40)];
    inviteCodeLabel.text = @"邀请码:";
    inviteCodeLabel.textAlignment = NSTextAlignmentLeft;
    inviteCodeLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    inviteCodeLabel.font = [UIFont systemFontOfSize:14];
    inviteCodeLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:inviteCodeLabel];
    
    inviteCodeTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, 210, 200, 40)];
    [inviteCodeTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    inviteCodeTextField.backgroundColor = [UIColor clearColor];
    inviteCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    inviteCodeTextField.placeholder = @"选填";
    inviteCodeTextField.font = [UIFont systemFontOfSize:14];
    inviteCodeTextField.delegate = self;
    inviteCodeTextField.keyboardType = UIKeyboardTypeDefault;
    inviteCodeTextField.borderStyle = UITextBorderStyleNone;
   // inviteCodeTextField.secureTextEntry=YES;
    [bgView addSubview:inviteCodeTextField];

    
    
    HP_UIImageView *bg4ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, 260,190, 40)];
    [bg4ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:bg4ImageView];
    
    UILabel * checkwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 260, 70, 40)];
    checkwordLabel.text = @"验证码:";
    checkwordLabel.textAlignment = NSTextAlignmentLeft;
    checkwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    checkwordLabel.font = [UIFont systemFontOfSize:14];
    checkwordLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:checkwordLabel];
    
    passCodeTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, 260, 110, 40)];
    [passCodeTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passCodeTextField.backgroundColor = [UIColor clearColor];
    passCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    passCodeTextField.placeholder = @"请输入验证码";
    passCodeTextField.font = [UIFont systemFontOfSize:14];
    passCodeTextField.delegate = self;
    passCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    passCodeTextField.borderStyle = UITextBorderStyleNone;
    passCodeTextField.secureTextEntry=NO;
    [bgView addSubview:passCodeTextField];
    
    
    
    sendCheckCodeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"senddj"] forState:UIControlStateHighlighted];
    [sendCheckCodeButton setBackgroundColor:[HP_UIColorUtils clearColor]];
    [sendCheckCodeButton setFrame:CGRectMake(215, 260, 85, 40)];
    [sendCheckCodeButton addTarget:self action:@selector(touchSendCheckCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:sendCheckCodeButton];
    
    sendCheckCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 40)];
    sendCheckCodeLabel.textAlignment = NSTextAlignmentCenter;
    sendCheckCodeLabel.backgroundColor = [UIColor clearColor];
    sendCheckCodeLabel.text = @"点击获取";
    sendCheckCodeLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    sendCheckCodeLabel.font = [UIFont systemFontOfSize:14];
    [sendCheckCodeButton addSubview:sendCheckCodeLabel];
    
    
    isSelectAgreement=YES;
    selectButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"y"] forState:UIControlStateNormal];
    [selectButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [selectButton setBackgroundColor:[UIColor clearColor]];
    [selectButton setFrame:CGRectMake(20, 308, 21, 18)];
    [selectButton addTarget:self action:@selector(touchSelectButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectButton];
    
    HP_UIImageView *passwordImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(40, 308,280, 36)];
    [passwordImageView setImage:[UIImage imageNamed:@"register"]];
    [bgView addSubview:passwordImageView];
    
    

//    UILabel * iHaveReadLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 250, 110, 30)];
//    iHaveReadLabel.textAlignment = NSTextAlignmentCenter;
//    iHaveReadLabel.backgroundColor = [UIColor clearColor];
//    iHaveReadLabel.text = @"我已阅读并同意";
//    iHaveReadLabel.textColor =[HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    iHaveReadLabel.font = [UIFont systemFontOfSize:14];
//    [bgView addSubview:iHaveReadLabel];
//    
//    HP_UILabel* allBelieveAgreementLabel1 = [[HP_UILabel alloc] initWithFrame:CGRectMake(137, 250, 140, 30)];
//    allBelieveAgreementLabel1.textAlignment = NSTextAlignmentCenter;
//    allBelieveAgreementLabel1.backgroundColor = [UIColor clearColor];
//    allBelieveAgreementLabel1.text = @"《众信平台服务协议》";
//    allBelieveAgreementLabel1.textColor = [HP_UIColorUtils colorWithHexString:Qianlan];
//    [allBelieveAgreementLabel1 setIsUnderline:YES];
//    [allBelieveAgreementLabel1 setUnderLineColor:[HP_UIColorUtils colorWithHexString:Qianlan]];
//    allBelieveAgreementLabel1.font = [UIFont systemFontOfSize:14];
//    [bgView addSubview:allBelieveAgreementLabel1];
    
    UIButton *agreementButton1 = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [agreementButton1 setBackgroundColor:[UIColor clearColor]];
    [agreementButton1 setFrame:CGRectMake(130, 305, 120, 20)];
    agreementButton1.tag=0;
    [agreementButton1 addTarget:self action:@selector(touchAgreementButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:agreementButton1];
    
    
//    UILabel * heLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 270, 110, 30)];
//    heLabel.textAlignment = NSTextAlignmentLeft;
//    heLabel.backgroundColor = [UIColor clearColor];
//    heLabel.text = @"和";
//    heLabel.textColor =[HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    heLabel.font = [UIFont systemFontOfSize:14];
//    [bgView addSubview:heLabel];
//    
//    HP_UILabel * allBelieveAgreementLabel2 = [[HP_UILabel alloc] initWithFrame:CGRectMake(50, 270, 170, 30)];
//    allBelieveAgreementLabel2.textAlignment = NSTextAlignmentCenter;
//    allBelieveAgreementLabel2.backgroundColor = [UIColor clearColor];
//    allBelieveAgreementLabel2.text = @"《支付通用户注册协议》";
//    allBelieveAgreementLabel2.textColor = [HP_UIColorUtils colorWithHexString:Qianlan];
//    [allBelieveAgreementLabel2 setIsUnderline:YES];
//    [allBelieveAgreementLabel2 setUnderLineColor:[HP_UIColorUtils colorWithHexString:Qianlan]];
//    allBelieveAgreementLabel2.font = [UIFont systemFontOfSize:14];
//    [bgView addSubview:allBelieveAgreementLabel2];
    
    
    UIButton *agreementButton2 = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [agreementButton2 setBackgroundColor:[UIColor clearColor]];
    [agreementButton2 setFrame:CGRectMake(250, 305, 120, 20)];
    agreementButton2.tag=1;
    [agreementButton2 addTarget:self action:@selector(touchAgreementButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:agreementButton2];
    
    
    UIButton *agreementButton22 = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [agreementButton22 setBackgroundColor:[UIColor clearColor]];
    [agreementButton22 setFrame:CGRectMake(50, 325, 100, 20)];
    agreementButton22.tag=1;
    [agreementButton22 addTarget:self action:@selector(touchAgreementButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:agreementButton22];
    
    
    UIButton *agreementButton3 = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [agreementButton3 setBackgroundColor:[UIColor clearColor]];
    [agreementButton3 setFrame:CGRectMake(140, 325, 200, 20)];
    agreementButton3.tag=2;
    [agreementButton3 addTarget:self action:@selector(touchAgreementButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:agreementButton3];
    
    
    
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setFrame:CGRectMake(20, 360, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"提交注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font=[UIFont systemFontOfSize:15];
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
-(void)touchAgreementButton:(UIButton*)bn//协议书
{
    NSLog(@"-----%d",bn.tag);
    AgreementViewController* agreementVC=[[AgreementViewController alloc]init];
    agreementVC.type=bn.tag;//0  1  2 
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
    
    
//    getMessageCode
//    韩韶茹  14:49:37
//    String personId = request.getParameter("personId");
//    String phoneNum = request.getParameter("phoneNum");
//    String signature = request.getParameter("signature");

    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [connDictionary setObject:telTextField.text forKey:@"mobile"];
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
    
    NSString *regex =PhoneNoRegex;
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
//    if (msgstring.length<6)
//    {
//        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"密码输入少于6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alertview show];
//        return NO;
//    }
    
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

-(void)touchRegisterButton
{
   
    

    if (![self checkTel:telTextField.text])
    {
        return;
    }
    if (![self checkPassword:passwordTextField.text])
    {
        return;
        
    }
    if (![self checkPassCode:passCodeTextField.text])
    {
        return;
    }
    if (!isSelectAgreement)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请同意协议" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
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
    
    [connDictionary setObject:telTextField.text forKey:@"mobile"];//手机号
    [connDictionary setObject:passCodeTextField.text forKey:@"code"];//验证码
    if (inviteCodeTextField.text&&[inviteCodeTextField.text length]==6)
    {
        [connDictionary setObject:inviteCodeTextField.text forKey:INVITECODE];//邀请码
        
    }
    
    
    
    
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"passwd"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
    
    [connDictionary setObject:string3des forKey:@"passwd"];
    
   //不参加签名
    
    NSLog(@"connDictionary:%@",connDictionary);
    
    if (isRegistering)
    {
        return;
    }
    isRegistering=YES;
    
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
                [Dict setObject:[self delStringNull:[responseJSONDictionary objectForKey:INVITECODE]] forKey:USER_INVITECODE];
                [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:USERINFO];
               
                [[self getNSUserDefaults] setObject:@"1" forKey:LOGIN_STATUS];//0未登陆、1的登陆
                [[NSUserDefaults standardUserDefaults]setObject:telTextField.text forKey:LAST_LOGIN_NAME];
                [[NSUserDefaults standardUserDefaults] setObject:Register_First forKey:Register_First];
                
                
                ISZhiFuTongSetPayMoneyPassWordViewController* isVC=[[ISZhiFuTongSetPayMoneyPassWordViewController alloc]init];
                [self.navigationController pushViewController:isVC animated:YES];
                

            }
            else
            {
               
                SetPayMoneyPasswordViewController* SPMPVC=[[SetPayMoneyPasswordViewController alloc]init];
                [SPMPVC.transmitDict setObject:telTextField.text forKey:USER_MOBILE];
                [SPMPVC.transmitDict setObject:passwordTextField.text forKey:USER_PASSWORD];
                if (inviteCodeTextField.text)
                {[SPMPVC.transmitDict setObject:inviteCodeTextField.text forKey:OTHERS_INVITECODE];
                }
                
                [self.navigationController pushViewController:SPMPVC animated:YES];
            }
            
        }
        else
        {
            
            [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
        }
        isRegistering=NO;
    } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg)
    {
        isRegistering=NO;
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
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==telTextField)
    {
        
    }
    else if (textField == inviteCodeTextField)
    {
        
        [UIView animateWithDuration:0.2 animations:^{
            [bgView setFrame:CGRectMake(0, -30, MainWidth, MainHeight)];
        }];
    }
    else if (textField == passCodeTextField)
    {
        
        [UIView animateWithDuration:0.2 animations:^{
            [bgView setFrame:CGRectMake(0, -50, MainWidth, MainHeight)];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            [bgView setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
        }];
    }
    
    
    
}





-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.2 animations:^{
        [bgView setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    }];
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
    if (textField==inviteCodeTextField)
    {
        if (string.length > 0)
        {
            
            return passwordTextField.text.length < 10;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [telTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [inviteCodeTextField resignFirstResponder];
    [passCodeTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [bgView setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
