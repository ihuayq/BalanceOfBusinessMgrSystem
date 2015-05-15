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

@interface settingNaturalManInfoViewController (){
    HP_UITextField * nameTextField;
    HP_UITextField * dentifierTextField;
    HP_UITextField * telephoneTextField;
    HP_UITextField * passCodeTextField;
    HP_UIButton *sendCheckCodeButton;
    UILabel *sendLabel;
    RadioButton *radioAgreement;
}

@end

@implementation settingNaturalManInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigation.title = @"设置自然人";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    [self initUI];
}

-(void) initUI
{
    //设置 姓名信息
    HP_UIImageView *bgImageView10 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 20,40, 40)];
    [bgImageView10 setImage:[UIImage imageNamed:@"headicon"]];
    [self.view addSubview:bgImageView10];
    
    HP_UIImageView *bgImageView11 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 + 40, NAVIGATION_OUTLET_HEIGHT + 20,MainWidth-40 -40, 40)];
    [bgImageView11 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView11];
    
    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, NAVIGATION_OUTLET_HEIGHT + 20, 200, 40)];
    [nameTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.placeholder = @"请输入姓名";
    nameTextField.font = [UIFont systemFontOfSize:14];
    nameTextField.delegate = self;
    nameTextField.keyboardType = UIKeyboardTypeDefault;
    nameTextField.borderStyle = UITextBorderStyleNone;
    nameTextField.secureTextEntry=YES;
    [self.view addSubview:nameTextField];
    
    //设置身份证信息
    HP_UIImageView *bgImageView20 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, nameTextField.frame.size.height + nameTextField.frame.origin.y + 40,40, 40)];
    [bgImageView20 setImage:[UIImage imageNamed:@"shengfengzheng"]];
    [self.view addSubview:bgImageView20];
    
    HP_UIImageView *bgImageView21 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 + 40, nameTextField.frame.size.height + nameTextField.frame.origin.y + 40,MainWidth-40 - 40, 40)];
    [bgImageView21 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView21];
    
    dentifierTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, nameTextField.frame.size.height + nameTextField.frame.origin.y + 40, 200, 40)];
    [dentifierTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    dentifierTextField.backgroundColor = [UIColor clearColor];
    dentifierTextField.clearButtonMode = UITextFieldViewModeAlways;
    dentifierTextField.placeholder = @"请输入身份证信息";
    dentifierTextField.font = [UIFont systemFontOfSize:14];
    dentifierTextField.delegate = self;
    dentifierTextField.keyboardType = UIKeyboardTypeDefault;
    dentifierTextField.borderStyle = UITextBorderStyleNone;
    dentifierTextField.secureTextEntry=YES;
    [self.view addSubview:dentifierTextField];
    
    //设置手机号码
    HP_UIImageView *bgImageView30 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 , dentifierTextField.frame.size.height + dentifierTextField.frame.origin.y + 40,40, 40)];
    [bgImageView30 setImage:[UIImage imageNamed:@"telephone"]];
    [self.view addSubview:bgImageView30];
    
    HP_UIImageView *bgImageView31 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 + 40, dentifierTextField.frame.size.height + dentifierTextField.frame.origin.y + 40,MainWidth-40*2, 40)];
    [bgImageView31 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView31];
    
    telephoneTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, dentifierTextField.frame.size.height + dentifierTextField.frame.origin.y + 40, 200, 40)];
    [telephoneTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    telephoneTextField.backgroundColor = [UIColor clearColor];
    telephoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    telephoneTextField.placeholder = @"请输入手机号码";
    telephoneTextField.font = [UIFont systemFontOfSize:14];
    telephoneTextField.delegate = self;
    telephoneTextField.keyboardType = UIKeyboardTypeDefault;
    telephoneTextField.borderStyle = UITextBorderStyleNone;
    telephoneTextField.secureTextEntry=YES;
    [self.view addSubview:telephoneTextField];
    
    //短信验证码
    HP_UIImageView *bgImageView40 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, telephoneTextField.frame.size.height + telephoneTextField.frame.origin.y + 40,40, 40)];
    [bgImageView40 setImage:[UIImage imageNamed:@"email"]];
    [self.view addSubview:bgImageView40];
    
    HP_UIImageView *bg3ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20+40, telephoneTextField.frame.size.height + telephoneTextField.frame.origin.y + 40,190, 40)];
    [bg3ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg3ImageView];
    
    passCodeTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(20+40, telephoneTextField.frame.size.height + telephoneTextField.frame.origin.y + 40, 110, 40)];
    [passCodeTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passCodeTextField.backgroundColor = [UIColor clearColor];
    passCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    passCodeTextField.placeholder = @"请输入验证码";
    passCodeTextField.font = [UIFont systemFontOfSize:14];
    passCodeTextField.delegate = self;
    passCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    passCodeTextField.borderStyle = UITextBorderStyleNone;
    passCodeTextField.secureTextEntry=NO;
    [self.view addSubview:passCodeTextField];
    
    sendCheckCodeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"senddj"] forState:UIControlStateHighlighted];
    [sendCheckCodeButton setBackgroundColor:[HP_UIColorUtils clearColor]];
    [sendCheckCodeButton setFrame:CGRectMake(215, telephoneTextField.frame.size.height + telephoneTextField.frame.origin.y + 40, 85, 40)];
    [sendCheckCodeButton addTarget:self action:@selector(touchSendCheckCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendCheckCodeButton];
    
    UILabel *sendCheckCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 40)];
    sendCheckCodeLabel.textAlignment = NSTextAlignmentCenter;
    sendCheckCodeLabel.backgroundColor = [UIColor clearColor];
    sendCheckCodeLabel.text = @"获取验证码";
    sendCheckCodeLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    sendCheckCodeLabel.font = [UIFont systemFontOfSize:15];
    [sendCheckCodeButton addSubview:sendCheckCodeLabel];
    
    
    sendLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,sendCheckCodeButton.frame.size.height + sendCheckCodeButton.frame.origin.y + 40, 285, 40)];
    sendLabel.textAlignment = NSTextAlignmentCenter;
    sendLabel.backgroundColor = [UIColor clearColor];
    sendLabel.text = @"验证码已发送，有效期30分钟";
    sendLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    sendLabel.font = [UIFont systemFontOfSize:15];
    sendLabel.hidden = YES;
    [self.view  addSubview:sendLabel];
    
    radioAgreement=[[RadioButton alloc] initWithFrame:CGRectMake(36, sendCheckCodeButton.frame.origin.y+sendCheckCodeButton.frame.size.height+20, 200, 80) typeCheck:YES];
    [radioAgreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [radioAgreement setTitle:@"我已阅读并且同意投资授权协议" forState:UIControlStateNormal];
    radioAgreement.titleLabel.font=[UIFont systemFontOfSize:12];
    radioAgreement.delegate=self;
    radioAgreement.tag=707;
    [self.view addSubview:radioAgreement];
    
    //确定
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, radioAgreement.frame.origin.y+radioAgreement.frame.size.height+ 20, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*20, 40)];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.backgroundColor = [UIColor clearColor];
    registerLabel.text = @"提交";
    registerLabel.textColor = [UIColor whiteColor];
    registerLabel.font = [UIFont systemFontOfSize:15];
    [registerButton addSubview:registerLabel];
}


- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect{
    int flags = 0;
    if (tagselect==708) {
    }
    
}

-(void)touchCommitButton{
    
    //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
    NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
    
    [Dict setObject:@"userid" forKey:USER_ID];
    [Dict setObject:[NSString stringWithFormat:@"1"] forKey:@"no"];
    [Dict setObject:@"华永奇" forKey:@"name"];
    [Dict setObject:@"18612450658" forKey:@"phonenum"];
    [Dict setObject:@"340881198904120838"  forKey:@"identifyno" ];
    [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:@"curNatureMenInfo"];
    
    settingNaturalManInfoSuccessViewController *info = [[settingNaturalManInfoSuccessViewController alloc] init];
    [self.navigationController pushViewController:info
                                         animated:NO];
    
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
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    [connDictionary setObject:telephoneTextField.text forKey:@"phonenum"];
    [connDictionary setObject:nameTextField.text forKey:@"name"];
    [connDictionary setObject:dentifierTextField.text forKey:@"identifyno"];
    [connDictionary setObject:passCodeTextField.text forKey:@"verificationCode"];


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
             responseJSONDictionary = [self delStringNull:[responseJSONDictionary objectForKey:@"code"]];
             
             //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             
             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             [Dict setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"no"]] forKey:@"no"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"name"] forKey:@"name"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"phonenum"] forKey:@"phonenum"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"identifyno"] forKey:@"identifyno"];
             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:@"curNatureMenInfo"];
             
             settingNaturalManInfoSuccessViewController *info = [[settingNaturalManInfoSuccessViewController alloc] init];
             [self.navigationController pushViewController:info
                                                  animated:NO];
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
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    [connDictionary setObject:telephoneTextField.text forKey:@"phonenum"];
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
    [nameTextField resignFirstResponder];
    [passCodeTextField resignFirstResponder];
    
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
