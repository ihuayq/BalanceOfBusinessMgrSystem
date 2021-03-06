//
//  BMSettingTransactionpPasswordViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/12.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMSettingTransactionpPasswordViewController.h"
#import "SettingLoginPassWord2ViewController.h"


@interface BMSettingTransactionpPasswordViewController (){
    NSString *phoneNum;
}

@end

@implementation BMSettingTransactionpPasswordViewController



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
    self.navigation.title = @"设置交易密码";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    [self initUI];
    
}


#define OLD_PASSWORD_OUTLET_POSITION oldPasswordTextField.frame.origin.y + oldPasswordTextField.frame.size.height
#define PASSWORD_OUTLET_POSITION passwordTextField.frame.origin.y + passwordTextField.frame.size.height
#define CONFIRM_PASSWORD_OUTLET_POSITION passwordTextField2.frame.origin.y + passwordTextField2.frame.size.height
#define RECEIVE_PASSWORD_OUTLET_POSITION sendCheckCodeButton.frame.origin.y + sendCheckCodeButton.frame.size.height

-(void) initUI
{
    //授权人手机号码
    UIFont *font = [UIFont systemFontOfSize:18];
    
    UILabel *notePsdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//这个frame是初设的，没关系，后面还会重新设置其size。
    [notePsdLabel setNumberOfLines:0];
    NSString *s = @"手机号:";
    CGSize size = CGSizeMake(320,40);
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [notePsdLabel setFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 20, labelsize.width, labelsize.height)];
    notePsdLabel.text = s;
    [self.view addSubview:notePsdLabel];
    
    UILabel * telLabel = [[UILabel alloc] initWithFrame:CGRectMake(notePsdLabel.frame.origin.x+ labelsize.width, NAVIGATION_OUTLET_HEIGHT + 20, 240, labelsize.height)];
    //手机号码
    telLabel.text = phoneNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNum"];
    telLabel.textAlignment = NSTextAlignmentLeft;
    telLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telLabel.font = [UIFont systemFontOfSize:18];
    telLabel.backgroundColor = [UIColor clearColor];
    telLabel.numberOfLines = 0;
    [self.view addSubview:telLabel];
    
    //交易密码
    HP_UIImageView *oldbgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, notePsdLabel.frame.origin.y+ labelsize.height + 20,MainWidth-40, 40)];
    [oldbgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:oldbgImageView];
    
    UILabel * oldPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, notePsdLabel.frame.origin.y+ labelsize.height + 20, 80, 40)];
    oldPasswordLabel.text = @"原交易密码:";
    oldPasswordLabel.textAlignment = NSTextAlignmentLeft;
    oldPasswordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    oldPasswordLabel.font = [UIFont systemFontOfSize:14];
    oldPasswordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:oldPasswordLabel];
    
    oldPasswordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(110, notePsdLabel.frame.origin.y+ labelsize.height + 20, 190, 40)];
    [oldPasswordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    oldPasswordTextField.backgroundColor = [UIColor clearColor];
    oldPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
    oldPasswordTextField.placeholder = @"请输入原交易密码";
    oldPasswordTextField.font = [UIFont systemFontOfSize:14];
    oldPasswordTextField.delegate = self;
    oldPasswordTextField.keyboardType = UIKeyboardTypeDefault;
    oldPasswordTextField.borderStyle = UITextBorderStyleNone;
    oldPasswordTextField.secureTextEntry=YES;
    [self.view addSubview:oldPasswordTextField];
    
    
    //交易密码
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, OLD_PASSWORD_OUTLET_POSITION + 20,MainWidth-40, 40)];
    [bgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView];
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, OLD_PASSWORD_OUTLET_POSITION + 20, 70, 40)];
    passwordLabel.text = @"交易密码:";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, OLD_PASSWORD_OUTLET_POSITION + 20, 200, 40)];
    [passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入6位交易密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.secureTextEntry=YES;
    [self.view addSubview:passwordTextField];
    
    //确认交易密码
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
    passwordTextField2.placeholder = @"请确认6位交易密码";
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
    passCodeTextField3.keyboardType = UIKeyboardTypeDefault;
    passCodeTextField3.borderStyle = UITextBorderStyleNone;
    passCodeTextField3.secureTextEntry=NO;
    [self.view addSubview:passCodeTextField3];
    
    sendCheckCodeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [sendCheckCodeButton setBackgroundColor:[HP_UIColorUtils clearColor]];
    [sendCheckCodeButton setFrame:CGRectMake(215, CONFIRM_PASSWORD_OUTLET_POSITION+20, 85, 40)];
    [sendCheckCodeButton addTarget:self action:@selector(touchSendCheckCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [sendCheckCodeButton setTitle: @"获取验证码" forState:UIControlStateNormal];
    sendCheckCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sendCheckCodeButton];
    
//    UILabel *sendCheckCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 40)];
//    sendCheckCodeLabel.textAlignment = NSTextAlignmentCenter;
//    sendCheckCodeLabel.backgroundColor = [UIColor clearColor];
//    sendCheckCodeLabel.text = @"获取验证码";
//    sendCheckCodeLabel.textColor = [UIColor whiteColor];
//    sendCheckCodeLabel.font = [UIFont systemFontOfSize:15];
//    [sendCheckCodeButton addSubview:sendCheckCodeLabel];
    
    
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
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, CONFIRM_PASSWORD_OUTLET_POSITION + 100, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchSettingPasswordButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton setTitle:@"确认" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
//    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*20, 40)];
//    registerLabel.textAlignment = NSTextAlignmentCenter;
//    registerLabel.backgroundColor = [UIColor clearColor];
//    registerLabel.text = @"确认";
//    registerLabel.textColor = [UIColor whiteColor];
//    registerLabel.font = [UIFont systemFontOfSize:15];
//    [registerButton addSubview:registerLabel];
    nCout = 60;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    nCout = 60;
//
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//
//    //[timer invalidate];//取消定时器
//    
//}

- (void)viewDidDisappear:(BOOL)animated{
    nCout = 0;
    [self timeCountdown];
}

-(void)touchSettingPasswordButton{
    if (![self checkPassWordString:oldPasswordTextField.text])
    {
        return;
    }
    
    if (![self checkPassCode:passCodeTextField3.text]) {
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
//    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
//    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"phoneNum"]forKey:@"phoneNum"];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNum"]forKey:@"phoneNum"];
    [connDictionary setObject:passCodeTextField3.text forKey:@"verificationCode"];
    
    //旧的密码
    NSString* string3desOld=[[[NSData alloc] init] encrypyConnectDes:oldPasswordTextField.text];//3DES加密
    NSString *encodedValueOld = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3desOld];//编码encode
    [connDictionary setObject:encodedValueOld forKey:@"oldPayPassword"];
    
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"payPassword"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,ModifyPayPasswdURL];
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    [self showProgressViewWithMessage:@"正在设置交易密码..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             //returnCodeSTring=[self delStringNull:[responseJSONDictionary objectForKey:@"code"]];
             //[self timeCountdown];
             //timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountdown) userInfo:nil repeats:YES];
             [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"payMark"];
             [self.navigationController popViewControllerAnimated:YES];
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


-(void)touchSendCheckCodeButton//请求验证码
{
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    
    [self touchesBegan:nil withEvent:nil];
    
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNum"]forKey:@"phoneNum"];
    
    //[connDictionary setObject:@"register" forKey:@"type"];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,MessageCodeURL];
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
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
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入交易密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (msgstring1.length<6)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入6位交易密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (![self checkPassWordString:str1])
    {
        return NO;
    }
    
    if (![str1 isEqualToString:str2])
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"交易密码输入不一致" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if ([str1 isEqualToString:[transmitDict objectForKey:USER_PASSWORD]])
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"交易密码不能与登录密码相同" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
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
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入交易密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (msgstring.length != 6)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入6位密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    
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
            return passwordTextField.text.length < 6;
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
            return passwordTextField2.text.length < 6;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [passwordTextField resignFirstResponder];
    [passwordTextField2 resignFirstResponder];
    [passCodeTextField3 resignFirstResponder];
    [oldPasswordTextField resignFirstResponder];
}


@end
