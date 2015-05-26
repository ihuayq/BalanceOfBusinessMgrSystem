//
//  LoginViewController.m
//  jxtuan
//
//  Created by 融通互动 on 13-8-19.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "LoginViewController.h"
#import "ControllerConfig.h"
#import "RadioButton.h"
#import "SettingLoginPassWordViewController.h"
#import "BMCommercialTenantMainViewController.h"
#import "BMNaturalManMainViewController.h"
#import "ProgressHUD.h"
#import "SCNavTabBarController.h"
#import "RFSegmentView.h"



@interface LoginViewController ()<RadioButtonDelegate,RFSegmentViewDelegate>{
    BOOL isSupplerSelected;
}

@property(nonatomic,retain)RadioButton *radioSupplyer;
@property(nonatomic,retain)RadioButton *radioMember;
@property(nonatomic,retain)RadioButton * forgetButton;
@property(nonatomic,assign)BOOL isSupplerSelected;

@end

@implementation LoginViewController
@synthesize nameTextField;
@synthesize isSupplerSelected = _isSupplerSelected;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isSupplerSelected = true;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    //nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME]];
    //[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:LAST_LOGIN_NAME];
    [passwordTextField setText:@""];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self initUI];
}

-(void) initUI
{
    //    self.radioSupplyer=[[RadioButton alloc] initWithFrame:CGRectMake(36, logoImageView.frame.origin.y+logoImageView.frame.size.height+20, 100, 25) typeCheck:YES];
    //    [self.radioSupplyer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.radioSupplyer setTitle:@"商户" forState:UIControlStateNormal];
    //    self.radioSupplyer.titleLabel.font=[UIFont systemFontOfSize:12];
    //    self.radioSupplyer.delegate=self;
    //    self.radioSupplyer.tag=707;
    //    [self.view addSubview:self.radioSupplyer];
    //
    //    self.radioMember=[[RadioButton alloc] initWithFrame:CGRectMake(36+MainWidth/2, logoImageView.frame.origin.y+logoImageView.frame.size.height+20, 100, 25) typeCheck:NO];
    //    [self.radioMember setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.radioMember setTitle:@"授权人" forState:UIControlStateNormal];
    //    self.radioMember.titleLabel.font=[UIFont systemFontOfSize:12];
    //    self.radioMember.delegate=self;
    //    self.radioMember.tag=708;
    //    [self.view addSubview:self.radioMember];

    HP_UIImageView *logoImageView = [[HP_UIImageView alloc] init ];
    [logoImageView setFrame:CGRectMake(0, 0, MainWidth, MainHeight/3)];
    [logoImageView setImage:[UIImage imageNamed:@"loginpage"]];
    [self.view addSubview:logoImageView];
    
    NSMutableArray *chooseArray = [NSMutableArray arrayWithObjects:@"商户",@"自然人",nil];

    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, logoImageView.frame.origin.y+logoImageView.frame.size.height, ScreenWidth, 60) items:@[@"商户",@"自然人"]];
    segmentView.tintColor = [self getRandomColor];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    
    //设置 姓名信息
    HP_UIImageView *bgImageView10 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView10 setImage:[UIImage imageNamed:@"姓名"]];

    HP_UIImageView *bgImageView11 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20,segmentView.frame.size.height + segmentView.frame.origin.y + 20,MainWidth-40, 40)];
    [bgImageView11 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView11 ];
    [bgImageView11 addSubview:bgImageView10];

    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60, segmentView.frame.size.height + segmentView.frame.origin.y + 20, 240, 40)];
    [nameTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.placeholder = @"请输入用户账号";
    nameTextField.font = [UIFont systemFontOfSize:14];
    nameTextField.delegate = self;
    nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    nameTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:nameTextField];
    
    //设置密码设置信息
    HP_UIImageView *bgImageView20 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView20 setImage:[UIImage imageNamed:@"密码"]];
    [self.view  addSubview:bgImageView20];

    HP_UIImageView *bgImageView21 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, nameTextField.frame.size.height + nameTextField.frame.origin.y + 20,MainWidth-40, 40)];
    [bgImageView21 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView21];
    [bgImageView21 addSubview:bgImageView20];


    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60,nameTextField.frame.size.height + nameTextField.frame.origin.y + 20, 240, 40)];
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
    
    _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetButton.frame = CGRectMake(MainWidth - 85 - 40, MainHeight-175, 85, 15);
    [_forgetButton setBackgroundImage:[UIImage imageNamed:@"forgetpassword"] forState:UIControlStateNormal];
    _forgetButton.backgroundColor = [UIColor clearColor];
    [_forgetButton addTarget:self action:@selector(touchForgetButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetButton];
    _forgetButton.hidden = YES;
    
//    f84206 橘红色按钮点击后及其他非按钮的橘红色色值
//    f9551c 点击前色值
    UIButton *loginButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [loginButton setBackgroundColor:[UIColor clearColor]];
    [loginButton setFrame:CGRectMake(20, MainHeight-140, MainWidth-40, 40)];
    [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:loginButton.frame.size.height/2.0f];
    [self.view addSubview:loginButton];
}

- (UIColor *)getRandomColor
{
    //UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    UIColor *color = [self getColor:@"f9551c"];
    return color;
}

- (UIColor *)getColor:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}


- (void)segmentViewSelectIndex:(NSInteger)index{
    
    if (index == 0) {
        _isSupplerSelected = TRUE;
    }
    else{
        _isSupplerSelected = FALSE;
    }
    
    if (_isSupplerSelected) {
        //刷新商户填充信息
        nameTextField.placeholder = @"请输入Qpos/POS平台账号";
        passwordTextField.placeholder = @"请输入Qpos/POS平台密码";
        self.forgetButton.hidden = YES;
    }
    else{
        nameTextField.placeholder = @"请输入手机号码";
        passwordTextField.placeholder = @"请输入密码";
        self.forgetButton.hidden = NO;
    }
    nameTextField.text = @"";
    passwordTextField.text = @"";
}

-(void)setIsSupplerSelected:(BOOL)isSupplerSelected{
    _isSupplerSelected = isSupplerSelected;
    if (_isSupplerSelected) {
        //刷新商户填充信息
        nameTextField.placeholder = @"请输入Qpos/POS平台账号";
        passwordTextField.placeholder = @"请输入Qpos/POS平台密码";
        self.forgetButton.hidden = YES;
    }
    else{
        nameTextField.placeholder = @"请输入手机号码";
        passwordTextField.placeholder = @"请输入密码";
         self.forgetButton.hidden = NO;
    }
}

- (void)updataEnterInfo
{
    
}

- (void)setUserName:(NSString *)name
{
    nameTextField.userInteractionEnabled = NO;
    [nameTextField setText:name];
}

-(void)touchForgetButton
{
    ForgetPasswordViewController * fpw = [[ForgetPasswordViewController alloc] init];
        //[self.navigationController pushViewController:fpw animated:YES];
    //[self presentViewController:fpw animated:YES completion:NULL];
    [self presentModalViewController:fpw animated:YES];
}

-(void)touchRegisterButton
{
    
    [self touchesBegan:nil withEvent:nil];
    
    RegisterViewController* registervc=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registervc animated:YES];
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
}
- (BOOL)checkName:(NSString *)str
{
    NSString* msgstring=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入手机号码" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
//    NSString *regex = PhoneNoRegex;
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:str];
//    
//    if (!isMatch)
//    {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alert show];
//        return NO;
//        
//    }
    return YES;
}


-(void)touchLoginButton
{
    //    //验证身份证
    //    - (BOOL)checkshenfenzhengString:(NSString *)str;
    //    //验证手机号
    //    - (BOOL)checkMobileString:(NSString *)string;
    //    //验证密码
    //    - (BOOL)checkPassWordString:(NSString *)str;
    //
    //    //验证邮箱
    //    - (BOOL)checkEmailString:(NSString *)EmailString;
    //
    //    //验证邮编
    //    - (BOOL)checkPostcodeString:(NSString *)string;
    

    //商户登录
    if( self.isSupplerSelected ){
#ifdef UIDIRECT
        BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
        [self.navigationController pushViewController:mainview animated:NO];
        return;
#endif
        //商户网点账号
//        只有商户没有网点：loginName=Mer00060019        loginPwd=redis             mercNum=M0060019
//        nameTextField.text = @"Mer00060019";
//        passwordTextField.text = @"redis";
        
//        有商户有一个网点：loginName=Mer00060013        loginPwd=register         mercNum=M0060013
//        nameTextField.text = @"Mer00060013";
//        passwordTextField.text = @"register";
        
//        一个商户多个网点：loginName=Mer00021684        loginPwd=test            mercNum=M0021684
        nameTextField.text = @"Mer00021684";
        passwordTextField.text = @"1";
        [self supplyerLoginRequest];
    }
    //自然人登录
    else
    {

#ifdef UIDIRECT
        BMNaturalManMainViewController* Vc=[[BMNaturalManMainViewController alloc]init];
        [self.navigationController pushViewController:Vc animated:NO];
        return;
#endif
      nameTextField.text = @"17701315969";
      passwordTextField.text = @"123456";
        [self natureManLoginRequest];
    }
}
    
-(void)natureManLoginRequest{
    if(![self checkMobileString:nameTextField.text])
    {
        return;
    }
    if(![self checkPassword:passwordTextField.text])
    {
        return;
    }
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"passwd_3des_encode"];
    [connDictionary setObject:nameTextField.text forKey:@"phoneNum"];
    //[connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"uniqueID"];//设备id
    //[connDictionary setObject:passwordTextField.text forKey:@"password"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    //[connDictionary setObject:string3des forKey:@"passwd_3des"];
    
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,HostURL];
    
    NSLog(@"connDictionary:%@",connDictionary);
    //[self showProgressViewWithMessage:@"登录中..."];
    [self showMBProgressHUDWithMessage:@"登录中..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [self hidMBProgressHUD];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             //商户还是自然人
             [Dict setObject:[NSString stringWithFormat:@"%d",self.isSupplerSelected]   forKey:@"logintype"];
             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             [Dict setObject:[responseJSONDictionary objectForKey:@"phonenum"] forKey:@"phoneNum"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"balanceCardNo"] forKey:@"balanceCardNo"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"naturalMark"] forKey:@"naturalMark"];//是否第一次登录
             //[Dict setObject:[responseJSONDictionary objectForKey:@"payMark"] forKey:@"payMark"];//交易密码
             [Dict setObject:[responseJSONDictionary objectForKey:@"precipitationMarke"] forKey:@"appointment"];//是否设置沉淀
             
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"balanceInfo"] forKey:@"balanceInfo"];
             
             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:USERINFO];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"payMark"] forKey:@"payMark"];//交易密码
             
             [[self getNSUserDefaults] setObject:@"1" forKey:LOGIN_STATUS];//0未登录、1的登录\
             [[NSUserDefaults standardUserDefaults]setObject:nameTextField.text forKey:LAST_LOGIN_NAME];
             
//             //是否商户1 还是自然人0 登录
//             if( self.isSupplerSelected ){
//                 BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
//                 [self.navigationController pushViewController:mainview animated:NO];
//             }
//             //自然人登录
//             else
//             {
//                 
//                 if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"naturalMark"] isEqualToString:@"0"]) {
//                     SettingLoginPassWordViewController * settingVc=[[SettingLoginPassWordViewController alloc]init];
//                     [self.navigationController pushViewController:settingVc animated:NO];
//                 }else{
//                     BMNaturalManMainViewController* Vc=[[BMNaturalManMainViewController alloc]init];
//                     [self.navigationController pushViewController:Vc animated:NO];
//                 }
//             }
             
             //通过通知中心发送通知
             NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
             NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
             [[NSNotificationCenter defaultCenter] postNotification:notification];
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

-(void)supplyerLoginRequest{
    if(![self checkName:nameTextField.text])
    {
        return;
    }
    if(![self checkPassword:passwordTextField.text])
    {
        return;
    }
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];

    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"passwd_3des_encode"];
    [connDictionary setObject:nameTextField.text forKey:@"commercialId"];
    //[connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"uniqueID"];//设备id
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    //[connDictionary setObject:string3des forKey:@"passwd_3des"];
    
    
    NSString *url =[NSString stringWithFormat:@"%@%@",CommercialIP,CommercialHostURL];
    //http://192.168.1.107:8080/superMoney-core/commercia/commerCiainfo?commercialId=Mxxxxx&passwd_3des_encode=xxxxx

    
    NSLog(@"connDictionary:%@",connDictionary);
    //[self showProgressViewWithMessage:@"登录中..."];
    [self showMBProgressHUDWithMessage:@"登录中..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         //[[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         [self hidMBProgressHUD];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             
             //商户还是自然人
             [Dict setObject:[NSString stringWithFormat:@"%d",self.isSupplerSelected]   forKey:@"logintype"];
             [Dict setObject:[responseJSONDictionary objectForKey:SUPPLYER_ID] forKey:SUPPLYER_ID];
             [Dict setObject:[responseJSONDictionary objectForKey:SUPPLYER_LOGIN_ID] forKey:SUPPLYER_LOGIN_ID];

             [Dict setObject:[responseJSONDictionary objectForKey:@"addnpflag"] forKey:@"addNaturalMark"];//是否添加自然人标记,1代表添加，0不添加

             NSMutableArray *results = [responseJSONDictionary objectForKey:@"maturalPersonList"];
             if (results) {
                 [Dict setObject:results forKey:@"natureInfo"];
             }
             
             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:SUPPLYER_INFO];
             
             //test
//             NSMutableDictionary* Dict2=[[NSMutableDictionary alloc]initWithCapacity:0];
//             [Dict2 setObject:@"huayq" forKey:@"name"];
//             [[NSUserDefaults standardUserDefaults]setObject:Dict2 forKey:@"curNatureMenInfo"];
             
             //[[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"addnpflag"] forKey:@"addnpflag"];//添加自然人标记
             //向资产界面传递资产的变动信息
//             NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"one", nil];
//             //创建通知
//             NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
//             //通过通知中心发送通知
//             [[NSNotificationCenter defaultCenter] postNotification:notification];
             
             
//             BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
//             [self.navigationController pushViewController:mainview animated:NO];
             //通过通知中心发送通知
             NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"login", nil];
             NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
             [[NSNotificationCenter defaultCenter] postNotification:notification];

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


#pragma mark -
#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, -120, MainWidth, MainHeight)];
    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self touchesBegan:nil withEvent:nil];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==nameTextField)
    {
        if (string.length > 0)
        {
            
            return textField.text.length < 20;
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
            return textField.text.length < 20;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    }];
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
