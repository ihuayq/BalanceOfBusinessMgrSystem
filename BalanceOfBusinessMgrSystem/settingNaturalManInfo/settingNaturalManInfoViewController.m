//
//  settingNaturalManInfoViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "settingNaturalManInfoViewController.h"
#import "RadioButton.h"
#import "settingNaturalManInfoSuccessViewController.h"
#import "ProtocalViewController.h"

@interface settingNaturalManInfoViewController (){
    HP_UITextField * nameTextField;
    HP_UITextField * dentifierTextField;
    HP_UITextField * telephoneTextField;
    HP_UITextField * passCodeTextField;
    HP_UITextField * passwordTextField;
    
    HP_UIButton *sendCheckCodeButton;
    UILabel *sendLabel;
    
    RadioButton *radioAgreement;
    UIButton *registerButton;
}

@end

@implementation settingNaturalManInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigation.title = @"个人信息";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    [self initUI];
}

-(void) initUI
{
//    //设置 姓名信息
//    HP_UIImageView *bgImageView10 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,8,25,25)];
//    [bgImageView10 setImage:[UIImage imageNamed:@"姓名"]];
//    
//    HP_UIImageView *bgImageView11 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 , NAVIGATION_OUTLET_HEIGHT + 20,MainWidth-40, 40)];
//    [bgImageView11 setImage:[UIImage imageNamed:@"textlayer"]];
//    [self.view addSubview:bgImageView11 ];
//    [bgImageView11 addSubview:bgImageView10];
//    
//    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60, NAVIGATION_OUTLET_HEIGHT + 20, 200, 40)];
//    [nameTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
//    nameTextField.backgroundColor = [UIColor clearColor];
//    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
//    nameTextField.placeholder = @"请输入姓名";
//    nameTextField.font = [UIFont systemFontOfSize:14];
//    nameTextField.delegate = self;
//    nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
//    nameTextField.borderStyle = UITextBorderStyleNone;
//    //nameTextField.secureTextEntry=YES;
//    [self.view addSubview:nameTextField];
//    
//    //设置身份证信息
//    HP_UIImageView *bgImageView20 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,8,25,25)];
//    [bgImageView20 setImage:[UIImage imageNamed:@"身份证"]];
//    
//    HP_UIImageView *bgImageView21 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, nameTextField.frame.size.height + nameTextField.frame.origin.y + 20,MainWidth-40, 40)];
//    [bgImageView21 setImage:[UIImage imageNamed:@"textlayer"]];
//    [self.view addSubview:bgImageView21];
//    [bgImageView21 addSubview:bgImageView20];
//    
//    dentifierTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60, nameTextField.frame.size.height + nameTextField.frame.origin.y + 20, 200, 40)];
//    [dentifierTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
//    dentifierTextField.backgroundColor = [UIColor clearColor];
//    dentifierTextField.clearButtonMode = UITextFieldViewModeAlways;
//    dentifierTextField.placeholder = @"请输入身份证信息";
//    dentifierTextField.font = [UIFont systemFontOfSize:14];
//    dentifierTextField.delegate = self;
//    dentifierTextField.keyboardType = UIKeyboardTypeDefault;
//    dentifierTextField.borderStyle = UITextBorderStyleNone;
//    //dentifierTextField.secureTextEntry=YES;
//    [self.view addSubview:dentifierTextField];
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    NSString *s = @"预约购买之前请先完善个人信息";
    UIFont *font = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size = CGSizeMake(300,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10, labelsize.width, labelsize.height)];
    label.text = s;
    [self.view addSubview:label];
    
    //自然人姓名
    UILabel * manTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, label.frame.origin.y + label.frame.size.height + 15, MainWidth - 40, 20)];
    manTitleLabel.text = [NSString stringWithFormat:@"法人姓名:%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"personName"]];
    manTitleLabel.textAlignment = NSTextAlignmentCenter;
    manTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manTitleLabel.font = [UIFont systemFontOfSize:14];
    manTitleLabel.backgroundColor = [UIColor clearColor];
    manTitleLabel.numberOfLines = 0;
    [self.view addSubview:manTitleLabel];
    
    //身份证号码
    UILabel * identifyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 , manTitleLabel.frame.origin.y + manTitleLabel.frame.size.height  + 15, MainWidth - 40, 20)];
    identifyTitleLabel.text = [NSString stringWithFormat:@"法人身份证号码:%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"identifyno"]];
    identifyTitleLabel.textAlignment = NSTextAlignmentCenter;
    identifyTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    identifyTitleLabel.font = [UIFont systemFontOfSize:14];
    identifyTitleLabel.backgroundColor = [UIColor clearColor];
    identifyTitleLabel.numberOfLines = 0;
    [self.view addSubview:identifyTitleLabel];
    
    //设置手机号码
    HP_UIImageView *bgImageView30 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,8,25,25)];
    [bgImageView30 setImage:[UIImage imageNamed:@"手机号"]];
    
    HP_UIImageView *bgImageView31 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, identifyTitleLabel.frame.size.height + identifyTitleLabel.frame.origin.y + 20,MainWidth-40, 40)];
    [bgImageView31 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView31];
    [bgImageView31 addSubview:bgImageView30];
    
    telephoneTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60, identifyTitleLabel.frame.size.height + identifyTitleLabel.frame.origin.y + 20, 200, 40)];
    [telephoneTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    telephoneTextField.backgroundColor = [UIColor clearColor];
    telephoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    telephoneTextField.placeholder = @"请输入手机号码";
    telephoneTextField.font = [UIFont systemFontOfSize:14];
    telephoneTextField.delegate = self;
    telephoneTextField.keyboardType = UIKeyboardTypeDefault;
    telephoneTextField.borderStyle = UITextBorderStyleNone;
    //telephoneTextField.secureTextEntry=YES;
    [self.view addSubview:telephoneTextField];
    
    //短信验证码
    HP_UIImageView *bgImageView40 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,8,25,25)];
    [bgImageView40 setImage:[UIImage imageNamed:@"短信验证"]];
   
    
    HP_UIImageView *bg3ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, telephoneTextField.frame.size.height + telephoneTextField.frame.origin.y + 20,190, 40)];
    [bg3ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg3ImageView];
    [bg3ImageView addSubview:bgImageView40];
    
    passCodeTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60, telephoneTextField.frame.size.height + telephoneTextField.frame.origin.y + 20, 110, 40)];
    [passCodeTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passCodeTextField.backgroundColor = [UIColor clearColor];
    passCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    passCodeTextField.placeholder = @"请输入验证码";
    passCodeTextField.font = [UIFont systemFontOfSize:14];
    passCodeTextField.delegate = self;
    passCodeTextField.keyboardType = UIKeyboardTypeEmailAddress;
    passCodeTextField.borderStyle = UITextBorderStyleNone;
    //passCodeTextField.secureTextEntry=NO;
    [self.view addSubview:passCodeTextField];
    
    sendCheckCodeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [sendCheckCodeButton setBackgroundColor:[HP_UIColorUtils clearColor]];
    [sendCheckCodeButton setFrame:CGRectMake(215, telephoneTextField.frame.size.height + telephoneTextField.frame.origin.y + 20, 85, 40)];
    [sendCheckCodeButton addTarget:self action:@selector(touchSendCheckCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [sendCheckCodeButton setTitle: @"获取验证码" forState:UIControlStateNormal];
    sendCheckCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sendCheckCodeButton];
    
    sendLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,sendCheckCodeButton.frame.size.height + sendCheckCodeButton.frame.origin.y + 20, 285, 40)];
    sendLabel.textAlignment = NSTextAlignmentCenter;
    sendLabel.backgroundColor = [UIColor clearColor];
    sendLabel.text = @"验证码已发送，有效期30分钟";
    sendLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    sendLabel.font = [UIFont systemFontOfSize:15];
    sendLabel.hidden = YES;
    [self.view  addSubview:sendLabel];
    
//    //商户登录密码
//    HP_UIImageView *bgImageView60 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,6,25,25)];
//    [bgImageView60 setImage:[UIImage imageNamed:@"密码"]];
//    
//    HP_UIImageView *bgImageView61 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, sendCheckCodeButton.frame.size.height + sendCheckCodeButton.frame.origin.y + 20,MainWidth-40, 40)];
//    [bgImageView61 setImage:[UIImage imageNamed:@"textlayer"]];
//    [self.view addSubview:bgImageView61];
//    [bgImageView61 addSubview:bgImageView60];
//    
//    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60, sendCheckCodeButton.frame.size.height + sendCheckCodeButton.frame.origin.y + 20, 200, 40)];
//    [passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
//    passwordTextField.backgroundColor = [UIColor clearColor];
//    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
//    passwordTextField.placeholder = @"请输入商户登录密码";
//    passwordTextField.font = [UIFont systemFontOfSize:14];
//    passwordTextField.delegate = self;
//    passwordTextField.keyboardType = UIKeyboardTypeDefault;
//    passwordTextField.borderStyle = UIKeyboardTypeEmailAddress;
//    passwordTextField.secureTextEntry=YES;
//    [self.view addSubview:passwordTextField];
    
    //自然人姓名
    radioAgreement=[[RadioButton alloc] initWithFrame:CGRectMake(36, passCodeTextField.frame.origin.y+passCodeTextField.frame.size.height+20, 20, 20) typeCheck:NO];
    [radioAgreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[radioAgreement setTitle:@"已阅读并同意自然人投资协议" forState:UIControlStateNormal];
    radioAgreement.titleLabel.font=[UIFont systemFontOfSize:12];
    radioAgreement.delegate=self;
    radioAgreement.tag=708;
    [self.view addSubview:radioAgreement];
    
    
    UILabel*agreeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(radioAgreement.frame.origin.x + radioAgreement.frame.size.width, passCodeTextField.frame.origin.y+passCodeTextField.frame.size.height+20, 120, 20)];
    agreeTitleLabel.text = @"我已阅读并且同意";
    agreeTitleLabel.textAlignment = NSTextAlignmentLeft;
    agreeTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    agreeTitleLabel.font = [UIFont systemFontOfSize:14];
    agreeTitleLabel.backgroundColor = [UIColor clearColor];
    agreeTitleLabel.numberOfLines = 0;
    [self.view addSubview:agreeTitleLabel];
    
    HP_UIButton*investProtolBtn=[[HP_UIButton alloc] initWithFrame:CGRectMake(agreeTitleLabel.frame.origin.x + agreeTitleLabel.frame.size.width-15, passCodeTextField.frame.origin.y+passCodeTextField.frame.size.height+20, 160, 20)];
    [investProtolBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [investProtolBtn addTarget:self action:@selector(touchProtocalButton) forControlEvents:UIControlEventTouchUpInside];
    [investProtolBtn setTitle:@"(资金划转授权协议)" forState:UIControlStateNormal];
    investProtolBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:investProtolBtn];
    
    //确定
    registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, radioAgreement.frame.origin.y+radioAgreement.frame.size.height+ 20, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"提交" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    registerButton.enabled = false;
    [self.view addSubview:registerButton];
    
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

- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect{
    int flags = 0;
    if (tagselect==708) {
        NSLog(@"btn is selected:%d",boolchange);
        if (boolchange == true) {
            registerButton.enabled = true;
        }
        else{
            registerButton.enabled = false;
        }
    }
    
}

-(void)touchProtocalButton{
    ProtocalViewController * fpw = [[ProtocalViewController alloc] init];
    fpw.viewTitle = @"资金划转授权协议";
    fpw.urlPath = [NSString stringWithFormat:@"%@%@",PROTOCOL_IP,ZIJINZHUANSHOUXIEYI_PROTOCOL];
    [self presentModalViewController:fpw animated:YES];
}

-(void)touchCommitButton{
    //test
//    settingNaturalManInfoSuccessViewController *info = [[settingNaturalManInfoSuccessViewController alloc] init];
//    [self.navigationController pushViewController:info
//                                         animated:NO];
//    return;
//    if (![self checkName:nameTextField.text]) {
//        return;
//    }
//    
//    if (![self checkshenfenzhengString:dentifierTextField.text]) {
//        return;
//    }
    
    if (![self checkTel:telephoneTextField.text])
    {
        return;
    }
    
//    if (![self checkPassCode:passCodeTextField.text]) {
//        return;
//    }
    
//    if (![self checkPassWordString:passwordTextField.text])
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
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID] forKey:USER_ID];
    [connDictionary setObject:telephoneTextField.text forKey:@"phoneNum"];
    [connDictionary setObject:passCodeTextField.text forKey:@"code"];
    //[connDictionary setObject:@"000000" forKey:@"code"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,settingNatureMenURL];
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    [self showProgressViewWithMessage:@"正在设置个人信息..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
            responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
//             //返回全部的自然人列表
//             NSMutableArray *results = [responseJSONDictionary objectForKey:@"maturalPersonList"];
//             if (results) {
//                 NSMutableDictionary*data = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO]];
//                 [data setObject:results forKey:@"natureInfo"];
//                 [[NSUserDefaults standardUserDefaults]setObject:data forKey:SUPPLYER_INFO];
//                 NSLog(@"the SUPPLYER_INFO is:%@",data);
//                 
//                 //向NaturalManInfoMgrViewController
//                 NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"type",nil];
//                 //创建通知
//                 NSNotification *notification =[NSNotification notificationWithName:@"NatureManListChange" object:nil userInfo:dict];
//                 //通过通知中心发送通知
//                 [[NSNotificationCenter defaultCenter] postNotification:notification];
//             }
//
//             //当前自然人信息, 程序中对要修改或者设定的自然人信息进行保存，注意curNatureMenInfo字段，在下一级界面会有更详细的设定
//             //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
//             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
//             [Dict setObject:[responseJSONDictionary objectForKey:@"personId"] forKey:@"no"];
//             [Dict setObject:[responseJSONDictionary objectForKey:@"personName"] forKey:@"name"];
//             [Dict setObject:[responseJSONDictionary objectForKey:@"phoneNum"] forKey:@"phonenum"];
//             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:@"curNatureMenInfo"];
             //设置自然人信息
             
//         responseJSONDictionary:{
//             flag = 100;
//             idCard = "130203****200322";
//             msg = "\U5b8c\U5584\U4e2a\U4eba\U4fe1\U606f\U6210\U529f\Uff01";
//             personId = 177;
//             personName = "*\U946b";
//             phoneNum = 15900000000;
//         },
             
         NSMutableDictionary*data = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO]];
         [data setObject:@"1" forKey:@"addNaturalMark"];
         [[NSUserDefaults standardUserDefaults]setObject:data forKey:USERINFO];
         [[NSUserDefaults standardUserDefaults]setObject:[responseJSONDictionary objectForKey:@"phoneNum"] forKey:@"phoneNum"];
         NSLog(@"the SUPPLYER_INFO is:%@",data);
         
             if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"addwebsiteFlag"] isEqualToString:@"0"] ){
                 settingNaturalManInfoSuccessViewController *info = [[settingNaturalManInfoSuccessViewController alloc] init];
                 [self.navigationController pushViewController:info
                                                      animated:NO];
             }
             else{
                 [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag+10  alertMessage:@"个人信息设置成功!" cancelButtonTitle:queding otherButtonTitles:nil];
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
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg) {
         
         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
    

}

// 在这里处理UIAlertView中的按钮被单击的事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex is : %i",(int)buttonIndex);
    if(alertView.tag == LoginOutViewTag){
        switch (buttonIndex) {
            case 0:{
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"4",@"login", nil];
                NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }break;
            default:
                break;
        }
    }
    else if(alertView.tag == (LoginOutViewTag+10)){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)touchSendCheckCodeButton{
    if (![self checkTel:telephoneTextField.text])
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
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID] forKey:USER_ID];
    [connDictionary setObject:telephoneTextField.text forKey:@"phoneNum"];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    //NSLog(@"connDictionary:%@",connDictionary);
    
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
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (passwordTextField == textField) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.view setFrame:CGRectMake(0, -120, MainWidth, MainHeight)];
        }];
    }
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
    if (textField==passCodeTextField)
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
    [telephoneTextField resignFirstResponder];
    [dentifierTextField resignFirstResponder];
    [nameTextField resignFirstResponder];
    [passCodeTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
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
    
    NSString *regex = PhoneNoRegex;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alert show];
        return NO;
        
    }
    return YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
