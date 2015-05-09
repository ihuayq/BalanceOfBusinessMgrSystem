//
//  SetPayMoneyPasswordViewController.m
//  AllBelieve
//
//  Created by fengxiaoguang on 14-3-9.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import "SetPayMoneyPasswordViewController.h"

@interface SetPayMoneyPasswordViewController ()

@end

@implementation SetPayMoneyPasswordViewController
@synthesize transmitDict;
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
    topBarTextLable.text = @"设置支付密码";
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
    
    
    
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, 90,MainWidth-40, 40)];
    [bgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:bgImageView];
    
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 90, 70, 40)];
    passwordLabel.text = @"支付密码:";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:passwordLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, 90, 200, 40)];
    [passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入支付密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.secureTextEntry=YES;
    [bgView addSubview:passwordTextField];
    
    
    UILabel * tishiLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 100+40, MainWidth-30, 40)];
    tishiLable.text =[NSString stringWithFormat:@"%@支付密码不能与登录密码相同。",mima_tishiyu_6_20];
    tishiLable.textAlignment = NSTextAlignmentCenter;
    tishiLable.textColor = [HP_UIColorUtils colorWithHexString:TOPBAR_COLOR];
    tishiLable.font = [UIFont systemFontOfSize:14];
    tishiLable.backgroundColor = [UIColor clearColor];
    tishiLable.numberOfLines=0;
    [bgView addSubview:tishiLable];
    
    
    HP_UIImageView *bg2ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, 190,MainWidth-40, 40)];
    [bg2ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:bg2ImageView];
    
    UILabel * passwordLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 100+90, 70, 40)];
    passwordLabel2.text = @"再次输入:";
    passwordLabel2.textAlignment = NSTextAlignmentLeft;
    passwordLabel2.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel2.font = [UIFont systemFontOfSize:14];
    passwordLabel2.backgroundColor = [UIColor clearColor];
    [bgView addSubview:passwordLabel2];
    
    passwordTextField2 = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, 100+90, 200, 40)];
    [passwordTextField2 setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField2.backgroundColor = [UIColor clearColor];
    passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField2.placeholder = @"请确认支付密码";
    passwordTextField2.font = [UIFont systemFontOfSize:14];
    passwordTextField2.delegate = self;
    passwordTextField2.keyboardType = UIKeyboardTypeDefault;
    passwordTextField2.borderStyle = UITextBorderStyleNone;
    passwordTextField2.secureTextEntry=YES;
    [bgView addSubview:passwordTextField2];
    
    
    
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, 250, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchChangePasswordButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:registerButton];
    
    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*20, 40)];
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


-(void)touchChangePasswordButton
{
}
//-(void)touchChangePasswordButton
//{
//    
//    if (![self checkPassword:passwordTextField.text checkPassword2:passwordTextField2.text])
//    {
//        return;
//    }
//    if (![HP_NetWorkUtils isNetWorkEnable])
//    {
//        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
//        return;
//    }
//    
//    [self touchesBegan:nil withEvent:nil];
//    
//    //网络请求
//    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSString *url = nil;
//
//
//    
//    
//    
//    if ([[self.transmitDict objectForKey:QPOS]isEqualToString:QPOS])
//    {
//        [connDictionary setObject:[transmitDict objectForKey:QPOS_PHONE_NO] forKey:@"mobile"];
//        [connDictionary setObject:[transmitDict objectForKey:QPOS_MERCHANT_NO] forKey:@"platformmerno"];
//
//        
//        NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:[transmitDict objectForKey:USER_PASSWORD]];//3DES加密
//        NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
//        [connDictionary setObject:encodedValue forKey:@"passwd"];
//        
//        
//        NSString* string3des1=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
//        NSString *encodedValue1 = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des1];//编码encode
//        [connDictionary setObject:encodedValue1 forKey:@"paypasswd"];
//        
//        
//        
//        [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
//        
//        [connDictionary setObject:string3des forKey:@"passwd"];
//        [connDictionary setObject:string3des1 forKey:@"paypasswd"];
//        
//        url =[NSString stringWithFormat:@"%@%@",HostURL,merchantregisterURL];
//        
//
//    }
//    else
//    {
//        [connDictionary setObject:[transmitDict objectForKey:USER_MOBILE] forKey:@"mobile"];
//        [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"devId"];//设备id
//        if ([transmitDict objectForKey:OTHERS_INVITECODE])
//        {
//            [connDictionary setObject:[transmitDict objectForKey:OTHERS_INVITECODE] forKey:INVITECODE];
//        }
//        
//        
//        NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:[transmitDict objectForKey:USER_PASSWORD]];//3DES加密
//        NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
//        [connDictionary setObject:encodedValue forKey:@"passwd"];
//        
//        
//        NSString* string3des1=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
//        NSString *encodedValue1 = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des1];//编码encode
//        [connDictionary setObject:encodedValue1 forKey:@"paypasswd"];
//        
//        [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
//        
//        [connDictionary setObject:string3des forKey:@"passwd"];
//        [connDictionary setObject:string3des1 forKey:@"paypasswd"];
//        
//        //不参加签名
//        
//        
//        
//        
//        url =[NSString stringWithFormat:@"%@%@",HostURL,registerURL];
//
//    }
//    
//    
//    NSLog(@"connDictionary:%@",connDictionary);
//    
//    [self showProgressViewWithMessage:@"正在设置支付码..."];
//    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
//     {
//         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
//         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
//         if([ret isEqualToString:@"100"])
//         {
//             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
//             
//             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
//             [Dict setObject:[responseJSONDictionary objectForKey:@"userid"] forKey:USER_ID];
//             [Dict setObject:[responseJSONDictionary objectForKey:MOBILE] forKey:USER_MOBILE];
//             [Dict setObject:[responseJSONDictionary objectForKey:AUTHSTATUS] forKey:AUTHSTATUS];
//             [Dict setObject:[responseJSONDictionary objectForKey:BANKBINDSTAUS] forKey:BANKBINDSTAUS];
//             [Dict setObject:[responseJSONDictionary objectForKey:PLATFORMUSERID] forKey:PLATFORMUSERID];
//             [Dict setObject:[responseJSONDictionary objectForKey:USERTYPE] forKey:USERTYPE];
//             [Dict setObject:[self delStringNull:[responseJSONDictionary objectForKey:INVITECODE]] forKey:USER_INVITECODE];
//             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:USERINFO];
//             
//             
//             [[self getNSUserDefaults] setObject:@"1" forKey:LOGIN_STATUS];//0未登陆、1的登陆
//             [[NSUserDefaults standardUserDefaults]setObject:[transmitDict objectForKey:USER_MOBILE] forKey:LAST_LOGIN_NAME];
//             [[NSUserDefaults standardUserDefaults] setObject:Register_First forKey:Register_First];
//             
//             MainViewController * mainview=[[MainViewController alloc]init];
//             [self.navigationController pushViewController:mainview animated:YES];
//             
//         }
//         else
//         {
//             
//             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
//         }
//     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg)
//     {
//         
//         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
//         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
//         alertView.tag = 999;
//         [alertView show];
//     }];
//}

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
