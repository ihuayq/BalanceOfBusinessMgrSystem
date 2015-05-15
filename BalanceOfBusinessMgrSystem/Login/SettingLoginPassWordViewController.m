//
//  SettingLoginPassWordViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/6.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "SettingLoginPassWordViewController.h"
#import "SettingLoginPassWord2ViewController.h"


@implementation SettingLoginPassWordViewController


@synthesize transmitDict;
@synthesize sendLabel = sendLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        transmitDict=[[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.  
    self.navigation.navigaionBackColor =  [UIColor orangeColor];
    self.navigation.title = @"设置登录密码";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    [self initUI];
    
}


#define PASSWORD_OUTLET_POSITION passwordTextField.frame.origin.y + passwordTextField.frame.size.height
#define CONFIRM_PASSWORD_OUTLET_POSITION passwordTextField2.frame.origin.y + passwordTextField2.frame.size.height
#define RECEIVE_PASSWORD_OUTLET_POSITION sendCheckCodeButton.frame.origin.y + sendCheckCodeButton.frame.size.height

-(void) initUI
{
    //设置标题
    UILabel * notePsdLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10, 240, 40)];
    notePsdLabel.text = @"登录成功，请设置登录密码";
    notePsdLabel.textAlignment = NSTextAlignmentCenter;
    notePsdLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    notePsdLabel.font = [UIFont systemFontOfSize:18];
    notePsdLabel.backgroundColor = [UIColor clearColor];
    notePsdLabel.numberOfLines = 0;
    [self.view addSubview:notePsdLabel];
    
    //设置密码设置信息
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 90,MainWidth-40, 40)];
    [bgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView];
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 90, 70, 40)];
    passwordLabel.text = @"登录密码:";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, NAVIGATION_OUTLET_HEIGHT + 90, 200, 40)];
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

    //密码信息确认
    HP_UIImageView *bg2ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, PASSWORD_OUTLET_POSITION + 20,MainWidth-40, 40)];
    [bg2ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg2ImageView];
    
    UILabel * passwordLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, PASSWORD_OUTLET_POSITION+20, 70, 40)];
    passwordLabel2.text = @"再次输入:";
    passwordLabel2.textAlignment = NSTextAlignmentLeft;
    passwordLabel2.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel2.font = [UIFont systemFontOfSize:14];
    passwordLabel2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel2];
    
    passwordTextField2 = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, PASSWORD_OUTLET_POSITION+20, 200, 40)];
    [passwordTextField2 setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField2.backgroundColor = [UIColor clearColor];
    passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField2.placeholder = @"请确认登陆密码";
    passwordTextField2.font = [UIFont systemFontOfSize:14];
    passwordTextField2.delegate = self;
    passwordTextField2.keyboardType = UIKeyboardTypeDefault;
    passwordTextField2.borderStyle = UITextBorderStyleNone;
    passwordTextField2.secureTextEntry=YES;
    [self.view addSubview:passwordTextField2];
    
    
    //短信验证码
    HP_UIImageView *bg3ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, CONFIRM_PASSWORD_OUTLET_POSITION+20,190, 40)];
    [bg3ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg3ImageView];
    
    UILabel * checkwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CONFIRM_PASSWORD_OUTLET_POSITION+20, 70, 40)];
    checkwordLabel.text = @"验证码:";
    checkwordLabel.textAlignment = NSTextAlignmentLeft;
    checkwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    checkwordLabel.font = [UIFont systemFontOfSize:14];
    checkwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:checkwordLabel];
    
    passCodeTextField3 = [[HP_UITextField alloc] initWithFrame:CGRectMake(90, CONFIRM_PASSWORD_OUTLET_POSITION+20, 110, 40)];
    [passCodeTextField3 setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passCodeTextField3.backgroundColor = [UIColor clearColor];
    passCodeTextField3.clearButtonMode = UITextFieldViewModeAlways;
    passCodeTextField3.placeholder = @"请输入验证码";
    passCodeTextField3.font = [UIFont systemFontOfSize:14];
    passCodeTextField3.delegate = self;
    passCodeTextField3.keyboardType = UIKeyboardTypeNumberPad;
    passCodeTextField3.borderStyle = UITextBorderStyleNone;
    passCodeTextField3.secureTextEntry=NO;
    [self.view addSubview:passCodeTextField3];
    
    
    sendCheckCodeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"senddj"] forState:UIControlStateHighlighted];
    [sendCheckCodeButton setBackgroundColor:[HP_UIColorUtils clearColor]];
    [sendCheckCodeButton setFrame:CGRectMake(215, CONFIRM_PASSWORD_OUTLET_POSITION+20, 85, 40)];
    [sendCheckCodeButton addTarget:self action:@selector(touchSendCheckCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendCheckCodeButton];
    
    UILabel *sendCheckCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 40)];
    sendCheckCodeLabel.textAlignment = NSTextAlignmentCenter;
    sendCheckCodeLabel.backgroundColor = [UIColor clearColor];
    sendCheckCodeLabel.text = @"获取验证码";
    sendCheckCodeLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    sendCheckCodeLabel.font = [UIFont systemFontOfSize:15];
    [sendCheckCodeButton addSubview:sendCheckCodeLabel];

    
    sendLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, RECEIVE_PASSWORD_OUTLET_POSITION, 285, 40)];
    sendLabel.textAlignment = NSTextAlignmentCenter;
    sendLabel.backgroundColor = [UIColor clearColor];
    sendLabel.text = @"验证码已发送，有效期30分钟";
    sendLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    sendLabel.font = [UIFont systemFontOfSize:15];
    sendLabel.hidden = YES;
    [self.view  addSubview:sendLabel];
    
    //确定
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, CONFIRM_PASSWORD_OUTLET_POSITION + 100, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchSettingPasswordButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"确定" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
    [self.view addSubview:registerButton];
    
//    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*20, 40)];
//    registerLabel.textAlignment = NSTextAlignmentCenter;
//    registerLabel.backgroundColor = [UIColor clearColor];
//    registerLabel.text = @"确认";
//    registerLabel.textColor = [UIColor whiteColor];
//    registerLabel.font = [UIFont systemFontOfSize:15];
//    [registerButton addSubview:registerLabel];
}

-(void)touchSettingPasswordButton{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    
    [self touchesBegan:nil withEvent:nil];
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:passCodeTextField3.text forKey:@"verificationCode"];
    
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"newPassword"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@",SetLoginPasswdURL];
    
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
             [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] setObject:@"1" forKey:@"naturalMark"];
             
             [self.navigationController popViewControllerAnimated:YES];
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

-(void)touchSendCheckCodeButton//请求验证码
{
//    if (![self checkTel:telTextField.text])
//    {
//        return;
//    }
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    
    [self touchesBegan:nil withEvent:nil];
    
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"phonenum"]forKey:@"phonenum"];
    
    //[connDictionary setObject:[responseJSONDictionary objectForKey:@"phonenum"] forKey:@"phonenum"];
    
    //[connDictionary setObject:@"register" forKey:@"type"];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@",MessageCodeURL];
    
    [self showProgressViewWithMessage:@"正在获取验证码..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             //returnCodeSTring=[self delStringNull:[responseJSONDictionary objectForKey:@"code"]];
             
             //[self timeCountdown];
             //timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
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

-(void)goToBackView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)checkPassword:(NSString *)str1 checkPassword2:(NSString*)str2
{
    
    NSString* msgstring1=[str1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    // NSString* msgstring2=[str2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring1.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入支付密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (msgstring1.length<6)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"支付密码最少6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (![self checkPassWordString:str1])
    {
        return NO;
    }
    
    if (![str1 isEqualToString:str2])
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"支付密码输入不一致" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if ([str1 isEqualToString:[transmitDict objectForKey:USER_PASSWORD]])
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"支付密码不能与登录密码相同" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
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
    
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![^0-9a-zA-Z]+$).{6,20}$"];//6-16位 至少含有数字和字母
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"密码输入为%@",mima_tishiyu_6_20] delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    return YES;
}


-(void)touchChangePasswordButton
{
    SettingLoginPassWord2ViewController * mainview=[[SettingLoginPassWord2ViewController alloc]init];
    [self.navigationController pushViewController:mainview animated:YES];
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
    NSString *url = nil;

    if ([[self.transmitDict objectForKey:QPOS]isEqualToString:QPOS])
    {
        [connDictionary setObject:[transmitDict objectForKey:QPOS_PHONE_NO] forKey:@"mobile"];
        [connDictionary setObject:[transmitDict objectForKey:QPOS_MERCHANT_NO] forKey:@"platformmerno"];


        NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:[transmitDict objectForKey:USER_PASSWORD]];//3DES加密
        NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
        [connDictionary setObject:encodedValue forKey:@"passwd"];


        NSString* string3des1=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
        NSString *encodedValue1 = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des1];//编码encode
        [connDictionary setObject:encodedValue1 forKey:@"paypasswd"];



        [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];

        [connDictionary setObject:string3des forKey:@"passwd"];
        [connDictionary setObject:string3des1 forKey:@"paypasswd"];

        url =[NSString stringWithFormat:@"%@%@",HostURL,merchantregisterURL];


    }
    else
    {
        [connDictionary setObject:[transmitDict objectForKey:USER_MOBILE] forKey:@"mobile"];
        [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"devId"];//设备id
        if ([transmitDict objectForKey:OTHERS_INVITECODE])
        {
            [connDictionary setObject:[transmitDict objectForKey:OTHERS_INVITECODE] forKey:INVITECODE];
        }


        NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:[transmitDict objectForKey:USER_PASSWORD]];//3DES加密
        NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
        [connDictionary setObject:encodedValue forKey:@"passwd"];


        NSString* string3des1=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
        NSString *encodedValue1 = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des1];//编码encode
        [connDictionary setObject:encodedValue1 forKey:@"paypasswd"];

        [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];

        [connDictionary setObject:string3des forKey:@"passwd"];
        [connDictionary setObject:string3des1 forKey:@"paypasswd"];

        //不参加签名
        url =[NSString stringWithFormat:@"%@%@",HostURL,registerURL];

    }


    NSLog(@"connDictionary:%@",connDictionary);

    [self showProgressViewWithMessage:@"正在设置登录密码..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];

             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             [Dict setObject:[responseJSONDictionary objectForKey:@"userid"] forKey:USER_ID];
             [Dict setObject:[responseJSONDictionary objectForKey:MOBILE] forKey:USER_MOBILE];
             [Dict setObject:[responseJSONDictionary objectForKey:AUTHSTATUS] forKey:AUTHSTATUS];
             [Dict setObject:[responseJSONDictionary objectForKey:BANKBINDSTAUS] forKey:BANKBINDSTAUS];
             [Dict setObject:[responseJSONDictionary objectForKey:PLATFORMUSERID] forKey:PLATFORMUSERID];
             [Dict setObject:[responseJSONDictionary objectForKey:USERTYPE] forKey:USERTYPE];
             [Dict setObject:[self delStringNull:[responseJSONDictionary objectForKey:INVITECODE]] forKey:USER_INVITECODE];
             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:USERINFO];


             [[self getNSUserDefaults] setObject:@"1" forKey:LOGIN_STATUS];//0未登陆、1的登陆
             [[NSUserDefaults standardUserDefaults]setObject:[transmitDict objectForKey:USER_MOBILE] forKey:LAST_LOGIN_NAME];
             [[NSUserDefaults standardUserDefaults] setObject:Register_First forKey:Register_First];

             //MainViewController * mainview=[[MainViewController alloc]init];
             //[self.navigationController pushViewController:mainview animated:YES];
             
             SettingLoginPassWord2ViewController * mainview=[[SettingLoginPassWord2ViewController alloc]init];
             [self.navigationController pushViewController:mainview animated:YES];

         }
         else
         {

             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg)
     {

         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}

#pragma mark -
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
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
    if (textField==passwordTextField2)
    {
        if (string.length > 0)
        {
            if ([string isEqualToString:@" "])
            {
                return NO;
            }
            return passwordTextField2.text.length < 20;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [passwordTextField resignFirstResponder];
    [passwordTextField2 resignFirstResponder];
    [passCodeTextField3 resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end