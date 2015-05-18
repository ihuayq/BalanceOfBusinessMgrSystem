//
//  BMainViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMCommercialTenantMainViewController.h"
#import "NavigationWithInteract.h"

#import "BMHomePageViewController.h"
#import "BMNaturalManAccountMainViewController.h"
#import "DXAlertView.h"
#import "settingNaturalManInfoViewController.h"


@interface BMCommercialTenantMainViewController (){
    BMHomePageViewController *homePageVC;
    BMNaturalManAccountMainViewController *accountPageNaturalManVC;
}
//@property(nonatomic,strong) BMHomePageViewController *homePageVC;
//@property(nonatomic,strong) BMInvestmentViewController *investViewVC;
//@property(nonatomic,strong) BMHomePageViewController *earningVC;
//@property(nonatomic,strong) BMAccountMainViewController *accountVC;
@end

@implementation BMCommercialTenantMainViewController

//@synthesize homePageVC;
//@synthesize investViewVC;
//@synthesize earningVC;
//@synthesize accountVC;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    homePageVC = [[BMHomePageViewController alloc] init];
    accountPageNaturalManVC = [[BMNaturalManAccountMainViewController alloc] init];
    
    NavigationWithInteract * nc1 = [[NavigationWithInteract alloc] initWithRootViewController:homePageVC];
    NavigationWithInteract * nc2 = [[NavigationWithInteract alloc] initWithRootViewController:accountPageNaturalManVC];
    
    
    nc1.hidesBottomBarWhenPushed = YES;
    nc2.hidesBottomBarWhenPushed = YES;
    
    
    self.viewControllers = [NSArray arrayWithObjects:nc1,nc2,nil];
    
    nc1.tabBarItem.title = @"首页";
    nc2.tabBarItem.title = @"账号";
    
    
    nc1.tabBarItem.image = [UIImage imageNamed:@"home_page"];
    nc2.tabBarItem.image = [UIImage imageNamed:@"account"];
    
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:@"addNaturalMark"]  isEqualToString:@"1"]) {
        //设置自然人
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您需要授权一个自然人后使用自然人账号登陆进行投资操作,是否现在授权自然人?" leftButtonTitle:@"是" rightButtonTitle:@"否"];
        [alert show];
        alert.leftBlock = ^() {
            NSLog(@"left button clicked");
            settingNaturalManInfoViewController *info = [[settingNaturalManInfoViewController alloc] init];
            [self.navigationController pushViewController:info
                                                 animated:NO];
        };
        alert.rightBlock = ^() {
            NSLog(@"right button clicked");
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
        };
    }

    
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
