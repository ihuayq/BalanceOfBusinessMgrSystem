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
#import "BMCreateTransactionpPasswordViewController.h"
#import "BMInvestmentConfirmViewController.h"
#import "BTLabel.h"

@interface BMInvestmentViewController ()<UIAlertViewDelegate>{
    UIWebView *manualProductWebView;
    
    UIButton *registerButton;
    UILabel * registerLabel;
    UILabel * manTitleLabel;
    RadioButton *radioAgreement;
    HP_UIButton *investProtolBtn;
    
    BOOL isHasAppointment;
    
    UIView *datingView;
    UIView *cancelView;
}

@end

@implementation BMInvestmentViewController

-(void)cancelDatingUiView{
    
    cancelView = [[UIView alloc] initWithFrame:CGRectMake(0,0, MainWidth , MainHeight)];
    
    
    HP_UIImageView *noticeImg = [[HP_UIImageView alloc] initWithFrame:CGRectMake(MainWidth/2-15, NAVIGATION_OUTLET_HEIGHT + 36,30, 30)];
    [noticeImg setImage:[UIImage imageNamed:@"成功"]];
    [cancelView addSubview:noticeImg];
    
    BTLabel *label;
    
    CGFloat fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? 13 : 8;
    UIFont *font = [UIFont systemFontOfSize:18];
    CGColorRef color = [UIColor colorWithHue:0 saturation:0 brightness:0.8 alpha:1].CGColor;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:28],
                                 NSForegroundColorAttributeName: [UIColor orangeColor]
                                 };
    
    label = [[BTLabel alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 60,MainWidth - 20*2,120) edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    label.font = font;
    label.text = [NSString stringWithFormat:@"预约成功，结算款将在下一个结算日开始转入理财账户，入账金额成功投资后产生收益!"];
    label.verticalAlignment = BTVerticalAlignmentCenter;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 3;
    //    label.layer.borderWidth = 1;
    //    label.layer.borderColor = color;
    [cancelView addSubview:label];
    
    
    //初始化label
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    //设置自动行数与字符换行
    [label2 setNumberOfLines:0];
    //label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s2 = @"年化收益率  8%";
    UIFont *font2 = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size2 = CGSizeMake(300,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize2 = [s2 sizeWithFont:font constrainedToSize:size2 lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label2 setFrame:CGRectMake(MainWidth/2 - labelsize2.width/2, NAVIGATION_OUTLET_HEIGHT + 240, labelsize2.width, labelsize2.height)];
    label2.text = s2;
    label2.textAlignment = UITextAlignmentCenter;
    
    [cancelView addSubview:label2];
    
    
    HP_UIButton *cancelInvestBtn=[[HP_UIButton alloc] initWithFrame:CGRectMake(MainWidth - 100 ,MainHeight - 48.5 - 44 - 30,60,30)];
    [cancelInvestBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [cancelInvestBtn addTarget:self action:@selector(touchCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [cancelInvestBtn setTitle:@"取消预约" forState:UIControlStateNormal];
    cancelInvestBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [cancelView addSubview:cancelInvestBtn];
}

-(void)datingUiView{
    
    datingView = [[UIView alloc] initWithFrame:CGRectMake(0,0, MainWidth , MainHeight)];
    
    //超额宝介绍
    manualProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(40, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 40*2, 180)];
    [manualProductWebView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [manualProductWebView.layer setBorderWidth:0.5f];
    [datingView addSubview:manualProductWebView];
    
    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"我要投资" ofType:@"html"];
    NSString *htmlString1= [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
    [manualProductWebView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
    
    radioAgreement=[[RadioButton alloc] initWithFrame:CGRectMake(40, manualProductWebView.frame.origin.y+manualProductWebView.frame.size.height+20, 20, 20) typeCheck:NO];
    [radioAgreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    radioAgreement.titleLabel.font=[UIFont systemFontOfSize:12];
    radioAgreement.delegate=self;
    radioAgreement.tag=707;
    [datingView addSubview:radioAgreement];
    
    //自然人姓名
    manTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(radioAgreement.frame.origin.x + radioAgreement.frame.size.width, manualProductWebView.frame.origin.y+manualProductWebView.frame.size.height+20, 85, 20)];
    manTitleLabel.text = @"已阅读并同意";
    manTitleLabel.textAlignment = NSTextAlignmentLeft;
    manTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manTitleLabel.font = [UIFont systemFontOfSize:14];
    manTitleLabel.backgroundColor = [UIColor clearColor];
    manTitleLabel.numberOfLines = 0;
    [datingView addSubview:manTitleLabel];
    
    
    investProtolBtn=[[HP_UIButton alloc] initWithFrame:CGRectMake(manTitleLabel.frame.origin.x + manTitleLabel.frame.size.width-5, manualProductWebView.frame.origin.y+manualProductWebView.frame.size.height+20, 120, 20)];
    [investProtolBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [investProtolBtn addTarget:self action:@selector(touchProtocalButton) forControlEvents:UIControlEventTouchUpInside];
    [investProtolBtn setTitle:@"自然人投资协议" forState:UIControlStateNormal];
    investProtolBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [datingView addSubview:investProtolBtn];
    
    //确定
    registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, radioAgreement.frame.origin.y+radioAgreement.frame.size.height+ 20, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchDatingButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"提交" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    registerButton.enabled = false;
    [datingView addSubview:registerButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"投资首页";
    
    [self datingUiView];
    [self cancelDatingUiView];
    
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
    
    if ([text.userInfo[@"cancelSuccess"] isEqualToString:@"1"]) {
        [self setAppointmentInfo:NO];
    }
    else{
        [self setAppointmentInfo:YES];
    }
}

-(void)setAppointmentInfo:(BOOL)bHasAppointment{
    if (!bHasAppointment) {
         [registerButton setTitle:@"预约购买" forState:UIControlStateNormal];
        manTitleLabel.hidden = NO;
        radioAgreement.hidden = NO;
        investProtolBtn.hidden= NO;
        registerButton.enabled = NO;

        //[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] setObject:@"0" forKey:@"appointment"];
        NSMutableDictionary*data = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO]];
        [data setObject:@"0" forKey:@"appointment"];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERINFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.view addSubview:datingView];
        [cancelView removeFromSuperview];
    }else{
        [registerButton setTitle:@"取消预约" forState:UIControlStateNormal];
        manTitleLabel.hidden = YES;
        radioAgreement.isChecked = NO;
        radioAgreement.hidden = YES;
        investProtolBtn.hidden = YES;
        
        [self.view addSubview:cancelView];
        [datingView removeFromSuperview];
        
//        [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] setObject:@"1" forKey:@"appointment"];
        NSMutableDictionary*data = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO]];
        [data setObject:@"1" forKey:@"appointment"];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERINFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
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
//    NSLog(@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"appointment"]);
//    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"appointment"] isEqualToString:@"1"]) {
//        BMCancelInvestmentViewController *cancelVC = [[BMCancelInvestmentViewController alloc] init];
//        cancelVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:cancelVC animated:YES];
//    }
//    else{
//        [self requestNetWork];
//    }
    
    BMInvestmentConfirmViewController *vc = [[BMInvestmentConfirmViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    return;
}

-(void)touchCancelButton{
    NSLog(@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"appointment"]);
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"appointment"] isEqualToString:@"1"]) {
        BMCancelInvestmentViewController *cancelVC = [[BMCancelInvestmentViewController alloc] init];
        cancelVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cancelVC animated:YES];
    }
}

//-(void)requestNetWork{
//    if (![HP_NetWorkUtils isNetWorkEnable])
//    {
//        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
//        return;
//    }
//    [self touchesBegan:nil withEvent:nil];
//    
//    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
//    
//    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
//    [connDictionary setObject:@"1" forKey:@"status"];
//    
//    NSString *url =[NSString stringWithFormat:@"%@%@",IP,DrawCashURL];
//    
//    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
//    
//    //NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,getbalanceURL];
//    
//    NSLog(@"connDictionary:%@",connDictionary);
//    [self showProgressViewWithMessage:@"正在请求预约..."];
//    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
//     {
//         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
//         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
//         if([ret isEqualToString:@"100"])
//         {
//             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
//
//             [self setAppointmentInfo:YES];
//             //[[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"appointment"];
//             //发送网络请求，请求预约
//             [[[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功，成功投资金额可能需要一定时间才能显示，谢谢您的使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
//         }
//         else
//         {
//             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
//         }
//     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error,NSString * msg) {
//         NSLog(@"error:%@",error.debugDescription);
//         if (![request isCancelled])
//         {
//             [request cancel];
//         }
//         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
//         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
//         alertView.tag = 999;
//         [alertView show];
//     }];
//
//}



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
