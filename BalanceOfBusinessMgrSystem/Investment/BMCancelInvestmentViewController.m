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
    self.navigation.title = @"取消预约";
    
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
    [label setFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 30, labelsize.width, labelsize.height)];
    label.text = s;
    [self.view addSubview:label];
    
    HP_UIImageView *bgImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20, MainHeight -350,MainWidth-40, 40)];
    [bgImageView setImage:[UIImage imageNamed:@"textlayer"]];
    [self.view addSubview:bgImageView];
    
    HP_UIImageView *passImage = [[HP_UIImageView alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    [passImage setImage:[UIImage imageNamed:@"密码照"]];
    [bgImageView addSubview:passImage];

    
    passWordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(30, 0, 140, 40)];
    [passWordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    passWordTextField.backgroundColor = [UIColor clearColor];
    passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passWordTextField.placeholder = @"请输入6位交易密码";
    passWordTextField.font = [UIFont systemFontOfSize:16];
    passWordTextField.delegate = self;
    passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
    passWordTextField.borderStyle = UITextBorderStyleNone;
    passWordTextField.secureTextEntry=NO;
    [bgImageView addSubview:passWordTextField];
    
    //确定
    HP_UIButton *forgetPassWordButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    [forgetPassWordButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
//    [forgetPassWordButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
//    [forgetPassWordButton setBackgroundColor:[UIColor blueColor]];
    [forgetPassWordButton setFrame:CGRectMake(MainWidth - 120,MainHeight -300, 2*50, 40)];
    [forgetPassWordButton addTarget:self action:@selector(touchForgetPassWordButton) forControlEvents:UIControlEventTouchUpInside];
    [forgetPassWordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPassWordButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    //cancelButton.enabled = false;
    [self.view addSubview:forgetPassWordButton];
    
    //确定
    HP_UIButton *cancelButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [cancelButton setBackgroundColor:[UIColor redColor]];
    [cancelButton setFrame:CGRectMake(40,MainHeight -200, MainWidth-2*40, 40)];
    [cancelButton addTarget:self action:@selector(touchCanceButton) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"确认取消" forState:UIControlStateNormal];
    [cancelButton.layer setMasksToBounds:YES];
    [cancelButton.layer setCornerRadius:cancelButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
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


-(void)touchForgetPassWordButton{
    
}


-(void)touchCanceButton{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, -120, MainWidth, MainHeight)];
    }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self touchesBegan:nil withEvent:nil];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==passWordTextField)
    {
        if (string.length > 0)
        {
            if ([string isEqualToString:@" "])
            {
                return NO;
            }
            return textField.text.length < 20;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [passWordTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    }];
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
