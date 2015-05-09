//
//  ISZhiFuTongSetPayMoneyPassWordViewController.m
//  AllBelieve
//
//  Created by 融通互动 on 14-5-23.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import "ISZhiFuTongSetPayMoneyPassWordViewController.h"
#import "AppConfigure.h"

@interface ISZhiFuTongSetPayMoneyPassWordViewController ()

@end

@implementation ISZhiFuTongSetPayMoneyPassWordViewController
@synthesize transmitDict;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        transmitDict=[[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    [self initUI];
    
}

-(void) initUI
{
    //[self.view setBackgroundColor:[HP_UIColorUtils colorWithHexString:BG_COLOR]];
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_bg"] forBarMetrics:UIBarMetricsDefault];
    //[self.view setBackgroundColor:[UIColor blackColor]];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    [bgView setBackgroundColor:[HP_UIColorUtils colorWithHexString:BG_COLOR]];
    [self.view addSubview:bgView];
    
    
    HP_UIImageView *backgroundImageView = [[HP_UIImageView alloc] init];
    [backgroundImageView  setFrame:CGRectMake(0, 0,MainWidth, MainHeight)];
    [backgroundImageView setImage:[UIImage imageNamed:@""]];
    [bgView addSubview:backgroundImageView];
    
    
    HP_UIView *topBarView = [[HP_UIView alloc] init];
    [topBarView setFrame:CGRectMake(0, 0, MainWidth, 64)];
    [topBarView setBackgroundColor:[HP_UIColorUtils colorWithHexString:TOPBAR_COLOR]];
    //topBarView.layer.shadowColor = [[UIColor blackColor] CGColor];
    //topBarView.layer.shadowOpacity = .5;
    //topBarView.layer.shadowOffset = CGSizeMake(0,3);
    [bgView addSubview:topBarView];
    
    
    
    UILabel *topBarTextLable = [[UILabel alloc] initWithFrame:CGRectMake((MainWidth-200)/2, 20, 200, 40)];
    topBarTextLable.text = @"注册";
    topBarTextLable.textAlignment = NSTextAlignmentCenter;
    topBarTextLable.backgroundColor = [UIColor clearColor];
    topBarTextLable.textColor = [UIColor whiteColor];
    topBarTextLable.font = [UIFont systemFontOfSize:18];
    //   topBarTextLable.font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    //topBarTextLable.shadowOffset=CGSizeMake(1, 1);
    //topBarTextLable.shadowColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    [topBarView addSubview:topBarTextLable];
    
    
//    HP_UIButton *backButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setFrame:CGRectMake(0, 17, 45, 44)];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_normal"] forState:UIControlStateNormal];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_highlight"] forState:UIControlStateHighlighted];
//    [backButton addTarget:self action:@selector(goToBackView) forControlEvents:UIControlEventTouchUpInside];
//    [topBarView addSubview:backButton];
    
    
    
    HP_UIImageView *bigOkImageView = [[HP_UIImageView alloc] init];
    [bigOkImageView  setFrame:CGRectMake(30, 100,42, 42)];
    [bigOkImageView setImage:[UIImage imageNamed:@"bigok"]];
    [bgView addSubview:bigOkImageView];
    
    
    UILabel * okLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 120, 30)];
    okLabel.text = @"注册成功!";
    okLabel.textAlignment = NSTextAlignmentLeft;
    okLabel.textColor = [HP_UIColorUtils colorWithHexString:@"000000"];
    okLabel.font = [UIFont systemFontOfSize:20];
    okLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:okLabel];
    
    UILabel * okLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 125, 230, 30)];
    okLabel2.text = @"恭喜您开启众信金融投资之旅!";
    okLabel2.textAlignment = NSTextAlignmentLeft;
    okLabel2.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR2];
    okLabel2.font = [UIFont systemFontOfSize:14];
    okLabel2.backgroundColor = [UIColor clearColor];
    [bgView addSubview:okLabel2];
    
    
    
    UILabel * tishiLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, MainWidth-40, 40)];
    tishiLable.text =[NSString stringWithFormat:@"众信金融手机端账户支付密码与支付通账户支付密码相同"];
    tishiLable.textAlignment = NSTextAlignmentLeft;
    tishiLable.textColor = [HP_UIColorUtils colorWithHexString:TOPBAR_COLOR];
    tishiLable.font = [UIFont systemFontOfSize:15];
    tishiLable.backgroundColor = [UIColor clearColor];
    tishiLable.numberOfLines=0;
    [bgView addSubview:tishiLable];
    
    
    
    UIButton *registerButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [registerButton setFrame:CGRectMake(20, 240, MainWidth-2*20, 40)];
    [registerButton addTarget:self action:@selector(touchInvestmentButton) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"立刻投资" forState:UIControlStateNormal];
    registerButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [bgView addSubview:registerButton];
    
    
    
    
    UIButton *changeButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [changeButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [changeButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [changeButton setFrame:CGRectMake(20, 280, 90, 30)];
    [changeButton addTarget:self action:@selector(touchChangePayWordButton) forControlEvents:UIControlEventTouchUpInside];
    [changeButton.titleLabel setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:changeButton];
    
    HP_UILabel * registerLabel = [[HP_UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.backgroundColor = [UIColor clearColor];
    registerLabel.text = @"修改支付密码";
    registerLabel.textColor = [HP_UIColorUtils colorWithHexString:Qianlan];
    registerLabel.font = [UIFont systemFontOfSize:15];
    [changeButton addSubview:registerLabel];
 
    UIView* lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 22, 90, 1)];
    [lineView setBackgroundColor:[HP_UIColorUtils colorWithHexString:Qianlan]];
    [changeButton addSubview:lineView];
    
    
    
    UIButton *forgetButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.backgroundColor=[UIColor clearColor];
    [forgetButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [forgetButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [forgetButton setFrame:CGRectMake(MainWidth-20-90, 280, 90, 30)];
    [forgetButton addTarget:self action:@selector(touchForgetPaywordButton) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:forgetButton];
    
    HP_UILabel * registerLabel2 = [[HP_UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    registerLabel2.textAlignment = NSTextAlignmentCenter;
    registerLabel2.backgroundColor = [UIColor clearColor];
    registerLabel2.text = @"忘记支付密码";
    registerLabel2.textColor = [HP_UIColorUtils colorWithHexString:Qianlan];
    registerLabel2.font = [UIFont systemFontOfSize:15];
    [forgetButton addSubview:registerLabel2];
    
    UIView* lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, 22, 90, 1)];
    [lineView2 setBackgroundColor:[HP_UIColorUtils colorWithHexString:Qianlan]];
    [forgetButton addSubview:lineView2];
    
}
-(void)touchInvestmentButton
{
//    //注册页 已经保存用户数据和登录各种数据
//    MainViewController * mainview=[[MainViewController alloc]init];
//    [self.navigationController pushViewController:mainview animated:NO];
    
}
-(void)touchChangePayWordButton
{
    
    
//    ChangePayMoneyPasswordViewController *CPMPVC=[[ChangePayMoneyPasswordViewController alloc]init];
//    CPMPVC.type=1;//0 为默认  1为支付通账户注册完跳转
//    [self.navigationController pushViewController:CPMPVC animated:YES];
    
}
-(void)touchForgetPaywordButton
{
   
    
//    ForgetPayPasswordViewController * fpw = [[ForgetPayPasswordViewController alloc] init];
//    fpw.type=1;//0 为默认  1为支付通账户注册完跳转
//    [self.navigationController pushViewController:fpw animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
