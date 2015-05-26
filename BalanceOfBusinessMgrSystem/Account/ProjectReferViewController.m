//
//  ProjectReferViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/26.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ProjectReferViewController.h"

@interface ProjectReferViewController ()

@end

@implementation ProjectReferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigation.title = @"关于超额宝";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    // Do any additional setup after loading the view.
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/2 - 80,MainHeight/2 - 20,  80*2, 40)];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    
    passwordLabel.text = [NSString stringWithFormat:@"版本号：%@",version];
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    passwordLabel.font = [UIFont systemFontOfSize:24];
    passwordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:passwordLabel];
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
