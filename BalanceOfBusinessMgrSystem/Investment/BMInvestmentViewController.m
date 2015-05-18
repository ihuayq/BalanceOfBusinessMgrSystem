//
//  BMInvestmentViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMInvestmentViewController.h"
#import "RadioButton.h"
#import "BMCancelInvestmentViewController.h"
#import "BMSettingTransactionpPasswordViewController.h"

@interface BMInvestmentViewController ()<UIAlertViewDelegate>{
    UIWebView *manualProductWebView;
    
    UIButton *registerButton;
    UILabel * registerLabel;
    UILabel * manTitleLabel;
    RadioButton *radioAgreement;
    HP_UIButton *investProtolBtn;
    
    BOOL isHasAppointment;
}

@end

@implementation BMInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"投资首页";
    
    //超额宝介绍
    manualProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(40, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 40*2, 180)];
    [manualProductWebView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [manualProductWebView.layer setBorderWidth:0.5f];
    [self.view addSubview:manualProductWebView];
    
    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"我要投资" ofType:@"html"];
    NSString *htmlString1= [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
    [manualProductWebView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
    
    radioAgreement=[[RadioButton alloc] initWithFrame:CGRectMake(40, manualProductWebView.frame.origin.y+manualProductWebView.frame.size.height+20, 20, 20) typeCheck:NO];
    [radioAgreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[radioAgreement setTitle:@"已阅读并同意自然人投资协议" forState:UIControlStateNormal];
    radioAgreement.titleLabel.font=[UIFont systemFontOfSize:12];
    radioAgreement.delegate=self;
    radioAgreement.tag=707;
    [self.view addSubview:radioAgreement];
    
    //自然人姓名
     manTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(radioAgreement.frame.origin.x + radioAgreement.frame.size.width, manualProductWebView.frame.origin.y+manualProductWebView.frame.size.height+20, 85, 20)];
    manTitleLabel.text = @"已阅读并同意";
    manTitleLabel.textAlignment = NSTextAlignmentLeft;
    manTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manTitleLabel.font = [UIFont systemFontOfSize:14];
    manTitleLabel.backgroundColor = [UIColor clearColor];
    manTitleLabel.numberOfLines = 0;
    [self.view addSubview:manTitleLabel];
    
    
    investProtolBtn=[[HP_UIButton alloc] initWithFrame:CGRectMake(manTitleLabel.frame.origin.x + manTitleLabel.frame.size.width-5, manualProductWebView.frame.origin.y+manualProductWebView.frame.size.height+20, 120, 20)];
    [investProtolBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [investProtolBtn addTarget:self action:@selector(touchProtocalButton) forControlEvents:UIControlEventTouchUpInside];
    [investProtolBtn setTitle:@"自然人投资协议" forState:UIControlStateNormal];
    investProtolBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:investProtolBtn];
    
    //确定
    registerButton = [HP_UIButton buttonWithType:UIButtonTypeRoundedRect];
//  [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
//  [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor redColor]];
    [registerButton setFrame:CGRectMake(40,radioAgreement.frame.origin.y+ radioAgreement.frame.size.height + 40, MainWidth-2*40, 40)];
    [registerButton addTarget:self action:@selector(touchDatingButton) forControlEvents:UIControlEventTouchUpInside];
    registerButton.enabled = false;
    [registerButton setTitle:@"预约购买" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [registerButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [registerButton.layer setBorderColor:colorref];//边框颜色
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    
//  [registerButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
//  [registerButton.titleLabel setTextColor:[UIColor whiteColor]];
//  [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSLog(@"THE APPOINTMENT IS %@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO ]objectForKey:@"appointment"]);
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO]objectForKey:@"appointment"] isEqualToString:@"1"]) {
        [self setAppointmentInfo:YES];
    }
    else{
        [self setAppointmentInfo:NO];
    }

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppointmentChange:) name:@"AppointmentChange" object:nil];
    

}

- (void)AppointmentChange:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"AppointmentChange"]);
    NSLog(@"－－－－－接收到通知------");
    
    [self setAppointmentInfo:NO];
    
}

-(void)setAppointmentInfo:(BOOL)bHasAppointment{
    if (!bHasAppointment) {
         [registerButton setTitle:@"预约购买" forState:UIControlStateNormal];
        manTitleLabel.hidden = NO;
        radioAgreement.hidden = NO;
        investProtolBtn.hidden= NO;
        registerButton.enabled = NO;

        [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] setObject:@"0" forKey:@"appointment"];
    }else{
        [registerButton setTitle:@"取消预约" forState:UIControlStateNormal];
        manTitleLabel.hidden = YES;
        radioAgreement.hidden = YES;
        investProtolBtn.hidden = YES;
        [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] setObject:@"1" forKey:@"appointment"];
        registerButton.enabled = YES;
    }
   
}


// 在这里处理UIAlertView中的按钮被单击的事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex is : %i",(int)buttonIndex);
    switch (buttonIndex) {
        case 0:{
            //radioAgreement.hidden = true;
            //[registerButton setTitle:@"取消预约" forState:UIControlStateNormal];
            
        }break;
        default:
            break;
    }
}


- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect{
    if (radiobutton.tag == 707) {
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
    
}


-(void)touchDatingButton{
    // 查看是否设置了支付密码
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"payMark"] isEqualToString:@"0"]) {
//         BMSettingTransactionpPasswordViewController *VC = [[BMSettingTransactionpPasswordViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//        return;
//    }
    
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"appointment"] isEqualToString:@"1"]) {
        BMCancelInvestmentViewController *cancelVC = [[BMCancelInvestmentViewController alloc] init];
        [self.navigationController pushViewController:cancelVC animated:YES];
    }
    else{
        [self requestNetWork];
    }
    return;
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
    [connDictionary setObject:@"1" forKey:@"status"];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,DrawCashURL];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    //NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,getbalanceURL];
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求预约..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             
             [self setAppointmentInfo:YES];
//             buyInvestProjectView=[[BuyInvestProjectView alloc]init];
//             buyInvestProjectView.navgDelegate=self.navigationController;
//             buyInvestProjectView.type=0;
//             
//             [buyInvestProjectView.transferDict setObject:[responseJSONDictionary objectForKey:@"partnerbalance"] forKey:@"partnerbalance"];
//             [buyInvestProjectView.transferDict setObject:[responseJSONDictionary objectForKey:@"userbalance"] forKey:@"userbalance"];
//             //"leastbuyshare": "最小起买份额"
//             [buyInvestProjectView.transferDict setValue:[dataDict objectForKey:@"leastbuyshare"] forKey:@"leastbuyshare"];
//             [buyInvestProjectView.transferDict setValue:[dataDict objectForKey:@"unitprice"] forKey:@"unitprice"];
//             [buyInvestProjectView.transferDict setObject:[dataDict objectForKey:@"bidno"] forKey:@"bidno"];
//             
//             
//             [buyInvestProjectView viewDidLoad];
//             [buyInvestProjectView.okBuyButton addTarget:self action:@selector(touchbuyInvestProjectViewokBuyButton) forControlEvents:UIControlEventTouchUpInside];
//             [self.view addSubview:buyInvestProjectView];
             //[[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"appointment"];
             //发送网络请求，请求预约
             [[[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功，成功投资金额可能需要一定时间才能显示，谢谢您的使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
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
