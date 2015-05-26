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
    self.navigation.title = @"成功";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    
    //账号提示
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 30*2, 60)];
    titleLabel.text = @"账户信息绑定成功 ，您现在可以使用此自然人账号登录设置投资理财相关操作！是否切换自然人账户登录？";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    
    //确定
    UIButton *switchButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [switchButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [switchButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [switchButton setBackgroundColor:[UIColor greenColor]];
    [switchButton setFrame:CGRectMake(40, MainHeight/2 , 80, 40)];
    [switchButton addTarget:self action:@selector(touchSwitchButton) forControlEvents:UIControlEventTouchUpInside];
    [switchButton setTitle:@"切换" forState:UIControlStateNormal];
    [switchButton.layer setMasksToBounds:YES];
    [switchButton.layer setCornerRadius:switchButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:switchButton];

    //继续添加自然人
    UIButton *addMoreButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [addMoreButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [addMoreButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [addMoreButton setBackgroundColor:[UIColor greenColor]];
    [addMoreButton setFrame:CGRectMake(switchButton.frame.origin.x + switchButton.frame.size.width + 20 , MainHeight/2 , 140, 40)];
    [addMoreButton addTarget:self action:@selector(touchAddMoreButton) forControlEvents:UIControlEventTouchUpInside];
    [addMoreButton setTitle:@"继续添加自然人" forState:UIControlStateNormal];
    [addMoreButton.layer setMasksToBounds:YES];
    [addMoreButton.layer setCornerRadius:addMoreButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:addMoreButton];
}

-(void)touchSwitchButton{
    LoginViewController*info = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:info
                                         animated:NO];
}

-(void)touchAddMoreButton{

    
    for (int i=0;i<[self.navigationController.viewControllers count] ; i++)
    {
        if([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[settingNaturalManInfoViewController class]])
        {
            settingNaturalManInfoViewController* info=[self.navigationController.viewControllers objectAtIndex:i];
//            [main changeCurrentTabViewController:main.myAccountButton];
            
//            settingNaturalManInfoViewController *info = [[settingNaturalManInfoViewController alloc] init];
            [self.navigationController popToViewController:info
                                                 animated:NO];
            
//            MyInformationViewController* MIVC=[[MyInformationViewController alloc]init];
//            [self.navigationController popToViewController:main animated:NO];
//            [main.navigationController pushViewController:MIVC animated:YES];
        }
    }
    
}

-(void)previousToViewController
{
    [self.navigationController popToRootViewControllerAnimated:NO];
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
