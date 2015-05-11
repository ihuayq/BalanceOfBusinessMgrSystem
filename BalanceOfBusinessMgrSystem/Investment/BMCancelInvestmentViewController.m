//
//  BMCancelInvestmentViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMCancelInvestmentViewController.h"

@interface BMCancelInvestmentViewController ()
{
    HP_UITextField* passWordTextField;
}
@end

@implementation BMCancelInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 40,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    //label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s = @"取消预约后，资金将通过正常的结算方式打款至您的结算账户，不在进入理财队列，请知悉！";
    UIFont *font = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size = CGSizeMake(300,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 100, labelsize.width, labelsize.height)];
    label.text = s;
    [self.view addSubview:label];
    
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 90,MainWidth-40, 40)];
    [bgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView];
    
    HP_UIImageView *passImage = [[HP_UIImageView alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    [passImage setImage:[UIImage imageNamed:@"密码照"]];
    [bgImageView addSubview:passImage];

    
    passWordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(90, 30, 110, 40)];
    [passWordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passWordTextField.backgroundColor = [UIColor clearColor];
    passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passWordTextField.placeholder = @"请输入6位交易密码";
    passWordTextField.font = [UIFont systemFontOfSize:14];
    passWordTextField.delegate = self;
    passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
    passWordTextField.borderStyle = UITextBorderStyleNone;
    passWordTextField.secureTextEntry=NO;
    [bgImageView addSubview:passWordTextField];
    
    //确定
    HP_UIButton *cancelButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [cancelButton setBackgroundColor:[UIColor redColor]];
    [cancelButton setFrame:CGRectMake(40,MainHeight -200, MainWidth-2*40, 40)];
    [cancelButton addTarget:self action:@selector(touchCanceButton) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"确认取消" forState:UIControlStateNormal];
    //cancelButton.enabled = false;
    [self.view addSubview:cancelButton];
    
//    NSString *strLabel = @"预约购买";
//    registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*40, 40)];
//    registerLabel.textAlignment = NSTextAlignmentCenter;
//    registerLabel.backgroundColor = [UIColor clearColor];
//    registerLabel.textColor = [UIColor whiteColor];
//    registerLabel.font = [UIFont systemFontOfSize:15];
    
    
    //CGSize titleSize = [strLabel sizeWithFont:registerLabel.font constrainedToSize:CGSizeMake(MainWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    
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
