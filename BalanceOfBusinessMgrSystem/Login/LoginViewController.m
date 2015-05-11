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

@interface LoginViewController ()<RadioButtonDelegate>{
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
    nameTextField.text=[self delStringNull:[[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME]];
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
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    [bgView setBackgroundColor:[HP_UIColorUtils colorWithHexString:BG_COLOR]];
    [self.view addSubview:bgView];
    
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    [bgImageView setImage:[UIImage imageNamed:@"dgbg"]];
    //[bgView addSubview:bgImageView];
    
    HP_UIImageView *logoImageView = [[HP_UIImageView alloc] init ];
    if (MainHeight>500)
    {
        [logoImageView setFrame:CGRectMake((MainWidth-170)/2-30, 60,220, 155)];
    }
    else
    {
        [logoImageView setFrame:CGRectMake((MainWidth-170)/2-30, 30,220, 155)];

    }
    [logoImageView setImage:[UIImage imageNamed:@"loginlogo"]];
    [bgView addSubview:logoImageView];
    
    
    self.radioSupplyer=[[RadioButton alloc] initWithFrame:CGRectMake(36, logoImageView.frame.origin.y+logoImageView.frame.size.height+20, 100, 25) typeCheck:YES];
    [self.radioSupplyer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.radioSupplyer setTitle:@"商户" forState:UIControlStateNormal];
    self.radioSupplyer.titleLabel.font=[UIFont systemFontOfSize:12];
    self.radioSupplyer.delegate=self;
    self.radioSupplyer.tag=707;
    [self.view addSubview:self.radioSupplyer];
    
    self.radioMember=[[RadioButton alloc] initWithFrame:CGRectMake(36+MainWidth/2, logoImageView.frame.origin.y+logoImageView.frame.size.height+20, 100, 25) typeCheck:NO];
    [self.radioMember setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.radioMember setTitle:@"授权人" forState:UIControlStateNormal];
    self.radioMember.titleLabel.font=[UIFont systemFontOfSize:12];
    self.radioMember.delegate=self;
    self.radioMember.tag=708;
    [self.view addSubview:self.radioMember];
    
    
    HP_UIImageView *headImage = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 + 50, MainHeight-280,MainWidth-120, 40)];
    [headImage setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:headImage];
    
    HP_UIImageView *nameImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(30, MainHeight-280, 40, 40)];
    [nameImageView setImage:[UIImage imageNamed:@"大头照"]];
    [bgView addSubview:nameImageView];
    
//    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, MainHeight-260, 50, 40)];
//    nameLabel.text = @"用户名:";
//    nameLabel.textAlignment = NSTextAlignmentLeft;
//    nameLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    nameLabel.font = [UIFont systemFontOfSize:14];
//    nameLabel.backgroundColor = [UIColor clearColor];
//    [bgView addSubview:nameLabel];

    
    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(90, MainHeight-280, 210, 40)];
    nameTextField.borderStyle = UITextBorderStyleNone;
    [nameTextField setInsets:UIEdgeInsetsMake(25, 5, 0, 0)];
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.placeholder = @"请输入用户账号";
    nameTextField.font = [UIFont systemFontOfSize:14];
    nameTextField.delegate = self;
    nameTextField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:nameTextField];

    HP_UIImageView *passwordImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 + 50, MainHeight-220,MainWidth-120, 40)];
    [passwordImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [bgView addSubview:passwordImageView];
    
//    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, MainHeight-210, 70, 40)];
//    passwordLabel.text = @"密码:";
//    passwordLabel.textAlignment = NSTextAlignmentLeft;
//    passwordLabel.textColor =[HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    passwordLabel.font = [UIFont systemFontOfSize:14];
//    passwordLabel.backgroundColor = [UIColor clearColor];
//    [bgView addSubview:passwordLabel];
    HP_UIImageView *passImage = [[HP_UIImageView alloc] initWithFrame:CGRectMake(30, MainHeight-220, 40, 40)];
    [passImage setImage:[UIImage imageNamed:@"密码照"]];
    [bgView addSubview:passImage];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(90, MainHeight-220, 210, 40)];
    passwordTextField.borderStyle = UITextBorderStyleNone;
    //[passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.secureTextEntry=YES;
    [bgView addSubview:passwordTextField];
    
//    UIButton * keepPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    keepPsdBtn.frame = CGRectMake(MainWidth - 85 - 20, MainHeight-165, 85, 15);
//    [keepPsdBtn setBackgroundImage:[UIImage imageNamed:@"forgetpassword"] forState:UIControlStateNormal];
//    keepPsdBtn.backgroundColor = [UIColor clearColor];
//    [keepPsdBtn addTarget:self action:@selector(touchForgetButton) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:keepPsdBtn];
    
    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkbox setFrame:CGRectMake(40, MainHeight-165, 15, 15)];
    [checkbox setImage:[UIImage imageNamed:@"n.png"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"y.png"] forState:UIControlStateSelected];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:checkbox];
    
    UILabel * rememberPassword = [[UILabel alloc] initWithFrame:CGRectMake(60, MainHeight-178, 75, 40)];
    rememberPassword.text = @"记住密码";
    rememberPassword.textAlignment = NSTextAlignmentLeft;
    rememberPassword.textColor =[HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    rememberPassword.font = [UIFont systemFontOfSize:14];
    rememberPassword.backgroundColor = [UIColor clearColor];
    [bgView addSubview:rememberPassword];
    
    
    _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetButton.frame = CGRectMake(MainWidth - 85 - 40, MainHeight-165, 85, 15);
    [_forgetButton setBackgroundImage:[UIImage imageNamed:@"forgetpassword"] forState:UIControlStateNormal];
    _forgetButton.backgroundColor = [UIColor clearColor];
    [_forgetButton addTarget:self action:@selector(touchForgetButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_forgetButton];
    _forgetButton.hidden = YES;
    
    
    UIButton *loginButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [loginButton setBackgroundColor:[UIColor clearColor]];
    [loginButton setFrame:CGRectMake(60, MainHeight-140, MainWidth-120, 40)];
    [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loginButton];
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-120, 40)];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.text = @"登 录";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.font = [UIFont systemFontOfSize:15];
    [loginButton addSubview:loginLabel];
    
//    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    [registerButton setBackgroundImage:[UIImage imageNamed:@"garybn"] forState:UIControlStateNormal];
//    [registerButton setBackgroundImage:[UIImage imageNamed:@"garybndj"] forState:UIControlStateHighlighted];
//    [registerButton setBackgroundColor:[UIColor clearColor]];
//    [registerButton setFrame:CGRectMake(20, MainHeight-90, MainWidth-40, 40)];
//    [registerButton addTarget:self action:@selector(touchRegisterButton) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:registerButton];
//    
//    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-40, 40)];
//    registerLabel.textAlignment = NSTextAlignmentCenter;
//    registerLabel.backgroundColor = [UIColor clearColor];
//    registerLabel.text = @"免费注册";
//    registerLabel.textColor = [HP_UIColorUtils colorWithHexString:TOPBAR_COLOR];
//    registerLabel.font = [UIFont systemFontOfSize:15];
//    [registerButton addSubview:registerLabel];
    
    
    
//    HP_UIImageView *textlogoImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake((MainWidth-115)/2, MainHeight-20,115, 20)];
//    [textlogoImageView setImage:[UIImage imageNamed:@"zhongxinlogo"]];
//    [bgView addSubview:textlogoImageView];
    
}


-(void)checkboxClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        //
    }
}


- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect{
    int flags = 0;
    if (tagselect==708) {
        if (!boolchange) {
            self.radioSupplyer.isChecked=YES;
            [self.radioSupplyer setImage:[UIImage imageNamed:@"RadioButton_check.png"] forState:UIControlStateNormal];
            flags = 707;
            self.isSupplerSelected = true;
            
        }else {
            self.radioSupplyer.isChecked=NO;
            [self.radioSupplyer setImage:[UIImage imageNamed:@"RadioButton_Not_check.png"] forState:UIControlStateNormal];
            flags = 708;
            self.isSupplerSelected = false;
        }
        
    }else if (tagselect==707) {
        if (!boolchange) {
            self.radioMember.isChecked=YES;
            [self.radioMember setImage:[UIImage imageNamed:@"RadioButton_check.png"] forState:UIControlStateNormal];
            flags = 708;
            self.isSupplerSelected = false;
            
        }else {
            self.radioMember.isChecked=NO;
            [self.radioMember setImage:[UIImage imageNamed:@"RadioButton_Not_check.png"] forState:UIControlStateNormal];
            flags = 707;
            self.isSupplerSelected = true;
        }
    }
    
//    isSupplerSelected = true;
//    
//    //保存当前选定的商户
//    [self updataEnterInfo];
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
        nameTextField.placeholder = @"请输入用户账号";
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
    [self touchesBegan:nil withEvent:nil];
    
    ForgetPasswordViewController * fpw = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:fpw animated:YES];
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
    
    return YES;
    
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


-(void)touchLoginButton
{
    //商户登陆
    if( self.isSupplerSelected ){
        BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
        //mainview.transferDict=responseJSONDictionary;
        //[mainview showAlertView];
        [self.navigationController pushViewController:mainview animated:NO];
    }
    //自然人登陆
    else
    {
        SettingLoginPassWordViewController * settingVc=[[SettingLoginPassWordViewController alloc]init];
        [self.navigationController pushViewController:settingVc animated:NO];

    }
    
    return;
    
//    if(![self checkName:nameTextField.text])
//    {
//        return;
//    }
//    if(![self checkPassword:passwordTextField.text])
//    {
//        return;
//    }
    
    //http://192.168.1.107:8080/superMoney-core/nature/loginIn?signature=B77FE63F2B12D2965717E04E0A4C3A0A&phoneNum=15294700571&password=123
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:@"B77FE63F2B12D2965717E04E0A4C3A0A" forKey:@"signature"];
    
    //[connDictionary setObject:nameTextField.text forKey:@"phoneNum"];
    [connDictionary setObject:@"15294700571" forKey:@"phoneNum"];
    
//    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
//    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    //[connDictionary setObject:encodedValue forKey:@"password"];
    //[connDictionary setObject:passwordTextField.text forKey:@"password"];
    [connDictionary setObject:@"123" forKey:@"password"];
    
   
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
 
    //[connDictionary setObject:string3des forKey:@"passwd"];
    
    //NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,userloginURL];
    NSString *url =[NSString stringWithFormat:@"http://192.168.1.107:8080/superMoney-core/nature/loginIn?"];
    
    NSLog(@"connDictionary:%@",connDictionary);
    //[self showProgressViewWithMessage:@"登录中..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
    {
        NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
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
            [[NSUserDefaults standardUserDefaults]setObject:nameTextField.text forKey:LAST_LOGIN_NAME];
            
            
//            MainViewController * mainview=[[MainViewController alloc]init];
//            mainview.transferDict=responseJSONDictionary;
//            [mainview showAlertView];
//            [self.navigationController pushViewController:mainview animated:NO];
            
//            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Congratulations" contentText:@"You have bought something" leftButtonTitle:@"Ok" rightButtonTitle:@"Fine"];
//            [alert show];
//            alert.leftBlock = ^() {
//                NSLog(@"left button clicked");
//            };
//            alert.rightBlock = ^() {
//                NSLog(@"right button clicked");
//            };
//            alert.dismissBlock = ^() {
//                NSLog(@"Do something interesting after dismiss block");
//            };
            SettingLoginPassWordViewController * mainview=[[SettingLoginPassWordViewController alloc]init];
            [self.navigationController pushViewController:mainview animated:NO];
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
