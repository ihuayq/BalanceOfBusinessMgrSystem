//
//  BMEarningPageViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMEarningPageViewController.h"

@interface BMEarningPageViewController ()

@end

@implementation BMEarningPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.navigaionBackColor =  [UIColor orangeColor];
    self.navigation.title = @"我的资产";
    self.navigation.rightImage = [UIImage imageNamed:@"earnings.png"];
    
//    //超额宝介绍
//    self.manualProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 40, 120)];
//    [self.view addSubview:self.manualProductWebView];
//    
//    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"我要投资" ofType:@"html"];
//    NSString *htmlString1= [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
//    [self.manualProductWebView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
//    
//    // 相关产品介绍
//    self.referManulProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(20, self.manualProductWebView.frame.origin.y + self.manualProductWebView.frame.size.height + 20, MainWidth - 40, 120)];
//    [self.view addSubview:self.referManulProductWebView];
//    
//    NSString *filePath2 = [[NSBundle mainBundle]pathForResource:@"了解众信" ofType:@"html"];
//    NSString *htmlString2= [NSString stringWithContentsOfFile:filePath2 encoding:NSUTF8StringEncoding error:nil];
//    [self.referManulProductWebView loadHTMLString:htmlString2 baseURL:[NSURL URLWithString:filePath2]];
    
    
    
    //确定
    UIButton *avestButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [avestButton setBackgroundColor:[UIColor greenColor]];
    [avestButton setFrame:CGRectMake(MainWidth/2 + 40, MainHeight -48.5 - 100 , 80, 40)];
    [avestButton addTarget:self action:@selector(touchConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:avestButton];
    
    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.backgroundColor = [UIColor clearColor];
    registerLabel.text = @"我要投资";
    registerLabel.textColor = [UIColor whiteColor];
    registerLabel.font = [UIFont systemFontOfSize:15];
    [avestButton addSubview:registerLabel];
    
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
