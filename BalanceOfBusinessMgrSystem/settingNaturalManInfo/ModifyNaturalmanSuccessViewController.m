//
//  ModifyNaturalmanSuccessViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/18.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ModifyNaturalmanSuccessViewController.h"
#import "LoginViewController.h"

@interface ModifyNaturalmanSuccessViewController ()

@end

@implementation ModifyNaturalmanSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.navigation.title = @"成功";
    //self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    
    //账号提示
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 30*2, 60)];
    titleLabel.text = @"自然人信息修改成功，是否现在去进行投资理财";
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
    [switchButton setTitle:@"是" forState:UIControlStateNormal];
    [switchButton.layer setMasksToBounds:YES];
    [switchButton.layer setCornerRadius:switchButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:switchButton];
    
    //继续添加自然人
    UIButton *addMoreButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [addMoreButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [addMoreButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [addMoreButton setBackgroundColor:[UIColor greenColor]];
    [addMoreButton setFrame:CGRectMake(switchButton.frame.origin.x + switchButton.frame.size.width + 20 , MainHeight/2 , 80, 40)];
    [addMoreButton addTarget:self action:@selector(touchExitButton) forControlEvents:UIControlEventTouchUpInside];
    [addMoreButton setTitle:@"否" forState:UIControlStateNormal];
    [addMoreButton.layer setMasksToBounds:YES];
    [addMoreButton.layer setCornerRadius:addMoreButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:addMoreButton];
}

-(void)touchSwitchButton{
    LoginViewController*info = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:info
                                         animated:NO];
}

-(void)touchExitButton{
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
