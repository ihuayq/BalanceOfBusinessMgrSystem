//
//  BMCancelInvestmentBeforeViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/6/1.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMCancelInvestmentBeforeViewController.h"
#import "BMCancelInvestmentViewController.h"
#import "BTLabel.h"
@interface BMCancelInvestmentBeforeViewController ()

@end

@implementation BMCancelInvestmentBeforeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
    self.navigation.title = @"取消预约";
    //self.navigation.leftImage = [UIImage imageNamed:@"back_icon"];
    
    HP_UIImageView *noticeImg = [[HP_UIImageView alloc] initWithFrame:CGRectMake(MainWidth/2-15, NAVIGATION_OUTLET_HEIGHT + 16,30, 30)];
    [noticeImg setImage:[UIImage imageNamed:@"成功"]];
    [self.view addSubview:noticeImg];
    
//    //初始化label
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 60,0,0)];
//    //设置自动行数与字符换行
//    [label setNumberOfLines:0];
//    //label.lineBreakMode = UILineBreakModeWordWrap;
//    // 测试字串
//    NSString *s = @"预约成功，结算款将在下一个结算日开始转入理财账户，入账金额成功投资后产生收益!";
//    UIFont *font = [UIFont systemFontOfSize:18];
//    //设置一个行高上限
//    CGSize size = CGSizeMake(300,400);
//    //计算实际frame大小，并将label的frame变成实际大小
//    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
//    [label setFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 60, labelsize.width, labelsize.height)];
//    label.text = s;
//    [self.view addSubview:label];

    BTLabel *label;
    
    CGFloat fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? 13 : 8;
    UIFont *font = [UIFont systemFontOfSize:18];
    CGColorRef color = [UIColor colorWithHue:0 saturation:0 brightness:0.8 alpha:1].CGColor;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:28],
                                 NSForegroundColorAttributeName: [UIColor orangeColor]
                                 };

    label = [[BTLabel alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 60,MainWidth - 20*2,120) edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    label.font = font;
    label.text = [NSString stringWithFormat:@"预约成功，结算款将在下一个结算日开始转入理财账户，入账金额成功投资后产生收益!"];
    label.verticalAlignment = BTVerticalAlignmentCenter;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 3;
//    label.layer.borderWidth = 1;
//    label.layer.borderColor = color;
    [self.view addSubview:label];
    
    
    //初始化label
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    //设置自动行数与字符换行
    [label2 setNumberOfLines:0];
    //label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s2 = @"年化收益率  8%";
    UIFont *font2 = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size2 = CGSizeMake(300,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize2 = [s2 sizeWithFont:font constrainedToSize:size2 lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label2 setFrame:CGRectMake(MainWidth/2 - labelsize2.width/2, NAVIGATION_OUTLET_HEIGHT + 240, labelsize2.width, labelsize2.height)];
    label2.text = s2;
    label2.textAlignment = UITextAlignmentCenter;

    [self.view addSubview:label2];
    
    
    HP_UIButton *cancelInvestBtn=[[HP_UIButton alloc] initWithFrame:CGRectMake(MainWidth - 100 ,MainHeight - 48.5 - 44 - 30,60,30)];
    [cancelInvestBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [cancelInvestBtn addTarget:self action:@selector(touchCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [cancelInvestBtn setTitle:@"取消预约" forState:UIControlStateNormal];
    cancelInvestBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:cancelInvestBtn];
}

-(void)touchCancelButton{
    NSLog(@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"appointment"]);
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"appointment"] isEqualToString:@"1"]) {
        BMCancelInvestmentViewController *cancelVC = [[BMCancelInvestmentViewController alloc] init];
        cancelVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cancelVC animated:YES];
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
