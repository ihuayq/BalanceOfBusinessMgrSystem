//
//  BMWithDrawsCashViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/12.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMWithDrawsCashViewController.h"
#import "BMWithDrawsCashSuccessViewController.h"


@interface BMWithDrawsCashViewController (){
    HP_UITextField *nameTextField;
    HP_UITextField *passwordTextField;
}

@end

@implementation BMWithDrawsCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"提现";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    UILabel * canDrawCashLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 ,NAVIGATION_OUTLET_HEIGHT + 10, 200,20)];
    canDrawCashLabel.textAlignment = NSTextAlignmentLeft;
    canDrawCashLabel.text = @"可提现金额（元）";
    canDrawCashLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:canDrawCashLabel];
    
    UILabel * canDrawCashNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/2 + 20 ,NAVIGATION_OUTLET_HEIGHT + 30, 200,20)];
    canDrawCashNumberLabel.textAlignment = NSTextAlignmentLeft;
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"balanceInfo"];
    //NSLog(@"the balanceInfo is: %@",dic);
    canDrawCashNumberLabel.text =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalAmount"]];
    canDrawCashNumberLabel.font = [UIFont systemFontOfSize:24];
    canDrawCashNumberLabel.textColor = UISTYLECOLOR;
    [self.view addSubview:canDrawCashNumberLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,canDrawCashNumberLabel.frame.size.height + canDrawCashNumberLabel.frame.origin.y+ 5 , MainWidth,1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    UILabel * realDrawCashLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 ,line.frame.size.height + line.frame.origin.y+ 10, 160,20)];
    realDrawCashLabel.textAlignment = NSTextAlignmentLeft;
    realDrawCashLabel.text = @"提现金额（元）";
    realDrawCashLabel.font = [UIFont systemFontOfSize:15];
     [self.view addSubview:realDrawCashLabel];
    
    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(20, realDrawCashLabel.frame.size.height + realDrawCashLabel.frame.origin.y + 5, MainWidth - 20*2, 60)];
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.placeholder = @"点击输入金额";
    nameTextField.font = [UIFont systemFontOfSize:24];
    nameTextField.delegate = self;
    nameTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
//    [nameTextField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
//    [nameTextField.layer setBorderWidth:0.5f];
    [self.view addSubview:nameTextField];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0,nameTextField.frame.size.height + nameTextField.frame.origin.y + 10, MainWidth,0.5F)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    UILabel * CardLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 ,line2.frame.size.height + line2.frame.origin.y + 10, 140,20)];
    CardLabel.textAlignment = NSTextAlignmentLeft;
    CardLabel.text = @"提现银行卡号：";
    CardLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:CardLabel];
    
    UILabel * CardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CardLabel.frame.origin.x + CardLabel.frame.size.width - 20 ,line2.frame.size.height + line2.frame.origin.y + 10, 180,20)];
    CardNumLabel.textAlignment = NSTextAlignmentLeft;
    //NSLog(@"the balance card no :%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO]  objectForKey:@"balanceCardNo"]);
    CardNumLabel.text =  [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"drawCardNo"]];
    
//    NSMutableString *modifyStr= [[NSMutableString alloc] initWithString:CardNumLabel.text];
//    if (modifyStr.length > 10) {
//        [modifyStr replaceCharactersInRange:NSMakeRange(4, modifyStr.length-8) withString:@"******"];
//    }
//    CardNumLabel.text = modifyStr;
    
    
    CardNumLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:CardNumLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(20, CardNumLabel.frame.size.height + CardNumLabel.frame.origin.y + 5,   MainWidth - 20*2, 40)];
    [passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [passwordTextField setInsets:UIEdgeInsetsMake(25, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入交易密码";
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.secureTextEntry = YES;
    [self.view addSubview:passwordTextField];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0,passwordTextField.frame.size.height + passwordTextField.frame.origin.y + 10, MainWidth,0.5F)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line3];
    
    //确定
    HP_UIButton *okButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [okButton setBackgroundColor:[UIColor redColor]];
    [okButton setFrame:CGRectMake(20,MainHeight -180, MainWidth-2*20, 40)];
    [okButton addTarget:self action:@selector(touchOkButton) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitle:@"确认" forState:UIControlStateNormal];
    [okButton.layer setMasksToBounds:YES];
    [okButton.layer setCornerRadius:okButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
    //cancelButton.enabled = false;
    [self.view addSubview:okButton];
    
}

-(BOOL)checkDrawMoney:(NSString*)strMoney{
    //金额输入不能为空
    NSString* msgstring=[nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (msgstring.length==0)
    {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"请输入金额" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    float drawMoney = [msgstring floatValue];
    float canDrawMoney = [[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"balanceInfo"] objectForKey:@"totalAmount"]] floatValue];
    if ( drawMoney - canDrawMoney >= 0.001) {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"输入金额大于可提现金额" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    if (drawMoney < 0.001) {
        UIAlertView* alertview=[[UIAlertView alloc]initWithTitle:nil message:@"输入金额必须大于零元" delegate:self cancelButtonTitle:queding otherButtonTitles:nil, nil];
        [alertview show];
        return NO;
    }
    
    return  YES;
}

-(void)requestNetWork{

    //查看输入金额大小是否大于可提现的金额
    if (![self checkDrawMoney:nameTextField.text])
    {
        return;
    }
    
    //查看输入金额大小是否大于可提现的金额
    if (![self checkPassWordString:passwordTextField.text])
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
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];

    
    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"pay_passwd_3des_encode"];
    
    [connDictionary setObject:nameTextField.text forKey:@"drawcash"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    //NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,getbalanceURL];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,WithDrawURL];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求提现..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             //缓存最新的资产信息
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"balanceInfo"] forKey:@"balanceInfo"];
             //向资产界面传递资产的变动信息
             NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"balanceInfo",@"textOne", nil];
             //创建通知
             NSNotification *notification =[NSNotification notificationWithName:@"AssetChange" object:nil userInfo:dict];
             //通过通知中心发送通知
             [[NSNotificationCenter defaultCenter] postNotification:notification];
             
             BMWithDrawsCashSuccessViewController *vc = [[BMWithDrawsCashSuccessViewController alloc] init];
             vc.money = nameTextField.text;
             vc.time  = [responseJSONDictionary objectForKey:@"deadLinetime"];
             vc.cardNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"drawCardNo"];
             [self.navigationController pushViewController:vc animated:YES];
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
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
    
}

-(void)touchOkButton{
    ////向资产界面传递资产的变动信息
//    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"11123",@"textOne",@"11123",@"textTwo", nil];
//    //创建通知
//    NSNotification *notification =[NSNotification notificationWithName:@"AssetChange" object:nil userInfo:dict];
//    //通过通知中心发送通知
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//    [self.navigationController popViewControllerAnimated:YES];
    [self requestNetWork];
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
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    if (textField==nameTextField)
    {
        [futureString  insertString:string atIndex:range.location];
//        NSString *regex = @"^(([1-9]\d*)|0)(\.(\d){1,2})?$";
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//        BOOL isMatch = [pred evaluateWithObject:string];
//        
//        if (!isMatch)
//        {
////            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:queding otherButtonTitles:nil, nil];
////            [alert show];
//            return NO;
//            
//        }
        
        if ([futureString characterAtIndex:0] == '.') {
            return  NO;
        }
        
        if (futureString.length >= 2) {
            if ([futureString characterAtIndex:0] == '0' ) {
                if ([futureString characterAtIndex:1] != '.') {
                    //nameTextField.text = futureString;
                    return  NO;
                }
            }
        }
        
        NSInteger flag=0;
        const NSInteger limited = 2;
        for (int i = futureString.length-1; i>=0; i--) {
            
            if ([futureString characterAtIndex:i] == '.') {
                
                if (flag > limited) {
                    return NO;
                }
                
                break;
            }
            flag++;
        }
    }
   
    return futureString.length < 16;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 5, 0);
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 5, 0);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    }];
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
