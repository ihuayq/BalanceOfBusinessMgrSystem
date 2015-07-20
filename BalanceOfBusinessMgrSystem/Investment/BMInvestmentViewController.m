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
#import "ProtocalViewController.h"
#import "settingNaturalManInfoViewController.h"

#import "BankAccountTableViewCell.h"
#import "BMAccountCellInfo.h"
#import "bindBalanceAccountViewController.h"
#import "BankAccountItem.h"
#import "ItemButton.h"
#import "Globle.h"
#import "bindNetworkPointAccountViewController.h"
#import "DXAlertView.h"

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
    
    HP_UIButton *protolBtn1;
    HP_UIButton *protolBtn2;
    HP_UIButton *protolBtn3;
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
    NSString *s2 = [NSString stringWithFormat:@"年化收益率  %@ %%",[[NSUserDefaults standardUserDefaults] objectForKey:@"rate"]];
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
    
    UIView *roundView =[[UIView alloc] initWithFrame:CGRectMake(MainWidth/2 - 120, NAVIGATION_OUTLET_HEIGHT + 20, 240, 240)];
    [roundView.layer setBorderColor:[UISTYLECOLOR CGColor]];
    [roundView.layer setBorderWidth:1.5f];
    [roundView.layer setCornerRadius:roundView.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [datingView addSubview:roundView];
    
    //超额宝介绍
    double lenth = sqrt(240*240/2) - 1.5;
//    manualProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(MainWidth/2 - lenth/2, roundView.frame.origin.y + 240/2 - lenth/2, lenth, lenth)];
//    [datingView addSubview:manualProductWebView];
//    
//    
//    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"超额宝介绍" ofType:@"html"];
//    NSString *htmlString1= [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
//    [manualProductWebView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
    
    //初始化label
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [label2 setNumberOfLines:0];
    NSString *s2 = [NSString stringWithFormat:@"年化收益率  %@ %%",[[NSUserDefaults standardUserDefaults] objectForKey:@"rate"]];
    UIFont *font2 = [UIFont systemFontOfSize:32];
    CGSize size2 = CGSizeMake(300,400);
    CGSize labelsize2 = [s2 sizeWithFont:font2 constrainedToSize:size2 lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label2 setFrame:CGRectMake(MainWidth/2 - lenth/2, roundView.frame.origin.y + 240/2 - lenth/2-30, lenth, lenth)];
    label2.text = s2;
    label2.textColor = UISTYLECOLOR;
    label2.textAlignment = UITextAlignmentCenter;
    [datingView addSubview:label2];
    
    
    BTLabel *label;
    label = [[BTLabel alloc] initWithFrame:CGRectMake(MainWidth/2 - lenth/2, roundView.frame.origin.y + 240/2 - lenth/2+30, lenth, lenth) edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = [NSString stringWithFormat:@"随存随取\n月复利\n投资、提现无手续费"];
    label.verticalAlignment = BTVerticalAlignmentCenter;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 3;
    [datingView addSubview:label];

    
    radioAgreement=[[RadioButton alloc] initWithFrame:CGRectMake(MainWidth/2 - lenth/2 - 20 , roundView.frame.origin.y+roundView.frame.size.height+20, 20, 20) typeCheck:NO];
    [radioAgreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    radioAgreement.titleLabel.font=[UIFont systemFontOfSize:12];
    radioAgreement.delegate=self;
    radioAgreement.tag=707;
    [datingView addSubview:radioAgreement];
    
    //自然人姓名
    manTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(radioAgreement.frame.origin.x + radioAgreement.frame.size.width + 5, roundView.frame.origin.y+roundView.frame.size.height+20, 180, 20)];
    manTitleLabel.text = @"我已阅读并同意以下协议";
    manTitleLabel.textAlignment = NSTextAlignmentLeft;
    manTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manTitleLabel.font = [UIFont systemFontOfSize:14];
    manTitleLabel.backgroundColor = [UIColor clearColor];
    manTitleLabel.numberOfLines = 0;
    [datingView addSubview:manTitleLabel];
    
    
//    investProtolBtn=[[HP_UIButton alloc] initWithFrame:CGRectMake(manTitleLabel.frame.origin.x + manTitleLabel.frame.size.width-5, manualProductWebView.frame.origin.y+manualProductWebView.frame.size.height+20, 120, 20)];
//    [investProtolBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [investProtolBtn addTarget:self action:@selector(touchProtocalButton) forControlEvents:UIControlEventTouchUpInside];
//    [investProtolBtn setTitle:@"自然人投资协议" forState:UIControlStateNormal];
//    investProtolBtn.titleLabel.font=[UIFont systemFontOfSize:14];
//    [datingView addSubview:investProtolBtn];
    
    //    《超额宝自动转入服务协议》
    //    《众信平台服务协议（超额宝）》
    //    《借款协议（超额宝）》
    //超额宝自动转入服务协议
    protolBtn1=[[HP_UIButton alloc] initWithFrame:CGRectMake(MainWidth/2 - lenth/2,manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 10,240,14)];
    [protolBtn1 setTitleColor:UIColorFromRGB(0x00baff) forState:UIControlStateNormal];
    [protolBtn1 addTarget:self action:@selector(touchAutoImportProtocalButton) forControlEvents:UIControlEventTouchUpInside];
    [protolBtn1 setTitle:@"《超额宝自动转入服务协议》" forState:UIControlStateNormal];
    protolBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    protolBtn1.titleLabel.font=[UIFont systemFontOfSize:14];
    [datingView addSubview:protolBtn1];
    
    //《众信平台服务协议（超额宝）》
    protolBtn2=[[HP_UIButton alloc] initWithFrame:CGRectMake(MainWidth/2 - lenth/2,protolBtn1.frame.size.height + protolBtn1.frame.origin.y + 6,240,14)];
    [protolBtn2 setTitleColor:UIColorFromRGB(0x00baff) forState:UIControlStateNormal];
    [protolBtn2 addTarget:self action:@selector(touchZhongXinServiceProtocalButton) forControlEvents:UIControlEventTouchUpInside];
    [protolBtn2 setTitle:@"《众信平台服务协议》" forState:UIControlStateNormal];
    protolBtn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    protolBtn2.titleLabel.font=[UIFont systemFontOfSize:14];
    [datingView addSubview:protolBtn2];
    
//    //《借款协议（超额宝）》
//    protolBtn3=[[HP_UIButton alloc] initWithFrame:CGRectMake(30,protolBtn2.frame.size.height + protolBtn2.frame.origin.y + 6,180,14)];
//    [protolBtn3 setTitleColor:UIColorFromRGB(0x00baff) forState:UIControlStateNormal];
//    [protolBtn3 addTarget:self action:@selector(touchReceiptMoneyProtocalButton) forControlEvents:UIControlEventTouchUpInside];
//    [protolBtn3 setTitle:@"《借款协议（超额宝）》" forState:UIControlStateNormal];
//    protolBtn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    protolBtn3.titleLabel.font=[UIFont systemFontOfSize:14];
//    [datingView addSubview:protolBtn3];
    
    //确定
    registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    
    [registerButton setFrame:CGRectMake(MainWidth/2 - 120, protolBtn2.frame.origin.y+protolBtn2.frame.size.height+ 10, 240, 40)];
    [registerButton addTarget:self action:@selector(touchDatingButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"提交" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    registerButton.enabled = false;
    [datingView addSubview:registerButton];
}

-(void)touchAutoImportProtocalButton{
    ProtocalViewController * fpw = [[ProtocalViewController alloc] init];
    fpw.viewTitle = @"超额宝自动转入服务协议";
    fpw.urlPath = [NSString stringWithFormat:@"%@%@",PROTOCOL_IP,CHAOEBAOZIDONGZHUANRUFUWUXIEYI_PROTOCOL];
    [self presentModalViewController:fpw animated:YES];
}

-(void)touchZhongXinServiceProtocalButton{
    ProtocalViewController * fpw = [[ProtocalViewController alloc] init];
    fpw.viewTitle = @"众信平台服务协议";
    fpw.urlPath = [NSString stringWithFormat:@"%@%@",PROTOCOL_IP,ZHONGXINPINGTAIFUWU_PROTOCOL];
    [self presentModalViewController:fpw animated:YES];
}

-(void)touchReceiptMoneyProtocalButton{
    ProtocalViewController * fpw = [[ProtocalViewController alloc] init];
    fpw.viewTitle = @"借款协议（超额宝）";
    fpw.urlPath = [NSString stringWithFormat:@"%@%@",PROTOCOL_IP,BORROW_MONEY_PROTOCOL];
    [self presentModalViewController:fpw animated:YES];
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
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"buttonIndex is : %i",(int)buttonIndex);
//    switch (buttonIndex) {
//        case 0:{
//            //radioAgreement.hidden = true;
//            //[registerButton setTitle:@"取消预约" forState:UIControlStateNormal];
//            
//        }break;
//        default:
//            break;
//    }
//}


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
//        //[self requestNetWork];
//    }
    
    NSLog(@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"addNaturalMark"]);
    //查看自然人手机号码是否已经添加完毕
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"addNaturalMark"] isEqualToString:@"0"]) {
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您的个人信息还没有完善，是否现在进行操作？" leftButtonTitle:@"是" rightButtonTitle:@"否"];
        [alert show];
        alert.leftBlock = ^() {
            settingNaturalManInfoViewController *info = [[settingNaturalManInfoViewController alloc] init];
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info
                                                 animated:NO];
        };
    }
    else if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"addwebsiteFlag"] isEqualToString:@"0"]){
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您还没设置银行卡账号信息,是否现在设置!" leftButtonTitle:@"是" rightButtonTitle:@"否"];
        [alert show];
        alert.leftBlock = ^() {
            [self bindNetworkPoint];
        };

    }
    else{
        BMInvestmentConfirmViewController *vc = [[BMInvestmentConfirmViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

    

    return;
}

-(void)bindNetworkPoint{
    [Globle shareGloble].whichBalanceAccountEntranceType = ADD_NATUREMAN_ENTRANCE;//结算账号入口类型
    
    [self requestNetWork];
}

-(void)requestNetWork{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    //http://192.168.1.107:8080/superMoney-core/commercia/getCommercialWebsiteInfo?commercialId=M0060013&personId=7
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID] forKey:USER_ID];
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,AccountURL];
    
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"] forKey:@"personId"];
    
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求账号数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             //设定当前自然人信息
             //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
             //             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             //             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             //             [Dict setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"personId"]] forKey:@"no"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"personName"] forKey:@"name"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"phoneNum"] forKey:@"phonenum"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"idCard"] forKey:@"identifyno"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"websiteList"] forKey:@"accountinfo"];
             //             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:@"curNatureMenInfo"];
             //保存完毕，注意在修改自然人的入口需要重新设定curNatureMenInfo信息
             
             NSMutableArray *groupNet=[[NSMutableArray alloc]init];
             NSArray *array = [responseJSONDictionary objectForKey:@"websiteList"];
             for ( NSDictionary *dic in array) {
                 //NSDictionary *dic=[array objectAtIndex:0];
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [dic objectForKey:@"pubAccName"];
                 item.bankName = [dic objectForKey:@"pubBankNameDet"];
                 item.bankCardNumber = [dic objectForKey:@"balanceAccount"];
                 item.siteNum = [dic objectForKey:@"siteNum"];
                 item.bSelected = [[dic objectForKey:@"selectedAccFlag"]  boolValue] ;//结算账号选定标记
                 item.bNetworkSelected = [[dic objectForKey:@"selectedFlag"] boolValue];//网点账号选定标记
                 [groupNet addObject:item];
             }
             //methods为true的时候，即按照网点来结算业务，表示返回网点和结算账户都有，且两者相同
             //methods为false的时候，按照商户结算，结算账户必有且只有一个，但是商户账户可能有也可能没有，即websiteList可能为空
             [[NSUserDefaults standardUserDefaults]setObject:[responseJSONDictionary objectForKey:@"methods"] forKey:@"methods"];
             
             // 网点情况
             if ([[responseJSONDictionary objectForKey:@"methods"] isEqualToString:@"TRUE"]) {
                 bindNetworkPointAccountViewController *info = [[bindNetworkPointAccountViewController alloc] init];
                 info.groupBalance = nil;
                 info.groupNetWork = groupNet;
                 [self.navigationController pushViewController:info
                                                      animated:NO];
             }
             //为false的情况，商户情况,含有网点和没有网点的情况，
             else{
                 
                 NSMutableArray *groupBalance=[[NSMutableArray alloc]init];
                 
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [responseJSONDictionary objectForKey:@"cpubAccName"];
                 item.bankName = [responseJSONDictionary objectForKey:@"cpubBankNameDet"];
                 item.bankCardNumber = [responseJSONDictionary objectForKey:@"cbalanceAccount"];
                 item.bSelected = YES;
                 [groupBalance addObject:item];
                 //含有网点，进入网点，不可以选择
                 if (groupNet.count > 0) {
                     bindNetworkPointAccountViewController *info = [[bindNetworkPointAccountViewController alloc] init];
                     info.groupBalance = groupBalance;
                     info.groupNetWork = groupNet;
                     [self.navigationController pushViewController:info
                                                          animated:NO];
                 }
                 //直接跳过网点选择界面
                 else{
                     bindBalanceAccountViewController *info = [[bindBalanceAccountViewController alloc] init];
                     info.groupNetWork = groupNet;
                     info.groupBalance = groupBalance;
                     [self.navigationController pushViewController:info
                                                          animated:NO];
                 }
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
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
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
