//
//  AdviseInfoViewController.m
//  BalanceOfBusinessMgrSystem_1.1.0
//
//  Created by huayq on 15/7/13.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "AdviseInfoViewController.h"
#import "PlaceholderTextView.h"

@interface AdviseInfoViewController ()<UITextViewDelegate>{
    PlaceholderTextView *view;
}

@end

@implementation AdviseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
     self.navigation.title = @"意见反馈";
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    // 字串
    NSString *s = @"您的意见对我们的产品来说十分重要，我们会认真收集并考虑改进产品的，十分感谢！";
    UIFont *font = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size = CGSizeMake(MainWidth - 20,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(10, NAVIGATION_OUTLET_HEIGHT + 10, MainWidth - 10, labelsize.height)];
    label.text = s;
    [self.view addSubview:label];
    
    view=[[PlaceholderTextView alloc] initWithFrame:CGRectMake(10, label.frame.origin.y + label.frame.size.height + 10, MainWidth - 10*2, 180)];
    view.placeholder=@"使用过程中的不便和意见请在此写出";
    view.delegate = self;
    view.font=[UIFont boldSystemFontOfSize:16];
    view.placeholderFont=[UIFont boldSystemFontOfSize:13];
    view.layer.borderWidth=0.5;
    view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:view];
    
    
    //确定
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor clearColor]];
    [registerButton setFrame:CGRectMake(20, view.frame.origin.y + view.frame.size.height + 50, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton setTitle:@"提 交" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f];
    
}

-(void)touchCommitButton{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    [view resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   [view resignFirstResponder];
    
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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