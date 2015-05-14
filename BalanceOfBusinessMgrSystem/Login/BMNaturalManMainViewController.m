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

    
    BMHomePageViewController *homePageVC;
    BMInvestmentViewController *investViewVC;
    BMAssetsMainPageViewController *earningVC;
    BMAccountMainViewController *accountVC;
}
@end

@implementation BMNaturalManMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}


-(void)initUI{
    
    homePageVC = [[BMHomePageViewController alloc] init];
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
    
    NavigationWithInteract * nc1 = [[NavigationWithInteract alloc] initWithRootViewController:homePageVC];
    NavigationWithInteract * nc2 = [[NavigationWithInteract alloc] initWithRootViewController:investViewVC];
    NavigationWithInteract * nc3 = [[NavigationWithInteract alloc] initWithRootViewController:earningVC];
    NavigationWithInteract * nc4 = [[NavigationWithInteract alloc] initWithRootViewController:accountVC];
    
    nc1.hidesBottomBarWhenPushed = YES;
    nc2.hidesBottomBarWhenPushed = YES;
    nc3.hidesBottomBarWhenPushed = YES;
    nc4.hidesBottomBarWhenPushed = YES;
    
    self.viewControllers = [NSArray arrayWithObjects:nc1,nc2,nc3,nc4,nil];
    
    nc1.tabBarItem.title = @"首页";
    nc2.tabBarItem.title = @"投资";
    nc3.tabBarItem.title = @"收益";
    nc4.tabBarItem.title = @"账号";
    
    
    nc1.tabBarItem.image = [UIImage imageNamed:@"首页"];
    nc2.tabBarItem.image = [UIImage imageNamed:@"投资"];
    nc3.tabBarItem.image = [UIImage imageNamed:@"资产"];
    nc4.tabBarItem.image = [UIImage imageNamed:@"账号"];
    
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
