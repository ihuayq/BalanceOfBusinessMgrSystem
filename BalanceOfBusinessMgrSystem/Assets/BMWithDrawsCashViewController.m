//
//  BMWithDrawsCashViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/12.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMWithDrawsCashViewController.h"
#import "BMWithDrawsCashSuccessViewController.h"


@interface BMWithDrawsCashViewController (){
    HP_UITextField *nameTextField;
    HP_UITextField *passwordTextField;
}

@end

@implementation BMWithDrawsCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"提现";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    UILabel * canDrawCashLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 ,NAVIGATION_OUTLET_HEIGHT + 10, 200,20)];
    canDrawCashLabel.textAlignment = NSTextAlignmentCenter;
    canDrawCashLabel.text = @"可提现金额（元）";
    canDrawCashLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:canDrawCashLabel];
    
    UILabel * canDrawCashNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth - 220 ,NAVIGATION_OUTLET_HEIGHT + 50, 200,20)];
    canDrawCashNumberLabel.textAlignment = NSTextAlignmentCenter;
    canDrawCashNumberLabel.text = @"1800.000";
    canDrawCashNumberLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:canDrawCashNumberLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,canDrawCashNumberLabel.frame.size.height + canDrawCashNumberLabel.frame.origin.y+ 5 , MainWidth,1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    
    UILabel * realDrawCashLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 ,line.frame.size.height + line.frame.origin.y+ 20, 160,20)];
    realDrawCashLabel.textAlignment = NSTextAlignmentCenter;
    realDrawCashLabel.text = @"提现金额（元）";
    realDrawCashLabel.font = [UIFont systemFontOfSize:18];
    //registerLabel.frame = CGRectMake(MainWidth/2 - registerLabel.frame.size.width/2, MainHeight/2 - registerLabel.frame.size.height/2, registerLabel.frame.size.width, registerLabel.frame.size.height);
    [self.view addSubview:realDrawCashLabel];
    
    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(20, realDrawCashLabel.frame.size.height + realDrawCashLabel.frame.origin.y + 5, MainWidth - 20*2, 40)];
    nameTextField.borderStyle = UITextBorderStyleLine;
    [nameTextField setInsets:UIEdgeInsetsMake(25, 5, 0, 0)];
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    nameTextField.placeholder = @"点击输入金额";
    nameTextField.font = [UIFont systemFontOfSize:14];
    nameTextField.delegate = self;
    nameTextField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:nameTextField];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0,nameTextField.frame.size.height + nameTextField.frame.origin.y + 5, MainWidth,1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    UILabel * CardLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 ,line2.frame.size.height + line2.frame.origin.y + 5, 140,20)];
    CardLabel.textAlignment = NSTextAlignmentCenter;
    CardLabel.text = @"提现银行卡号：";
    CardLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:CardLabel];
    
    UILabel * CardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CardLabel.frame.origin.x + CardLabel.frame.size.width ,line2.frame.size.height + line2.frame.origin.y + 5, 180,20)];
    CardNumLabel.textAlignment = NSTextAlignmentLeft;
    CardNumLabel.text = @"3408812345";
    CardNumLabel.font = [UIFont systemFontOfSize:18];
    //registerLabel.frame = CGRectMake(MainWidth/2 - registerLabel.frame.size.width/2, MainHeight/2 - registerLabel.frame.size.height/2, registerLabel.frame.size.width, registerLabel.frame.size.height);
    [self.view addSubview:CardNumLabel];
    
    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(20, CardNumLabel.frame.size.height + CardNumLabel.frame.origin.y + 20,   MainWidth - 20*2, 40)];
    passwordTextField.borderStyle = UITextBorderStyleLine;
    [passwordTextField setInsets:UIEdgeInsetsMake(25, 5, 0, 0)];
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:passwordTextField];
    
    
    //确定
    HP_UIButton *okButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [okButton setBackgroundColor:[UIColor redColor]];
    [okButton setFrame:CGRectMake(40,MainHeight -200, MainWidth-2*40, 40)];
    [okButton addTarget:self action:@selector(touchOkButton) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitle:@"确认" forState:UIControlStateNormal];
    [okButton.layer setMasksToBounds:YES];
    [okButton.layer setCornerRadius:okButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
    //cancelButton.enabled = false;
    [self.view addSubview:okButton];
    

    
    
}

-(void)touchOkButton{
    BMWithDrawsCashSuccessViewController *vc = [[BMWithDrawsCashSuccessViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    if (textField==nameTextField)
    {
        if (string.length > 0)
        {
            
            return textField.text.length < 20;
        }
    }
   
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
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
