//
//  settingNaturalManInfoSuccessViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "settingNaturalManInfoSuccessViewController.h"
#import "bindNetworkPointAccountViewController.h"
#import "Globle.h"
#import "BankAccountItem.h"

@interface settingNaturalManInfoSuccessViewController ()

@end

@implementation settingNaturalManInfoSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"设置成功";
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    //label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s = @"成功授权自然人，绑定账户后即可登  陆此自然人账号进行投资理财操作！";
    UIFont *font = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size = CGSizeMake(300,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 100, labelsize.width, labelsize.height)];
    label.text = s;
    [self.view addSubview:label];
    
    //绑定网点账户
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, label.frame.size.height + label.frame.origin.y + 100, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(bindNetworkPoint) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"绑定网点账户" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:registerButton];
    
}

-(void)bindNetworkPoint{
    [Globle shareGloble].whichBalanceAccountEntranceType = ADD_NATUREMAN_ENTRANCE;//结算账号入口类型
    //@property (nonatomic,assign) BOOL isCanModifyBalanceAccount;////结算账号可修改类型

    
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
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",CommercialIP,AccountURL];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"] forKey:@"personId"];
    //[connDictionary setObject:@"7" forKey:@"personId"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求账号数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             //NSMutableDictionary* info = [[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO];
             //id hi = [responseJSONDictionary objectForKey:SUPPLYER_ID];
             //[info setObject:[responseJSONDictionary objectForKey:SUPPLYER_ID]  forKey:SUPPLYER_ID];
             //[info setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:SUPPLYER_ID]]  forKey:@"huayq"];
             //[info setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:SUPPLYER_ID]]  forKey:SUPPLYER_ID];
             //[info objectForKey:SUPPLYER_ID] = [NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:SUPPLYER_ID]];
             
             //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             
             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             [Dict setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"personId"]] forKey:@"no"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"personName"] forKey:@"name"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"phoneNum"] forKey:@"phonenum"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"idCard"] forKey:@"identifyno"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"websiteList"] forKey:@"accountinfo"];
             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:@"curNatureMenInfo"];
             
             NSMutableArray *group=[[NSMutableArray alloc]init];
             NSArray *array = [responseJSONDictionary objectForKey:@"websiteList"];
             for ( NSDictionary *dic in array) {
                 //NSDictionary *dic=[array objectAtIndex:0];
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [dic objectForKey:@"pubAccName"];
                 item.bankName = [dic objectForKey:@"pubBankNameDet"];
                 item.bankCardNumber = [dic objectForKey:@"balanceAccount"];
                 item.siteNum = [dic objectForKey:@"siteNum"];
                 item.bSelected = NO;
                 [group addObject:item];
             }
             
             //[self refreshData];
             //[tableView reloadData];
             if ([[responseJSONDictionary objectForKey:@"methods"] isEqualToString:@"FALSE"]) {
                 
                 bindNetworkPointAccountViewController *info = [[bindNetworkPointAccountViewController alloc] init];
                 info.groupBalance = group;
                 [self.navigationController pushViewController:info
                                                      animated:NO];
             }
             else{
//                 bindNetworkPointAccountViewController *info = [[bindNetworkPointAccountViewController alloc] init];
//                 info.groupBalance = group;
//                 [self.navigationController pushViewController:info
//                                                      animated:NO];
             }
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
