//
//  BMCancelInvestmentViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMCancelInvestmentViewController.h"

@interface BMCancelInvestmentViewController ()
{
    HP_UITextField* passWordTextField;
}
@end

@implementation BMCancelInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"取消预约";
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 40,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    //label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s = @"取消预约后，资金将通过正常的结算方式打款至您的结算账户，不在进入理财队列，请知悉！";
    UIFont *font = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size = CGSizeMake(300,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 30, labelsize.width, labelsize.height)];
    label.text = s;
    [self.view addSubview:label];
    
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, MainHeight -350,MainWidth-40, 40)];
    [bgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView];
    
    HP_UIImageView *passImage = [[HP_UIImageView alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    [passImage setImage:[UIImage imageNamed:@"密码照"]];
    [bgImageView addSubview:passImage];

    
    passWordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(30, MainHeight -350, 140, 40)];
    [passWordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passWordTextField.backgroundColor = [UIColor clearColor];
    passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passWordTextField.placeholder = @"请输入6位交易密码";
    passWordTextField.font = [UIFont systemFontOfSize:16];
    passWordTextField.delegate = self;
    passWordTextField.keyboardType = UIKeyboardTypeEmailAddress;
    passWordTextField.borderStyle = UITextBorderStyleNone;
    passWordTextField.secureTextEntry=NO;
    [self.view addSubview:passWordTextField];
    
    //确定
    HP_UIButton *forgetPassWordButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    [forgetPassWordButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
//    [forgetPassWordButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
//    [forgetPassWordButton setBackgroundColor:[UIColor blueColor]];
    [forgetPassWordButton setFrame:CGRectMake(MainWidth - 120,MainHeight -300, 2*50, 40)];
    [forgetPassWordButton addTarget:self action:@selector(touchForgetPassWordButton) forControlEvents:UIControlEventTouchUpInside];
    [forgetPassWordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPassWordButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    //cancelButton.enabled = false;
    [self.view addSubview:forgetPassWordButton];
    
    //确定
    HP_UIButton *cancelButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [cancelButton setBackgroundColor:[UIColor redColor]];
    [cancelButton setFrame:CGRectMake(40,MainHeight -200, MainWidth-2*40, 40)];
    [cancelButton addTarget:self action:@selector(touchCanceButton) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"确认取消" forState:UIControlStateNormal];
    [cancelButton.layer setMasksToBounds:YES];
    [cancelButton.layer setCornerRadius:cancelButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
    //cancelButton.enabled = false;
    [self.view addSubview:cancelButton];
    
//    NSString *strLabel = @"预约购买";
//    registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*40, 40)];
//    registerLabel.textAlignment = NSTextAlignmentCenter;
//    registerLabel.backgroundColor = [UIColor clearColor];
//    registerLabel.textColor = [UIColor whiteColor];
//    registerLabel.font = [UIFont systemFontOfSize:15];
    //CGSize titleSize = [strLabel sizeWithFont:registerLabel.font constrainedToSize:CGSizeMake(MainWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    
}


-(void)touchForgetPassWordButton{
    
}

-(void)requestNetWork{
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:@"0" forKey:@"status"];
    
    //支付密码
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passWordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"pay_passwd_3des_encode"];
    
    //[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"transactionpassword"]
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
     NSString *url =[NSString stringWithFormat:@"%@%@",IP,DrawCashURL];
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求取消预约..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             ////向资产界面传递资产的变动信息
             NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"cancelSuccess", nil];
             //创建通知
             NSNotification *notification =[NSNotification notificationWithName:@"AppointmentChange" object:nil userInfo:dict];
             //通过通知中心发送通知
             [[NSNotificationCenter defaultCenter] postNotification:notification];
             
             //发送网络请求，请求预约
             //[[[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功，成功投资金额可能需要一定时间才能显示，谢谢您的使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
             [self.navigationController popViewControllerAnimated:YES];
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
//    if (msgstring1.length<6)
//    {
//        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"支付密码最少6位" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alertview show];
//        return NO;
//    }
//    if (![self checkPassWordString:str1])
//    {
//        return NO;
//    }
    
    if (![str1 isEqualToString:str2])
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"支付密码输入不一致" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
//    if ([str1 isEqualToString:[transmitDict objectForKey:USER_PASSWORD]])
//    {
//        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"支付密码不能与登录密码相同" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
//        [alertview show];
//        return NO;
//    }
    return YES; 
}


-(void)touchCanceButton{
//    if (![self checkPassWordString:passWordTextField.text])
//    {
//        return;
//    }
    
    [self requestNetWork];
    
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
    if (textField==passWordTextField)
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
    [passWordTextField resignFirstResponder];
    
//    [UIView animateWithDuration:0.2 animations:^{
//        [self.view setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
//    }];
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
