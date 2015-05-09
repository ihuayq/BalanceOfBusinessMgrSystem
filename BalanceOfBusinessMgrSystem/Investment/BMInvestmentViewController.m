//
//  BMInvestmentViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMInvestmentViewController.h"

@interface BMInvestmentViewController ()

@end

@implementation BMInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.navigaionBackColor =  [UIColor orangeColor];
    self.navigation.title = @"投资首页";
    
    
    //超额宝介绍
    self.manualProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 40, 120)];
    [self.manualProductWebView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [self.manualProductWebView.layer setBorderWidth:0.5f];
    [self.view addSubview:self.manualProductWebView];
    
    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"我要投资" ofType:@"html"];
    NSString *htmlString1= [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
    [self.manualProductWebView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
    
    
    //确定
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(40, self.manualProductWebView.frame.origin.y+ self.manualProductWebView.frame.size.height + 100, MainWidth-2*40, 40)];
    [registerButton addTarget:self action:@selector(touchDatingButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    NSString *strLabel = @"我要预约";
    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*40, 40)];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.backgroundColor = [UIColor clearColor];
    registerLabel.textColor = [UIColor whiteColor];
    registerLabel.font = [UIFont systemFontOfSize:15];
    
    //CGSize titleSize = [strLabel sizeWithFont:registerLabel.font constrainedToSize:CGSizeMake(MainWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    registerLabel.text = strLabel;
    [registerButton addSubview:registerLabel];
    
}

-(void)touchDatingButton{
    
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
