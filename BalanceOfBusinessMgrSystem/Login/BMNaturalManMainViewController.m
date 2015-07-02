//
//  BMNaturalManMainViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMNaturalManMainViewController.h"
#import "BMHomePageViewController.h"
#import "BMNaturalManAccountMainViewController.h"
#import "NavigationWithInteract.h"
#import "DXAlertView.h"
#import "settingNaturalManInfoViewController.h"

#import "BMAccountMainViewController.h"
#import "BMAssetsMainPageViewController.h"
#import "BMHomePageViewController.h"
#import "BMInvestmentViewController.h"

@interface BMNaturalManMainViewController (){

    
    //BMHomePageViewController *homePageVC;
    BMInvestmentViewController *investViewVC;
    BMAssetsMainPageViewController *earningVC;
    BMAccountMainViewController *accountVC;
}
@end

@implementation BMNaturalManMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self networkRequest];
}

-(void)networkRequest{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
//    NSString* string3des=[[[NSData alloc] init] encrypyConnectDes:passwordTextField.text];//3DES加密
//    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
//    [connDictionary setObject:encodedValue forKey:@"passwd_3des_encode"];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,MInfoURL];
    
    [self showMBProgressHUDWithMessage:@"加载中..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [self hidMBProgressHUD];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             NSMutableDictionary* Dict=[[NSMutableDictionary alloc] initWithCapacity:0];
             
             if ([responseJSONDictionary objectForKey:@"idCard"]) {
                 [Dict setObject:[responseJSONDictionary objectForKey:@"idCard"] forKey:@"identifyno"];
             }
             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             [Dict setObject:[responseJSONDictionary objectForKey:@"commercialName"] forKey:USER_NAME];

//           [Dict setObject:[responseJSONDictionary objectForKey:@"phonenum"] forKey:@"phoneNum"];
//           [Dict setObject:[responseJSONDictionary objectForKey:@"balanceCardNo"] forKey:@"balanceCardNo"];
//           [Dict setObject:[responseJSONDictionary objectForKey:@"accountBankname"] forKey:@"balanceCardBankName"];
//           [Dict setObject:[responseJSONDictionary objectForKey:@"recName"] forKey:@"balanceCardAccountName"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"personName"] forKey:@"personName"];
//           [Dict setObject:[responseJSONDictionary objectForKey:@"naturalMark"] forKey:@"naturalMark"];//是否第一次登录
             
             [Dict setObject:[responseJSONDictionary objectForKey:@"precipitationMarke"] forKey:@"appointment"];//是否设置沉淀
             [Dict setObject:[responseJSONDictionary objectForKey:@"addnpflag"] forKey:@"addNaturalMark"];//是否添加自然人标记,1代表添加，0不添加 methods = TRUE;
             [[NSUserDefaults standardUserDefaults] setObject:Dict forKey:USERINFO];
             
             //商户类型
             [[NSUserDefaults standardUserDefaults]setObject:[responseJSONDictionary objectForKey:@"methods"] forKey:@"methods"];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"balanceInfo"] forKey:@"balanceInfo"];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"payMark"] forKey:@"payMark"];//交易密码
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"rate"] forKey:@"rate"];
             
         }
//         //相同账号同时登陆，返回错误
//         else if([ret isEqualToString:reLoginOutFlag])
//         {
//             [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
//         }
         else
         {
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
         
         [self initUI];
         
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error,NSString * msg) {
         NSLog(@"error:%@",error.debugDescription);
         if (![request isCancelled])
         {
             [request cancel];
         }
         [self hidMBProgressHUD];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}


-(void)initUI{
    
    //homePageVC = [[BMHomePageViewController alloc] init];
    investViewVC = [[BMInvestmentViewController alloc] init];
    earningVC = [[BMAssetsMainPageViewController alloc] init];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"balanceInfo"];
    //NSLog(@"the balanceInfo is: %@",dic);
    
    TotalAssetInfoModel *asset = [[TotalAssetInfoModel alloc] init];
    asset.totalAssets   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalAmount"]];
    asset.oldProfit   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"yesterdayRevenue"]];
    asset.curPrincipal   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"inAmount"]];
    asset.curProfit   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"accruedIncome"]];
    asset.historyProfit   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"yesterdayNetAmount"]];
    asset.futurePrincipal   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"queueMoney"]];
    earningVC.assetInfo = asset;
    //NSLog(@"the asset is: %@",earningVC.assetInfo);
    
    accountVC = [[BMAccountMainViewController alloc] init];
    
    //NavigationWithInteract * nc1 = [[NavigationWithInteract alloc] initWithRootViewController:homePageVC];
    NavigationWithInteract * nc2 = [[NavigationWithInteract alloc] initWithRootViewController:investViewVC];
    NavigationWithInteract * nc3 = [[NavigationWithInteract alloc] initWithRootViewController:earningVC];
    NavigationWithInteract * nc4 = [[NavigationWithInteract alloc] initWithRootViewController:accountVC];
    
//    nc1.hidesBottomBarWhenPushed = YES;
//    nc2.hidesBottomBarWhenPushed = YES;
//    nc3.hidesBottomBarWhenPushed = YES;
//    nc4.hidesBottomBarWhenPushed = YES;
    
    self.viewControllers = [NSArray arrayWithObjects:nc2,nc3,nc4,nil];
    
    //nc1.tabBarItem.title = @"首页";
    nc2.tabBarItem.title = @"投资";
    nc3.tabBarItem.title = @"资产";
    nc4.tabBarItem.title = @"账号";
    
    
    //nc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"投资"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"资产"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc4.tabBarItem.selectedImage = [[UIImage imageNamed:@"账号"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //nc1.tabBarItem.image = [UIImage imageNamed:@"首页-normal"];
    nc2.tabBarItem.image = [UIImage imageNamed:@"投资-normal"];
    nc3.tabBarItem.image = [UIImage imageNamed:@"资产-normal"];
    nc4.tabBarItem.image = [UIImage imageNamed:@"账号-normal"];
    
    //self.tabBarController.selectedViewController = nc2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
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
