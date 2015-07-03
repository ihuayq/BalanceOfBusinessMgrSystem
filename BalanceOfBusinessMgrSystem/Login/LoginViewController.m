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
#import "ProtocalViewController.h"



@interface LoginViewController ()<RadioButtonDelegate,RFSegmentViewDelegate>{
   
    UIButton *loginButton;
    
    RadioButton *radioAgreement;
    HP_UIButton*icardRegisterProtolBtn;
    HP_UIButton*chaoebaoServiceProtolBtn;
    UILabel*agreeTitleLabel;
}

@property(nonatomic,retain)RadioButton *radioSupplyer;
@property(nonatomic,retain)RadioButton *radioMember;
@property(nonatomic,retain)RadioButton * forgetButton;


@end

@implementation LoginViewController

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
    
    //nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_SUPPLYER_NAME]];
    //[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:LAST_LOGIN_NAME];
    
    [passwordTextField setText:@""];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"你好，勇气";
    [self initUI];
    
}

-(UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void) initUI
{

    HP_UIImageView *logoImageView = [[HP_UIImageView alloc] init ];
    [logoImageView setFrame:CGRectMake(0, 0, MainWidth, MainHeight/3 + 30)];
    //[logoImageView setImage:[UIImage imageNamed:@"redbtn"]];
    [logoImageView setImage:[UIImage imageNamed:@"loginpage"]];
    UIImage * ii = [self imageWithColor:UISTYLECOLOR andSize:(CGSize)CGSizeMake(MainWidth,MainHeight/3)];
    [logoImageView setImage:ii];
    [self.view addSubview:logoImageView];
    
    
    UIImage *image = [UIImage imageNamed:@"loginpage-sub1"];
    HP_UIImageView *logoPageImageView = [[HP_UIImageView alloc] init ];
    [logoPageImageView setFrame:CGRectMake(MainWidth/2 - image.size.width/2, logoImageView.frame.size.height/2 - image.size.height/2 , image.size.width, image.size.height)];
    [logoPageImageView setImage:[UIImage imageNamed:@"loginpage-sub1"]];
    [logoImageView addSubview:logoPageImageView];
    NSMutableArray *chooseArray = [NSMutableArray arrayWithObjects:@"商户",@"自然人",nil];

//    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, logoImageView.frame.origin.y+logoImageView.frame.size.height , ScreenWidth, 60) items:@[@"商户",@"自然人"] selectIndex:!_isSupplerSelected];
//    segmentView.tintColor = [self getRandomColor];
//    segmentView.delegate = self;
//    [self.view addSubview:segmentView];
    
    //设置 姓名信息
    HP_UIImageView *bgImageView10 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView10 setImage:[UIImage imageNamed:@"姓名"]];

    HP_UIImageView *bgImageView11 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20,logoImageView.frame.size.height + logoImageView.frame.origin.y + 20,MainWidth-40, 40)];
    [bgImageView11 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView11 ];
    [bgImageView11 addSubview:bgImageView10];

    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60, logoImageView.frame.size.height + logoImageView.frame.origin.y + 20, 240, 40)];
    [nameTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.placeholder = @"请输入用户账号";
    nameTextField.font = [UIFont systemFontOfSize:14];
    nameTextField.delegate = self;
    nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    nameTextField.borderStyle = UITextBorderStyleNone;
    nameTextField.text = self.loginName;
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
    
    //协议按钮
    radioAgreement=[[RadioButton alloc] initWithFrame:CGRectMake(20, passwordTextField.frame.origin.y+passwordTextField.frame.size.height+6, 20, 20) typeCheck:NO];
    radioAgreement.delegate=self;
    radioAgreement.tag = 708;
    [self.view addSubview:radioAgreement];
    
    agreeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(radioAgreement.frame.origin.x + radioAgreement.frame.size.width + 4, passwordTextField.frame.origin.y+passwordTextField.frame.size.height+6, 180, 20)];
    agreeTitleLabel.text = @"我已阅读并且同意以下协议";
    agreeTitleLabel.textAlignment = NSTextAlignmentLeft;
    agreeTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    agreeTitleLabel.font = [UIFont systemFontOfSize:14];
    agreeTitleLabel.backgroundColor = [UIColor clearColor];
    agreeTitleLabel.numberOfLines = 0;
    [self.view addSubview:agreeTitleLabel];
    
    //支付通用户注册协议
    icardRegisterProtolBtn=[[HP_UIButton alloc] initWithFrame:CGRectMake(30,radioAgreement.frame.size.height + radioAgreement.frame.origin.y + 10,180,14)];
    [icardRegisterProtolBtn setTitleColor:UIColorFromRGB(0x00baff) forState:UIControlStateNormal];
    [icardRegisterProtolBtn addTarget:self action:@selector(touchICardRegisterProtocalButton) forControlEvents:UIControlEventTouchUpInside];
    [icardRegisterProtolBtn setTitle:@"《支付通用户注册协议》" forState:UIControlStateNormal];
    icardRegisterProtolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    icardRegisterProtolBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:icardRegisterProtolBtn];
    
    //超额宝服务协议
    chaoebaoServiceProtolBtn=[[HP_UIButton alloc] initWithFrame:CGRectMake(30,icardRegisterProtolBtn.frame.size.height + icardRegisterProtolBtn.frame.origin.y + 6,140,14)];
    [chaoebaoServiceProtolBtn setTitleColor:UIColorFromRGB(0x00baff) forState:UIControlStateNormal];
    [chaoebaoServiceProtolBtn addTarget:self action:@selector(touchChaoebaoServiceProtocalButton) forControlEvents:UIControlEventTouchUpInside];
    [chaoebaoServiceProtolBtn setTitle:@"《超额宝服务协议》" forState:UIControlStateNormal];
    chaoebaoServiceProtolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    chaoebaoServiceProtolBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:chaoebaoServiceProtolBtn];
    
    _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetButton.frame = CGRectMake(MainWidth - 85 - 40, MainHeight-125, 85, 15);
    [_forgetButton setBackgroundImage:[UIImage imageNamed:@"forgetpassword"] forState:UIControlStateNormal];
    _forgetButton.backgroundColor = [UIColor clearColor];
    [_forgetButton addTarget:self action:@selector(touchForgetButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetButton];
    _forgetButton.hidden = YES;
    
//    f84206 橘红色按钮点击后及其他非按钮的橘红色色值
//    f9551c 点击前色值
    loginButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    //[loginButton setBackgroundColor:[UIColor clearColor]];
    [loginButton setFrame:CGRectMake(20, MainHeight-100, MainWidth-40, 40)];
    [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:loginButton.frame.size.height/2.0f];
    loginButton.enabled = NO;
    [self.view addSubview:loginButton];
    
    _isSupplerSelected = FALSE;
    if (_isSupplerSelected) {
        //刷新商户填充信息
        nameTextField.placeholder = @"请输入Qpos/POS平台账号";
        passwordTextField.placeholder = @"请输入Qpos/POS平台密码";
        //self.forgetButton.hidden = YES;
        nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_SUPPLYER_NAME]];
    }
    else{
        nameTextField.placeholder = @"请输入手机号码";
        passwordTextField.placeholder = @"请输入密码";
        //self.forgetButton.hidden = NO;
        nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME]];
    }
    
    [self natureManProtocalBtnHidden:_isSupplerSelected];
}

-(void)touchChaoebaoServiceProtocalButton{

    ProtocalViewController * fpw = [[ProtocalViewController alloc] init];
    fpw.viewTitle = @"超额宝服务协议";
     fpw.urlPath = [NSString stringWithFormat:@"%@%@",PROTOCOL_IP,CHAOEBAOFUWUXIEYI_PROTOCOL];
    [self presentViewController:fpw animated:YES completion:nil];
}

-(void)touchICardRegisterProtocalButton{
    ProtocalViewController * fpw = [[ProtocalViewController alloc] init];
    fpw.viewTitle = @"支付通用户注册协议";
    fpw.urlPath = [NSString stringWithFormat:@"%@%@",PROTOCOL_IP,ZHIFUTONGYONGHUZHUCE_PROTOCOL];
    [self presentViewController:fpw animated:YES completion:nil];
}

- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect{
    if (tagselect == 708) {
        NSLog(@"btn is selected:%d",boolchange);
        if (boolchange == true) {
            loginButton.enabled = true;
        }
        else{
            loginButton.enabled = false;
        }
    }
}

//- (UIColor *)getRandomColor
//{
//    //UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    UIColor *color = [self getColor:@"f9551c"];
//    return color;
//}

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
    
//    if (index == 0) {
//        _isSupplerSelected = TRUE;
//    }
//    else{
//        _isSupplerSelected = FALSE;
//    }
//    
//    if (_isSupplerSelected) {
//        //刷新商户填充信息
//        nameTextField.placeholder = @"请输入Qpos/POS平台账号";
//        nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
//        passwordTextField.placeholder = @"请输入Qpos/POS平台密码";
//        //self.forgetButton.hidden = YES;
//        nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_SUPPLYER_NAME]];
//    }
//    else{
//        nameTextField.placeholder = @"请输入手机号码";
//        passwordTextField.placeholder = @"请输入密码";
//        nameTextField.keyboardType = UIKeyboardTypePhonePad;
//        nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME]];
//        //self.forgetButton.hidden = NO;
//    }
//    [self natureManProtocalBtnHidden:_isSupplerSelected];

}

-(void)setIsSupplerSelected:(BOOL)isSupplerSelected{
//    _isSupplerSelected = isSupplerSelected;
//    if (_isSupplerSelected) {
//        //刷新商户填充信息
//        nameTextField.placeholder = @"请输入Qpos/POS平台账号";
//        passwordTextField.placeholder = @"请输入Qpos/POS平台密码";
//        //self.forgetButton.hidden = YES;
//        
//        nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_SUPPLYER_NAME]];
//    }
//    else{
//        nameTextField.placeholder = @"请输入手机号码";
//        passwordTextField.placeholder = @"请输入密码";
//        // self.forgetButton.hidden = NO;
//        nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME]];
//    }
//    [self natureManProtocalBtnHidden:_isSupplerSelected];
}

-(void)natureManProtocalBtnHidden:(BOOL)isHidden{
    self.forgetButton.hidden = isHidden;
    radioAgreement.hidden = isHidden;
    
    icardRegisterProtolBtn.hidden = isHidden;
    chaoebaoServiceProtolBtn.hidden = isHidden;
    agreeTitleLabel.hidden = isHidden;
    if (isHidden == YES) {
        loginButton.enabled = YES;
    }
    else{
        radioAgreement.isChecked = NO;
        loginButton.enabled = NO;
    }
    
    if (!_isSupplerSelected) {
        [self.forgetButton setFrame:CGRectMake(MainWidth - 85 - 40,chaoebaoServiceProtolBtn.frame.size.height + chaoebaoServiceProtolBtn.frame.origin.y,85, 15)];
        [loginButton setFrame:CGRectMake(20,self.forgetButton.frame.size.height + self.forgetButton.frame.origin.y + 10,MainWidth-40, 40)];
    }
    else{
        [loginButton setFrame:CGRectMake(20,passwordTextField.frame.size.height + passwordTextField.frame.origin.y + 20,MainWidth-40, 40)];
    }
    
}

- (void)updataEnterInfo
{
    
}

-(void)setLoginName:(NSString *)loginName{
    nameTextField.text = loginName;
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
    
//    RegisterViewController* registervc=[[RegisterViewController alloc]init];
//    [self.navigationController pushViewController:registervc animated:YES];
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
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入账号" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
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
    //商户登录
    if( self.isSupplerSelected ){
#ifdef UIDIRECT
        BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
        [self.navigationController pushViewController:mainview animated:NO];
        return;
#endif


#ifdef TEST_LOGIN
        //商户网点账号
//        只有商户没有网点：loginName=Mer00060019        loginPwd=redis             mercNum=M0060019
//        nameTextField.text = @"Mer00060090";
//        passwordTextField.text = @"1";
        
//        有商户有一个网点：loginName=Mer00060013        loginPwd=register         mercNum=M0060013
//        nameTextField.text = @"Mer00060013";
//        passwordTextField.text = @"1";
        
//        一个商户多个网点：loginName=Mer00021684        loginPwd=test            mercNum=M0021684
//        nameTextField.text = @"Mer00021684";
//        passwordTextField.text = @"1";
        
        nameTextField.text = @"Mer00060318";
        passwordTextField.text = @"1";
#endif
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
#ifdef TEST_LOGIN
      nameTextField.text = @"17701315969";
      passwordTextField.text = @"123456";

//       nameTextField.text = @"13501102460";
//       passwordTextField.text = @"123456";
#endif
        [self natureManLoginRequest];
    }
}
    
-(void)natureManLoginRequest{
//    if(![self checkMobileString:nameTextField.text])
//    {
//        return;
//    }
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
    [connDictionary setObject:nameTextField.text forKey:@"loginId"];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,HostURL];
    
    //NSLog(@"connDictionary:%@",connDictionary);
    [self showMBProgressHUDWithMessage:@"登录中..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [self hidMBProgressHUD];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:LOGIN_STATUS];//0未登录、1的登录
             
             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             //商户还是自然人
             [Dict setObject:[NSString stringWithFormat:@"%d",self.isSupplerSelected]   forKey:@"logintype"];
             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
            

             [Dict setObject:[responseJSONDictionary objectForKey:@"precipitationMarke"] forKey:@"appointment"];//是否设置沉淀
             
//             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"balanceInfo"] forKey:@"balanceInfo"];
//             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"netAccountInfo"] forKey:@"netAccountInfo"];
             
             [[NSUserDefaults standardUserDefaults] setObject:Dict forKey:USERINFO];
//             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"payMark"] forKey:@"payMark"];//交易密码
             
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.isSupplerSelected] forKey:LOGIN_TYPE];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"rate"] forKey:@"rate"];
             
             //查看是否与本地缓存的登录名一致，不一致则重置所有登陆设置
             if ([[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME] isEqualToString:nameTextField.text] == NO) {
                 [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"IsLoginGesturePwdSet"];
                 [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"IsUsingGesturePwdLogin"];
             }
             [[NSUserDefaults standardUserDefaults] setObject:nameTextField.text forKey:LAST_LOGIN_NAME];
             
             NSString *isLoginGestureSet = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsLoginGesturePwdSet"] ;
             //手势密码是否设置 0，无；1，设置过
             if ([isLoginGestureSet intValue] == 0 || isLoginGestureSet == nil) {
                 NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"3",@"login", nil];
                 NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
                 [[NSNotificationCenter defaultCenter] postNotification:notification];
             }
             else
             {
                 //设置过手势密码，下次默认用手势密码登陆
                 [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"IsUsingGesturePwdLogin"];
                 //通过通知中心发送通知
                 NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
                 NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
                 [[NSNotificationCenter defaultCenter] postNotification:notification];
             }
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
         //[[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
          [self hidMBProgressHUD];
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

    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    //[connDictionary setObject:string3des forKey:@"passwd_3des"];
    
    
    NSString *url =[NSString stringWithFormat:@"%@%@",CommercialIP,CommercialHostURL];

    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
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

             [Dict setObject:[responseJSONDictionary objectForKey:@"addnpflag"] forKey:@"addNaturalMark"];//是否添加自然人标记,1代表添加，0不添加 methods = TRUE;

             NSMutableArray *results = [responseJSONDictionary objectForKey:@"maturalPersonList"];
             if (results) {
                 [Dict setObject:results forKey:@"natureInfo"];
             }
             
             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:SUPPLYER_INFO];
             
             //商户类型
             [[NSUserDefaults standardUserDefaults]setObject:[responseJSONDictionary objectForKey:@"methods"] forKey:@"methods"];

             
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
             [[self getNSUserDefaults] setObject:@"1" forKey:LOGIN_STATUS];//0未登录、1的登录
             [[NSUserDefaults standardUserDefaults] setObject:nameTextField.text forKey:LAST_LOGIN_SUPPLYER_NAME];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.isSupplerSelected] forKey:LOGIN_TYPE];
             
//             BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
//             [self.navigationController pushViewController:mainview animated:NO];
             //通过通知中心发送通知
             NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"login", nil];
             NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
             [[NSNotificationCenter defaultCenter] postNotification:notification];

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
         [self hidMBProgressHUD];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];

}


#pragma mark -
#pragma mark - UITextFieldDelegate
//业务规则
//1、	手机号码
//l	手机号码为11位纯数字，正则表达式验证输入登录手机号后输入框失去焦点后立即校验手机号码合法性；
//2、登录密码
//l	6≤密码长度≤16，数字和英文字母（区分大小写），必须有至少一位英文字母；
//l	密码输入错误时，提示“提示密码错误后清空密码输入框，保留已输入手机号；密码累计错误次数达到一定值时（可配置），账号锁定一段时间（可配置）；
//l	密码校验时间：用户手机3分钟无操作，完全退出程序，再次进入程序时，
//l	已经设置手势密码登录的商户下次登录时，默认为手势密码登录，在页面给出传统登录方式的切换方式(二期)；
//3、	交易密码
//l	6≤密码长度≤16；禁止使用连续性比较强的字母和数字，不能与登录密码相同；至少有一位英文字母；

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
            if ([string isEqualToString:@" "])
            {
                return NO;
            }
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
