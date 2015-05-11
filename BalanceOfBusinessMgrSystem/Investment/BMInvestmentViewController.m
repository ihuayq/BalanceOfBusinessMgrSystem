//
//  BMInvestmentViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMInvestmentViewController.h"
#import "RadioButton.h"

@interface BMInvestmentViewController ()<UIAlertViewDelegate>{
    UIWebView *manualProductWebView;
    
    UIButton *registerButton;
    UILabel * registerLabel;
    RadioButton *radioAgreement;
    
    BOOL isHasAppointment;
    
    
}

@end

@implementation BMInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.navigaionBackColor =  [UIColor orangeColor];
    self.navigation.title = @"投资首页";
    
    
    //超额宝介绍
    manualProductWebView =[[UIWebView alloc] initWithFrame:CGRectMake(40, NAVIGATION_OUTLET_HEIGHT + 60, MainWidth - 40*2, 180)];
    [manualProductWebView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [manualProductWebView.layer setBorderWidth:0.5f];
    [self.view addSubview:manualProductWebView];
    
    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"我要投资" ofType:@"html"];
    NSString *htmlString1= [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
    [manualProductWebView loadHTMLString:htmlString1 baseURL:[NSURL URLWithString:filePath1]];
    
    radioAgreement=[[RadioButton alloc] initWithFrame:CGRectMake(40, manualProductWebView.frame.origin.y+manualProductWebView.frame.size.height+20, 200, 20) typeCheck:NO];
    [radioAgreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [radioAgreement setTitle:@"已阅读并同意自然人投资协议" forState:UIControlStateNormal];
    radioAgreement.titleLabel.font=[UIFont systemFontOfSize:12];
    radioAgreement.delegate=self;
    radioAgreement.tag=707;
    [self.view addSubview:radioAgreement];
    
    
    //确定
    registerButton = [HP_UIButton buttonWithType:UIButtonTypeRoundedRect];
//  [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
//  [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setBackgroundColor:[UIColor redColor]];
    [registerButton setFrame:CGRectMake(40,radioAgreement.frame.origin.y+ radioAgreement.frame.size.height + 40, MainWidth-2*40, 40)];
    [registerButton addTarget:self action:@selector(touchDatingButton) forControlEvents:UIControlEventTouchUpInside];
    registerButton.enabled = false;
    [registerButton setTitle:@"预约购买" forState:UIControlStateNormal];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:registerButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [registerButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [registerButton.layer setBorderColor:colorref];//边框颜色
    
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    [registerButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
//    [registerButton.titleLabel setTextColor:[UIColor whiteColor]];
    
//    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    [self.view addSubview:registerButton];
    
//    NSString *strLabel = @"预约购买";
//    registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth-2*40, 40)];
//    registerLabel.textAlignment = NSTextAlignmentCenter;
//    registerLabel.backgroundColor = [UIColor clearColor];
//    registerLabel.textColor = [UIColor whiteColor];
//    registerLabel.font = [UIFont systemFontOfSize:15];
//
//    
//    //CGSize titleSize = [strLabel sizeWithFont:registerLabel.font constrainedToSize:CGSizeMake(MainWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
//    registerLabel.text = strLabel;
//    [registerButton addSubview:registerLabel];
    
}


// 在这里处理UIAlertView中的按钮被单击的事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex is : %i",(int)buttonIndex);
    switch (buttonIndex) {
        case 0:{
            radioAgreement.hidden = true;
            [registerButton setTitle:@"取消预约" forState:UIControlStateNormal];
        }break;
        default:
            break;
    }
}


- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect{
    
    if (radiobutton.tag == 707) {
        NSLog(@"btn is selected:%d",boolchange);
        if (boolchange == true) {
            registerButton.enabled = true;
        }
        else{
            registerButton.enabled = false;
            
        }
    }
    
}

-(void)touchDatingButton{
    

    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功，成功投资金额可能需要一定时间才能显示，谢谢您的使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];

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
