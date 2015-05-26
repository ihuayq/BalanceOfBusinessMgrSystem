//
//  ModifyLoginPasswordViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/19.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ModifyLoginPasswordViewController.h"

@interface ModifyLoginPasswordViewController ()
{
    NSMutableDictionary* transmitDict;//传递过来的参数
    
    
    HP_UITextField * oldPasswordTextField;
    HP_UITextField * passwordTextField;
    HP_UITextField * passwordTextField2;
}

@property(nonatomic,strong)UILabel *sendLabel;
@property(nonatomic,retain)NSMutableDictionary* transmitDict;
@end


@implementation ModifyLoginPasswordViewController

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
    self.navigation.title = @"修改登录密码";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    [self initUI];
    
}

-(void) initUI
{
    //设置手机号
    UILabel * notePsdLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10, 60, 40)];
    notePsdLabel.text = @"手机号";
    notePsdLabel.textAlignment = NSTextAlignmentCenter;
    notePsdLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    notePsdLabel.font = [UIFont systemFontOfSize:18];
    notePsdLabel.backgroundColor = [UIColor clearColor];
    notePsdLabel.numberOfLines = 0;
    [self.view addSubview:notePsdLabel];
    
    UILabel * telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, NAVIGATION_OUTLET_HEIGHT + 10, 120, 40)];
    telephoneLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"phoneNum"];
    telephoneLabel.textAlignment = NSTextAlignmentCenter;
    telephoneLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telephoneLabel.font = [UIFont systemFontOfSize:18];
    telephoneLabel.backgroundColor = [UIColor clearColor];
    telephoneLabel.numberOfLines = 0;
    [self.view addSubview:telephoneLabel];
    
    //旧的密码
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20,notePsdLabel.frame.origin.y + notePsdLabel.frame.size.height + 20,MainWidth-40, 40)];
    [bgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView];
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, notePsdLabel.frame.origin.y + notePsdLabel.frame.size.height +20, 80, 40)];
    passwordLabel.text = @"旧登录密码:";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel];
    
    oldPasswordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(110, notePsdLabel.frame.origin.y + notePsdLabel.frame.size.height +20, 190, 40)];
    [oldPasswordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    oldPasswordTextField.backgroundColor = [UIColor clearColor];
    oldPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
    oldPasswordTextField.placeholder = @"请输入旧登录密码";
    oldPasswordTextField.font = [UIFont systemFontOfSize:14];
    oldPasswordTextField.delegate = self;
    oldPasswordTextField.keyboardType = UIKeyboardTypeDefault;
    oldPasswordTextField.borderStyle = UITextBorderStyleNone;
    oldPasswordTextField.secureTextEntry=YES;
    [self.view addSubview:oldPasswordTextField];
    
    //密码信息
    HP_UIImageView *bg2ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, bgImageView.frame.origin.y + bgImageView.frame.size.height + 20,MainWidth-40, 40)];
    [bg2ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg2ImageView];
    
    UILabel * passwordLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(35, bgImageView.frame.origin.y + bgImageView.frame.size.height+20, 65, 40)];
    passwordLabel2.text = @"登录密码:";
    passwordLabel2.textAlignment = NSTextAlignmentLeft;
    passwordLabel2.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel2.font = [UIFont systemFontOfSize:14];
    passwordLabel2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel2];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(105, bgImageView.frame.origin.y + bgImageView.frame.size.height+20, 195, 40)];
    [passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"新的登录密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.secureTextEntry=YES;
    [self.view addSubview:passwordTextField];
    
    
    //密码信息确认
    HP_UIImageView *bg3ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20,  bg2ImageView.frame.origin.y + bg2ImageView.frame.size.height+20,MainWidth-40, 40)];
    [bg3ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg3ImageView];
    
    UILabel * passwordLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(30, bg2ImageView.frame.origin.y + bg2ImageView.frame.size.height+20, 90, 40)];
    passwordLabel3.text = @"确认登录密码:";
    passwordLabel3.textAlignment = NSTextAlignmentLeft;
    passwordLabel3.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel3.font = [UIFont systemFontOfSize:14];
    passwordLabel3.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel3];
    
    passwordTextField2 = [[HP_UITextField alloc] initWithFrame:CGRectMake(125, bg2ImageView.frame.origin.y + bg2ImageView.frame.size.height+20, 175, 40)];
    [passwordTextField2 setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField2.backgroundColor = [UIColor clearColor];
    passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField2.placeholder = @"再次输入密码";
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
    [registerButton setFrame:CGRectMake(20, bg3ImageView.frame.origin.y + bg3ImageView.frame.size.height + 100, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchSettingPasswordButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
    [self.view addSubview:registerButton];
    
}

-(void)touchSettingPasswordButton{
    if (![self checkOldPassWordString:oldPasswordTextField.text])
    {
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
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    
    //新密码
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"newPassword"];
    //旧的密码
    NSString* string3desOld=[[[NSData alloc] init] encrypyConnectDes:oldPasswordTextField.text];//3DES加密
    NSString *encodedValueOld = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3desOld];//编码encode
    [connDictionary setObject:encodedValueOld forKey:@"oldPassword"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,ModifyLoginPasswdURL];
    
    [self showProgressViewWithMessage:@"正在重新设置登录密码..."];
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
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入登陆密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (msgstring1.length<6)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"登陆密码最少6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    if (![self checkPassWordString:str1])
    {
        return NO;
    }
    
    if (![str1 isEqualToString:str2])
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"登陆密码输入不一致" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
//    if ([str1 isEqualToString:[transmitDict objectForKey:USER_PASSWORD]])
//    {
//        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"交易密码不能与登录密码相同" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alertview show];
//        return NO;
//    }
    return YES;
    
}

- (BOOL)checkPassWordString:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入登陆密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    //    if (msgstring.length<6)
    //    {
    //        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"密码输入少于6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
    //        [alertview show];
    //        return NO;
    //    }
    
    
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

- (BOOL)checkOldPassWordString:(NSString *)str
{
    
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入旧登陆密码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    //    if (msgstring.length<6)
    //    {
    //        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"密码输入少于6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
    //        [alertview show];
    //        return NO;
    //    }
    
    
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
    [oldPasswordTextField resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
