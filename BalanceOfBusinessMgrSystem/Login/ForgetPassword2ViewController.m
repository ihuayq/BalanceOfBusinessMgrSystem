//
//  ForgetPassword2ViewController.m
//  jxtuan
//
//  Created by 融通互动 on 13-10-18.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "ForgetPassword2ViewController.h"
#import "NSData+Addition.h"

@interface ForgetPassword2ViewController ()

@end

@implementation ForgetPassword2ViewController
@synthesize transmitDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        transmitDict=[[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
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
    topBarTextLable.text = @"输入新密码";
    topBarTextLable.textAlignment = NSTextAlignmentCenter;
    topBarTextLable.backgroundColor = [UIColor clearColor];
    topBarTextLable.textColor = [UIColor whiteColor];
    topBarTextLable.font = [UIFont systemFontOfSize:18];
    //   topBarTextLable.font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    //topBarTextLable.shadowOffset=CGSizeMake(1, 1);
    //topBarTextLable.shadowColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    [topBarView addSubview:topBarTextLable];
    
    
    HP_UIButton *backButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 17, 45, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_highlight"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(goToBackView) forControlEvents:UIControlEventTouchUpInside];
    [topBarView addSubview:backButton];
    
    
    
    
    HP_UIImageView *bg1ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, 100,MainWidth-40, 40)];
    [bg1ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:bg1ImageView];
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 70,40)];
    passwordLabel.text = @"密码:";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:passwordLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
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
    
    
    UILabel * tishiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100+40, MainWidth, 40)];
    tishiLable.text =mima_tishiyu_6_20;
    tishiLable.textAlignment = NSTextAlignmentCenter;
    tishiLable.textColor = [HP_UIColorUtils colorWithHexString:TOPBAR_COLOR];
    tishiLable.font = [UIFont systemFontOfSize:14];
    tishiLable.backgroundColor = [UIColor clearColor];
    [bgView addSubview:tishiLable];
    
    
        //-----------
    HP_UIImageView *bg2ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, 180,MainWidth-40, 40)];
    [bg2ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:bg2ImageView];
    
    
    UILabel * passwordLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 100+80, 70, 40)];
    passwordLabel2.text = @"再次输入:";
    passwordLabel2.textAlignment = NSTextAlignmentLeft;
    passwordLabel2.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel2.font = [UIFont systemFontOfSize:14];
    passwordLabel2.backgroundColor = [UIColor clearColor];
    [bgView addSubview:passwordLabel2];
    
    passwordTextField2 = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, 100+80, 200, 40)];
    [passwordTextField2 setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField2.backgroundColor = [UIColor clearColor];
    passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField2.placeholder = @"请确认登录密码";
    passwordTextField2.font = [UIFont systemFontOfSize:14];
    passwordTextField2.delegate = self;
    passwordTextField2.keyboardType = UIKeyboardTypeDefault;
    passwordTextField2.borderStyle = UITextBorderStyleNone;
    passwordTextField2.secureTextEntry=YES;
    [bgView addSubview:passwordTextField2];
    
    
    
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, 240, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchChangePasswordButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:registerButton];
    
    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*30, 40)];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.backgroundColor = [UIColor clearColor];
    registerLabel.text = @"确认";
    registerLabel.textColor = [UIColor whiteColor];
    registerLabel.font = [UIFont systemFontOfSize:15];
    [registerButton addSubview:registerLabel];
    
    
    
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
-(void)touchChangePasswordButton
{
    
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
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:7];
    
   [connDictionary setObject:[transmitDict objectForKey:USER_MOBILE] forKey:@"mobile"];
    [connDictionary setObject:@"find" forKey:@"type"];
    
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"newpass"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
    
    [connDictionary setObject:string3des forKey:@"newpass"];
    
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,setuserpassURL];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    [self showProgressViewWithMessage:@"正在设置新密码..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             
             
             UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"设置新密码成功" delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
             alertView.tag = 111;
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
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==111)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
