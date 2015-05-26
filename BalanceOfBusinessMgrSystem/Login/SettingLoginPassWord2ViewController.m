//
//  SettingLoginPassWordView2ControllerViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/6.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "SettingLoginPassWord2ViewController.h"
#import "BMNaturalManMainViewController.h"

@interface SettingLoginPassWord2ViewController ()

@end

@implementation SettingLoginPassWord2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"设置登录密码";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    //设置标题
//    UILabel * notePsdLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10, 240, 40)];
//    notePsdLabel.text = @"登录密码设置成功，下次登录请使用新密码，点击确认返回主页";
//    notePsdLabel.textAlignment = NSTextAlignmentCenter;
//    notePsdLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    notePsdLabel.font = [UIFont systemFontOfSize:18];
//    notePsdLabel.backgroundColor = [UIColor clearColor];
//    notePsdLabel.numberOfLines = 0;
//    [self.view addSubview:notePsdLabel];
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    //label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s = @"登录密码设置成功，下次登录请使用新密码，点击确认返回主页";
    UIFont *font = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size = CGSizeMake(300,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 100, labelsize.width, labelsize.height)];
    label.text = s;
    [self.view addSubview:label];
    
    
//    //确定
//    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
//    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
//    [registerButton setBackgroundColor:[UIColor clearColor]];
//    [registerButton setFrame:CGRectMake(40, 400, MainWidth/2 - 2*40, 40)];
//    [registerButton addTarget:self action:@selector(touchConfirmButton) forControlEvents:UIControlEventTouchUpInside];
//    [registerButton setTitle:@"确定" forState:UIControlStateNormal];
//    [self.view addSubview:registerButton];
//    
//    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth/2 - 2*40, 40)];
//    registerLabel.textAlignment = NSTextAlignmentCenter;
//    registerLabel.backgroundColor = [UIColor clearColor];
//    registerLabel.text = @"确认";
//    registerLabel.textColor = [UIColor whiteColor];
//    registerLabel.font = [UIFont systemFontOfSize:15];
//    [registerButton addSubview:registerLabel];
    
    //确定
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(40, NAVIGATION_OUTLET_HEIGHT + 300, MainWidth-2*40, 40)];
    [registerButton addTarget:self action:@selector(touchConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"确定" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
    [self.view addSubview:registerButton];
}


-(void) touchConfirmButton{
//    BMNaturalManMainViewController * manVC=[[BMNaturalManMainViewController alloc]init];
//    [self.navigationController pushViewController:manVC animated:NO];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"login", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
