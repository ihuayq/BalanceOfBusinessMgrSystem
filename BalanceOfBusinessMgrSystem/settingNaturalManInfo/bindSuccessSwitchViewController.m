//
//  bindSuccessSwitchViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "bindSuccessSwitchViewController.h"
#import "settingNaturalManInfoViewController.h"

@interface bindSuccessSwitchViewController ()

@end

@implementation bindSuccessSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
    self.navigation.title = @"成功";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    
    //账号提示
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 30*2, 60)];
    titleLabel.text = @"账户信息绑定成功 ，您现在可以使用此自然人账号登陆设置投资理财相关操作！是否切换自然人账户登录？";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    
    //确定
    UIButton *switchButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [switchButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [switchButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [switchButton setBackgroundColor:[UIColor greenColor]];
    [switchButton setFrame:CGRectMake(80, MainHeight -48.5 - 100 , 80, 40)];
    [switchButton addTarget:self action:@selector(touchSwitchButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchButton];
    
    UILabel * switchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,80, 40)];
    switchLabel.textAlignment = NSTextAlignmentCenter;
    switchLabel.backgroundColor = [UIColor clearColor];
    switchLabel.text = @"切换";
    switchLabel.textColor = [UIColor whiteColor];
    switchLabel.font = [UIFont systemFontOfSize:15];
    [switchButton addSubview:switchLabel];

    
    //继续添加自然人
    UIButton *addMoreButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [addMoreButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [addMoreButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [addMoreButton setBackgroundColor:[UIColor greenColor]];
    [addMoreButton setFrame:CGRectMake(switchButton.frame.origin.x + switchButton.frame.size.width + 20 , MainHeight -48.5 - 100 , 100, 40)];
    [addMoreButton addTarget:self action:@selector(touchAddMoreButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addMoreButton];
    
    UILabel * addMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,100, 40)];
    addMoreLabel.textAlignment = NSTextAlignmentCenter;
    addMoreLabel.backgroundColor = [UIColor clearColor];
    addMoreLabel.text = @"继续添加自然人";
    addMoreLabel.textColor = [UIColor whiteColor];
    addMoreLabel.font = [UIFont systemFontOfSize:15];
    [addMoreButton addSubview:addMoreLabel];
}

-(void)touchSwitchButton{
    LoginViewController*info = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:info
                                         animated:NO];
}

-(void)touchAddMoreButton{
    settingNaturalManInfoViewController *info = [[settingNaturalManInfoViewController alloc] init];
    [self.navigationController pushViewController:info
                                         animated:NO];
}

-(void)previousToViewController
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    //CenterMainViewController *parentCurViewController =  (CenterMainViewController*)self.navigationController.parentViewController ;

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
