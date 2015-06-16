//
//  ForgetPasswordViewController.m
//  jxtuan
//
//  Created by 融通互动 on 13-8-20.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UIAlertViewDelegate>

@end

@implementation ForgetPasswordViewController

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
    self.navigation.title = @"忘记密码";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    //self.navigation.leftImage = [UIImage imageNamed:@"选择前"];
    
    [self initUI];
}

-(void) initUI
{
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 10,MainWidth-40, 40)];
    [bgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView];
    
    UILabel * telLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10, 70, 40)];
    telLabel.text = @"手机号:";
    telLabel.textAlignment = NSTextAlignmentLeft;
    telLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telLabel.font = [UIFont systemFontOfSize:14];
    telLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:telLabel];
    
    telTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(90, NAVIGATION_OUTLET_HEIGHT + 10, 210, 40)];
    [telTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    telTextField.backgroundColor = [UIColor clearColor];
    telTextField.clearButtonMode = UITextFieldViewModeAlways;
    telTextField.placeholder = @"请输入手机号";
    telTextField.font = [UIFont systemFontOfSize:14];
    telTextField.delegate = self;
    telTextField.keyboardType = UIKeyboardTypeNumberPad;
    telTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:telTextField];
    
    
    HP_UIImageView *bg2ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, telTextField.frame.origin.y + telTextField.frame.size.height + 10,190, 40)];
    [bg2ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg2ImageView];
    
    UILabel * checkwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, telTextField.frame.origin.y + telTextField.frame.size.height + 10, 70, 40)];
    checkwordLabel.text = @"验证码:";
    checkwordLabel.textAlignment = NSTextAlignmentLeft;
    checkwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    checkwordLabel.font = [UIFont systemFontOfSize:14];
    checkwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:checkwordLabel];
    
    passCodeTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(90, telTextField.frame.origin.y + telTextField.frame.size.height + 10, 110, 40)];
    [passCodeTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passCodeTextField.backgroundColor = [UIColor clearColor];
    passCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    passCodeTextField.placeholder = @"请输入验证码";
    passCodeTextField.font = [UIFont systemFontOfSize:14];
    passCodeTextField.delegate = self;
    passCodeTextField.keyboardType = UIKeyboardTypeDefault;
    passCodeTextField.borderStyle = UITextBorderStyleNone;
    passCodeTextField.secureTextEntry=NO;
    [self.view  addSubview:passCodeTextField];
    
    
    sendCheckCodeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [sendCheckCodeButton setBackgroundColor:[HP_UIColorUtils clearColor]];
    [sendCheckCodeButton setFrame:CGRectMake(215, telTextField.frame.origin.y + telTextField.frame.size.height + 10, 85, 40)];
    [sendCheckCodeButton addTarget:self action:@selector(touchSendCheckCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [sendCheckCodeButton setTitle: @"获取验证码" forState:UIControlStateNormal];
    sendCheckCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sendCheckCodeButton];
    
//    sendCheckCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 40)];
//    sendCheckCodeLabel.textAlignment = NSTextAlignmentCenter;
//    sendCheckCodeLabel.backgroundColor = [UIColor clearColor];
//    sendCheckCodeLabel.text = @"点击获取";
//    sendCheckCodeLabel.textColor = [UIColor whiteColor];
//    sendCheckCodeLabel.font = [UIFont systemFontOfSize:15];
//    [sendCheckCodeButton addSubview:sendCheckCodeLabel];
    
     //新的密码设置
    HP_UIImageView *bg3ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, sendCheckCodeButton.frame.origin.y + sendCheckCodeButton.frame.size.height + 10 ,MainWidth-40, 40)];
    [bg3ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg3ImageView];
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, sendCheckCodeButton.frame.origin.y + sendCheckCodeButton.frame.size.height + 10, 70,40)];
    passwordLabel.text = @"密码:";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(80, sendCheckCodeButton.frame.origin.y + sendCheckCodeButton.frame.size.height + 10, 220, 40)];
    [passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入登录密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.secureTextEntry=YES;
    [self.view addSubview:passwordTextField];

    
    //-----------
    HP_UIImageView *bg4ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 10,MainWidth-40, 40)];
    [bg4ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg4ImageView];
    
    
    UILabel * passwordLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 10, 70, 40)];
    passwordLabel2.text = @"再次输入:";
    passwordLabel2.textAlignment = NSTextAlignmentLeft;
    passwordLabel2.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel2.font = [UIFont systemFontOfSize:14];
    passwordLabel2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel2];
    
    passwordTextField2 = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, passwordTextField.frame.origin.y + passwordTextField.frame.size.height + 10, 200, 40)];
    [passwordTextField2 setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField2.backgroundColor = [UIColor clearColor];
    passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField2.placeholder = @"请确认登录密码";
    passwordTextField2.font = [UIFont systemFontOfSize:14];
    passwordTextField2.delegate = self;
    passwordTextField2.keyboardType = UIKeyboardTypeDefault;
    passwordTextField2.borderStyle = UITextBorderStyleNone;
    passwordTextField2.secureTextEntry=YES;
    [self.view addSubview:passwordTextField2];
    
    //确定
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, passwordTextField2.frame.origin.y + passwordTextField2.frame.size.height + 10 , MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchForgetPasswordButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton setTitle:@"确认" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f];

}

-(void)viewWillAppear:(BOOL)animated
{
    nCout = 60;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    nCout = 0;
    [self timeCountdown];
    //[timer invalidate];//取消定时器
    
}

-(void)goToBackView
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)previousToViewController
{
    [self dismissModalViewControllerAnimated:YES];
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
    [connDictionary setObject:telTextField.text forKey:@"phoneNum"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,ForgetLoginPasswdURL];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    [self showProgressViewWithMessage:@"正在获取验证码..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             //returnCodeSTring=[self delStringNull:[responseJSONDictionary objectForKey:@"code"]];
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"personId"] forKey:@"fogetPassPersonId"];
             
             [self timeCountdown];
             timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
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
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg) {
         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}




-(void)touchForgetPasswordButton
{
    if (![self checkTel:telTextField.text]) {
         return;
    }
    
    if (![self checkPassCode:passCodeTextField.text]) {
        return;
    }
    
    if (![self checkPassword:passwordTextField.text checkPassword2:passwordTextField2.text])
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
    id infp = [[NSUserDefaults standardUserDefaults] objectForKey:@"fogetPassPersonId"];
    if (infp == nil) {
        [connDictionary setObject:@"" forKey:USER_ID];
    }
    else{
        [connDictionary setObject:infp forKey:USER_ID];
    }
    
    [connDictionary setObject:passCodeTextField.text forKey:@"verificationCode"];
    [connDictionary setObject:telTextField.text forKey:@"phoneNum"];
    
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"newPassword"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,SetLoginPasswdURL];
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    [self showProgressViewWithMessage:@"正在设置登录密码..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             //returnCodeSTring=[self delStringNull:[responseJSONDictionary objectForKey:@"code"]];
             //[self timeCountdown];
             //timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
             //商户还是自然
             //[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] setObject:@"1" forKey:@"naturalMark"];
             
             //[self.navigationController popViewControllerAnimated:YES];
             UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"登录密码设置成功,请重新登录" delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
             alertView.tag = 1024;
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
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg) {
         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1024) {
        [self dismissModalViewControllerAnimated:YES];
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

- (BOOL)checkTel:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入手机号码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }

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


- (BOOL)checkPassword:(NSString *)str1 checkPassword2:(NSString*)str2
{
    
    NSString* msgstring1=[str1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    // NSString* msgstring2=[str2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring1.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    //    if (msgstring1.length<6)
    //    {
    //        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"密码最少6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
    //        [alertview show];
    //        return NO;
    //    }
    if (![self checkPassWordString:str1])
    {
        return NO;
    }
    if (![str1 isEqualToString:str2])
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"输入密码不一致" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
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

-(void)touchRegisterButton
{
    if (![self checkTel:telTextField.text])
    {
        return;
    }
    if (![self checkPassCode:passCodeTextField.text])
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
    
    [connDictionary setObject:telTextField.text forKey:@"mobile"];
    [connDictionary setObject:passCodeTextField.text forKey:@"code"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
    
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,checkuserURL];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    [self showProgressViewWithMessage:@"正在核实证码..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         
         if([ret isEqualToString:@"100"])
         {
             [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
            
             ForgetPassword2ViewController* FP2VC=[[ForgetPassword2ViewController alloc]init];
             [FP2VC.transmitDict setObject:telTextField.text forKey:USER_MOBILE];
             [self.navigationController pushViewController:FP2VC animated:YES];
             
         }
         //相同账号同时登陆，返回错误
         else if([ret isEqualToString:reLoginOutFlag])
         {
             [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
         else
         {
             [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
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
    NSLog(@"%d\n",nCout);
    
    if (nCout>0)
    {
        nCout=nCout-1;
        [sendCheckCodeButton setTitle:[NSString stringWithFormat:@"获取(%d)",nCout] forState:UIControlStateDisabled];
        [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateNormal];
        [sendCheckCodeButton setEnabled:NO];
    }
    else if (nCout==0)
    {
        [sendCheckCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
        [sendCheckCodeButton setEnabled:YES];
        nCout=60;
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
    [passCodeTextField resignFirstResponder];
    
    [passwordTextField resignFirstResponder];
    [passwordTextField2 resignFirstResponder];
  
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
