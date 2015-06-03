//
//  ModifyNaturalManIdentifyInfoViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/18.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ModifyNaturalManIdentifyInfoViewController.h"
#import "RadioButton.h"
#import "settingNaturalManInfoSuccessViewController.h"
#import "ModifyNaturalmanSuccessViewController.h"
#import "NaturalManItemModel.h"

@interface ModifyNaturalManIdentifyInfoViewController (){
    HP_UITextField * nameTextField;
    HP_UITextField * dentifierTextField;
    UILabel * telephoneTextField;
    HP_UITextField * passCodeTextField;
    HP_UIButton *sendCheckCodeButton;
    UILabel *sendLabel;
}

@end

@implementation ModifyNaturalManIdentifyInfoViewController

@synthesize model = _model;
-(void)setModel:(NaturalManItemModel *)model_{
    _model = model_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigation.title = @"修改自然人信息";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon"];
    
    [self initUI];
}

-(void) initUI
{
    //设置 姓名信息
    HP_UIImageView *bgImageView10 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView10 setImage:[UIImage imageNamed:@"姓名"]];
    
    UILabel *bgLabel10 = [[UILabel alloc] initWithFrame:CGRectMake(bgImageView10.frame.origin.x + bgImageView10.frame.size.width +5, 10, 30, 20)];
    bgLabel10.textAlignment = NSTextAlignmentCenter;
    bgLabel10.backgroundColor = [UIColor clearColor];
    bgLabel10.text = @"姓名";
    bgLabel10.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    bgLabel10.font = [UIFont systemFontOfSize:15];
    
    HP_UIImageView *bgImageView11 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 , NAVIGATION_OUTLET_HEIGHT + 20,MainWidth-40, 40)];
    [bgImageView11 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView11 ];
    [bgImageView11 addSubview:bgImageView10];
    [bgImageView11 addSubview:bgLabel10];
    
    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(100, NAVIGATION_OUTLET_HEIGHT + 20, 200, 40)];
    [nameTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    //nameTextField.placeholder = @"请输入姓名";
    nameTextField.font = [UIFont systemFontOfSize:14];
    nameTextField.delegate = self;
    nameTextField.keyboardType = UIKeyboardTypeDefault;
    nameTextField.borderStyle = UITextBorderStyleNone;
    //nameTextField.secureTextEntry=YES;
    nameTextField.text = self.model.manName;
    [self.view addSubview:nameTextField];
    
    //设置身份证信息
    HP_UIImageView *bgImageView20 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView20 setImage:[UIImage imageNamed:@"身份证"]];
    
    UILabel *bgLabel20 = [[UILabel alloc] initWithFrame:CGRectMake(bgImageView20.frame.origin.x + bgImageView20.frame.size.width +5,10, 60, 20)];
    bgLabel20.textAlignment = NSTextAlignmentCenter;
    bgLabel20.backgroundColor = [UIColor clearColor];
    bgLabel20.text = @"身份证号";
    bgLabel20.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    bgLabel20.font = [UIFont systemFontOfSize:15];
    
    HP_UIImageView *bgImageView21 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, nameTextField.frame.size.height + nameTextField.frame.origin.y + 20,MainWidth-40, 40)];
    [bgImageView21 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView21];
    [bgImageView21 addSubview:bgImageView20];
    [bgImageView21 addSubview:bgLabel20];
    
    dentifierTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(126, nameTextField.frame.size.height + nameTextField.frame.origin.y + 20, 174, 40)];
    [dentifierTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    dentifierTextField.backgroundColor = [UIColor clearColor];
    dentifierTextField.clearButtonMode = UITextFieldViewModeAlways;
    //dentifierTextField.placeholder = @"请输入身份证信息";
    dentifierTextField.font = [UIFont systemFontOfSize:14];
    dentifierTextField.delegate = self;
    dentifierTextField.keyboardType = UIKeyboardTypeDefault;
    dentifierTextField.borderStyle = UITextBorderStyleNone;
    //dentifierTextField.secureTextEntry=YES;
    dentifierTextField.text = self.model.identifyNumber;
    
    [self.view addSubview:dentifierTextField];
    
    //设置手机号码
    //HP_UIImageView *bgImageView30 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 , dentifierTextField.frame.size.height + dentifierTextField.frame.origin.y + 40,40, 40)];
    HP_UIImageView *bgImageView30 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView30 setImage:[UIImage imageNamed:@"手机号"]];
    
    UILabel *bgLabel30 = [[UILabel alloc] initWithFrame:CGRectMake(bgImageView30.frame.origin.x + bgImageView30.frame.size.width +5, 10, 50, 20)];
    bgLabel30.textAlignment = NSTextAlignmentCenter;
    bgLabel30.backgroundColor = [UIColor clearColor];
    bgLabel30.text = @"手机号";
    bgLabel30.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    bgLabel30.font = [UIFont systemFontOfSize:15];
    
    HP_UIImageView *bgImageView31 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, dentifierTextField.frame.size.height + dentifierTextField.frame.origin.y + 20,MainWidth-40, 40)];
    [bgImageView31 setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView31];
    [bgImageView31 addSubview:bgImageView30];
    [bgImageView31 addSubview:bgLabel30];
    
    telephoneTextField = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 180, 20)];
    telephoneTextField.textAlignment = NSTextAlignmentLeft;
    telephoneTextField.backgroundColor = [UIColor clearColor];
    telephoneTextField.text = self.model.telephoneNumber;
    telephoneTextField.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR1];
    telephoneTextField.font = [UIFont systemFontOfSize:15];
     [bgImageView31 addSubview:telephoneTextField];
//    telephoneTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(120, dentifierTextField.frame.size.height + dentifierTextField.frame.origin.y + 20, 200, 40)];
//    [telephoneTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
//    telephoneTextField.backgroundColor = [UIColor clearColor];
//    telephoneTextField.clearButtonMode = UITextFieldViewModeAlways;
//    //telephoneTextField.placeholder = @"请输入手机号码";//直接用手机号替换
//    telephoneTextField.font = [UIFont systemFontOfSize:14];
//    telephoneTextField.delegate = self;
//    telephoneTextField.keyboardType = UIKeyboardTypeDefault;
//    telephoneTextField.borderStyle = UITextBorderStyleNone;
//    telephoneTextField.text = self.model.telephoneNumber;
//    [self.view addSubview:telephoneTextField];
    
    //短信验证码
    HP_UIImageView *bgImageView40 = [[HP_UIImageView alloc] initWithFrame:CGRectMake(10,10,25,25)];
    [bgImageView40 setImage:[UIImage imageNamed:@"短信验证"]];
    
    HP_UIImageView *bg3ImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, bgImageView31.frame.size.height + bgImageView31.frame.origin.y + 20,190, 40)];
    [bg3ImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bg3ImageView];
    [bg3ImageView addSubview:bgImageView40];
    
    passCodeTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(60, bgImageView31.frame.size.height + bgImageView31.frame.origin.y + 20, 110, 40)];
    [passCodeTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passCodeTextField.backgroundColor = [UIColor clearColor];
    passCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    passCodeTextField.placeholder = @"请输入验证码";
    passCodeTextField.font = [UIFont systemFontOfSize:14];
    passCodeTextField.delegate = self;
    passCodeTextField.keyboardType = UIKeyboardTypeDefault;
    passCodeTextField.borderStyle = UITextBorderStyleNone;
    passCodeTextField.secureTextEntry = NO;
    [self.view addSubview:passCodeTextField];
    
    sendCheckCodeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [sendCheckCodeButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [sendCheckCodeButton setBackgroundColor:[HP_UIColorUtils clearColor]];
    [sendCheckCodeButton setFrame:CGRectMake(215, bgImageView31.frame.size.height + bgImageView31.frame.origin.y + 20, 85, 40)];
    [sendCheckCodeButton addTarget:self action:@selector(touchSendCheckCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [sendCheckCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
     sendCheckCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sendCheckCodeButton];

    //确定
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(40, MainHeight -48.5 - 44.0f - 60 , MainWidth - 80, 40)];
    [registerButton addTarget:self action:@selector(touchCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"提交" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:registerButton];
}

- (void)returnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(nameTextField.text,dentifierTextField.text);
    }
}

-(void)touchCommitButton{
    //test
    
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
    [connDictionary setObject:self.model.personID forKey:@"personID"];
    [connDictionary setObject:self.model.telephoneNumber forKey:@"phoneNum"];
    [connDictionary setObject:[nameTextField.text URLEncodedString] forKey:@"personName"];
    [connDictionary setObject:dentifierTextField.text forKey:@"idCard"];
    [connDictionary setObject:passCodeTextField.text forKey:@"code"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",CommercialIP,ModifyNatureMenIdentifyURL];
    
    [self showProgressViewWithMessage:@"正在设置自然人信息..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary = [self delStringNull:responseJSONDictionary];
             

             
             NSMutableArray *newNatureList = [responseJSONDictionary objectForKey:@"maturalPersonList"];
             if (newNatureList) {
                 NSDictionary *localNatureInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO];
                 NSMutableDictionary *MultablelocalNatureInfoDic = [NSMutableDictionary dictionaryWithDictionary:localNatureInfoDic];
                 [MultablelocalNatureInfoDic setObject:newNatureList forKey:@"natureInfo"];
                 [[NSUserDefaults standardUserDefaults]setObject:MultablelocalNatureInfoDic forKey:SUPPLYER_INFO];
             }
             
             
             
//             //重新设置自然人信息
//
//             for (NSDictionary * sub in results) {
//                 NSLog(@"%@",sub);
//                 
//                 NSString *strPersonID = [NSString stringWithFormat:@"%@",[sub objectForKey:@"personId"]];
//                 if ([ strPersonID isEqualToString:self.model.personID] ) {
//                     NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:sub];
//                     [data setObject:[[sub objectForKey:@"personName"] URLDecodedString] forKey:@"personName"];
//                     [data setObject:[sub objectForKey:@"idCard"] forKey:@"idCard"];
//                     break;
//                 }
//             }
             
             //发送通知
             //向NaturalManInfoMgrViewController
             NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:nameTextField.text,@"personName",dentifierTextField.text,@"idCard", @"0",@"type",nil];
             //创建通知
             NSNotification *notification =[NSNotification notificationWithName:@"NatureManListChange" object:nil userInfo:dict];
             //通过通知中心发送通知
             [[NSNotificationCenter defaultCenter] postNotification:notification];
             
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
    [connDictionary setObject:telephoneTextField.text forKey:@"phoneNum"];

    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",CommercialIP,passCodeURL];
    
    
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
//             UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"是否现在去进行投资理财" delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
//             alertView.tag = 999;
//             [alertView show];
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
    
//    [UIView animateWithDuration:0.2 animations:^{
//        [self.view setFrame:CGRectMake(0, -120, MainWidth, MainHeight)];
//    }];
    
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
