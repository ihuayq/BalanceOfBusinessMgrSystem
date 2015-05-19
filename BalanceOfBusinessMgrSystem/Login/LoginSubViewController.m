//
//  LoginSubViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/18.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "LoginSubViewController.h"

@interface LoginSubViewController ()

@end

@implementation LoginSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    HP_UIImageView *headImage = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 + 50, MainHeight-280,MainWidth-120, 40)];
//    [headImage setImage:[UIImage imageNamed:@"textlayer"]];
//    [self.view addSubview:headImage];
//    
//    HP_UIImageView *nameImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(30, MainHeight-280, 40, 40)];
//    [nameImageView setImage:[UIImage imageNamed:@"大头照"]];
//    [bgView addSubview:nameImageView];
//    
//    //    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, MainHeight-260, 50, 40)];
//    //    nameLabel.text = @"用户名:";
//    //    nameLabel.textAlignment = NSTextAlignmentLeft;
//    //    nameLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    //    nameLabel.font = [UIFont systemFontOfSize:14];
//    //    nameLabel.backgroundColor = [UIColor clearColor];
//    //    [bgView addSubview:nameLabel];
//    
//    
//    nameTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(90, MainHeight-280, 210, 40)];
//    nameTextField.borderStyle = UITextBorderStyleNone;
//    [nameTextField setInsets:UIEdgeInsetsMake(25, 5, 0, 0)];
//    nameTextField.backgroundColor = [UIColor clearColor];
//    nameTextField.clearButtonMode = UITextFieldViewModeAlways;
//    nameTextField.placeholder = @"请输入用户账号";
//    nameTextField.font = [UIFont systemFontOfSize:14];
//    nameTextField.delegate = self;
//    nameTextField.keyboardType = UIKeyboardTypeDefault;
//    [self.view addSubview:nameTextField];
//    
//    HP_UIImageView *passwordImageView = [[HP_UIImageView alloc] initWithFrame:CGRectMake(20 + 50, MainHeight-220,MainWidth-120, 40)];
//    [passwordImageView setImage:[UIImage imageNamed:@"textlayer"]];
//    [bgView addSubview:passwordImageView];
//    
//    //    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, MainHeight-210, 70, 40)];
//    //    passwordLabel.text = @"密码:";
//    //    passwordLabel.textAlignment = NSTextAlignmentLeft;
//    //    passwordLabel.textColor =[HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    //    passwordLabel.font = [UIFont systemFontOfSize:14];
//    //    passwordLabel.backgroundColor = [UIColor clearColor];
//    //    [bgView addSubview:passwordLabel];
//    HP_UIImageView *passImage = [[HP_UIImageView alloc] initWithFrame:CGRectMake(30, MainHeight-220, 40, 40)];
//    [passImage setImage:[UIImage imageNamed:@"密码照"]];
//    [bgView addSubview:passImage];
//    
//    passwordTextField = [[HP_UITextField alloc] initWithFrame:CGRectMake(90, MainHeight-220, 210, 40)];
//    passwordTextField.borderStyle = UITextBorderStyleNone;
//    //[passwordTextField setInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
//    passwordTextField.backgroundColor = [UIColor clearColor];
//    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
//    passwordTextField.placeholder = @"请输入密码";
//    passwordTextField.font = [UIFont systemFontOfSize:14];
//    passwordTextField.delegate = self;
//    passwordTextField.keyboardType = UIKeyboardTypeDefault;
//    passwordTextField.secureTextEntry=YES;
//    [bgView addSubview:passwordTextField];
//    
//    //    UIButton * keepPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    keepPsdBtn.frame = CGRectMake(MainWidth - 85 - 20, MainHeight-165, 85, 15);
//    //    [keepPsdBtn setBackgroundImage:[UIImage imageNamed:@"forgetpassword"] forState:UIControlStateNormal];
//    //    keepPsdBtn.backgroundColor = [UIColor clearColor];
//    //    [keepPsdBtn addTarget:self action:@selector(touchForgetButton) forControlEvents:UIControlEventTouchUpInside];
//    //    [bgView addSubview:keepPsdBtn];
//    
//    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
//    [checkbox setFrame:CGRectMake(40, MainHeight-165, 15, 15)];
//    [checkbox setImage:[UIImage imageNamed:@"n.png"] forState:UIControlStateNormal];
//    [checkbox setImage:[UIImage imageNamed:@"y.png"] forState:UIControlStateSelected];
//    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:checkbox];
//    
//    UILabel * rememberPassword = [[UILabel alloc] initWithFrame:CGRectMake(60, MainHeight-178, 75, 40)];
//    rememberPassword.text = @"记住密码";
//    rememberPassword.textAlignment = NSTextAlignmentLeft;
//    rememberPassword.textColor =[HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    rememberPassword.font = [UIFont systemFontOfSize:14];
//    rememberPassword.backgroundColor = [UIColor clearColor];
//    [bgView addSubview:rememberPassword];
//    
//    
//    _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _forgetButton.frame = CGRectMake(MainWidth - 85 - 40, MainHeight-165, 85, 15);
//    [_forgetButton setBackgroundImage:[UIImage imageNamed:@"forgetpassword"] forState:UIControlStateNormal];
//    _forgetButton.backgroundColor = [UIColor clearColor];
//    [_forgetButton addTarget:self action:@selector(touchForgetButton) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:_forgetButton];
//    _forgetButton.hidden = YES;
//    
//    
//    UIButton *loginButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
//    [loginButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
//    [loginButton setBackgroundColor:[UIColor clearColor]];
//    [loginButton setFrame:CGRectMake(60, MainHeight-140, MainWidth-120, 40)];
//    [loginButton addTarget:self action:@selector(touchLoginButton) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:loginButton];
//    
//    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-120, 40)];
//    loginLabel.textAlignment = NSTextAlignmentCenter;
//    loginLabel.backgroundColor = [UIColor clearColor];
//    loginLabel.text = @"登 录";
//    loginLabel.textColor = [UIColor whiteColor];
//    loginLabel.font = [UIFont systemFontOfSize:15];
//    [loginButton addSubview:loginLabel];
    
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
