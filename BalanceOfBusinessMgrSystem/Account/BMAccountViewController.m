//
//  BMAccountViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMAccountViewController.h"

@interface BMAccountViewController ()

@end

@implementation BMAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.navigaionBackColor =  [UIColor orangeColor];
    self.navigation.title = @"账号";
    
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
