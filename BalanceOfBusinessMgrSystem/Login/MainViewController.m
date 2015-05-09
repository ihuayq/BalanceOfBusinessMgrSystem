//
//  MainViewController.m
//  jxtuan
//
//  Created by 融通互动 on 13-8-21.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "MainViewController.h"
#import "ControllerConfig.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.navigaionBackColor =  [UIColor orangeColor];
    self.navigation.title = @"首页";
}

@end
//@interface MainViewController ()
//{
//
//    InvestmentProjectViewController * investmentVC;
//    MyAccountViewController * myAccountVC;
//    MoreThingViewController * moreThingVC;
//    
//}
//@end
//
//@implementation MainViewController
//@synthesize transferDict;
//@synthesize type;
//@synthesize bottomBarView;
//@synthesize investmentButton;
//@synthesize myAccountButton;
//@synthesize moreThingButton;
//@synthesize isfirstLogin;
//
//
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        
//        transferDict =[[NSMutableDictionary alloc]initWithCapacity:0];
//        
//    }
//    return self;
//}
//-(void)showAlertView
//{
//    return;
//    NSLog(@"transferDict================%@",transferDict);
//    
//    //在“预认证”状态时：请在2个工作日内上传身份证
//    //在“已上传”状态时：在1个工作日内审核
//    //prompttime
//    
// 
//    
//    if ([[NNString delStringNull:[transferDict objectForKey:AUTHSTATUS]] isEqualToString: PREAUTH])
//    {
//        if ([[self delStringNull:[transferDict objectForKey:PROMPTTIME]] intValue]>0)
//        {
//            alertView11 = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请于%@日内完成身份证件图片上传，否则账户会被冻结",[transferDict objectForKey:@"prompttime"]] delegate:self cancelButtonTitle:@"立刻上传" otherButtonTitles:@"稍后上传",nil];
//            alertView11.tag =123;
//            [alertView11 show];
//            
//        }
//        
//    }
//    else if ([[NNString delStringNull:[transferDict objectForKey:AUTHSTATUS] ] isEqualToString: AUTHFAIL])
//    {
//        alertView12 = [[UIAlertView alloc] initWithTitle:nil message:@"您的账户已被冻结" delegate:self cancelButtonTitle:@"上传证件" otherButtonTitles:@"联系客服",nil];
//        alertView12.tag = 222;
//        [alertView12 show];
//    }
//    
//    
//   
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [alertView11 dismissWithClickedButtonIndex:0 animated:YES];
//    [alertView12 dismissWithClickedButtonIndex:0 animated:YES];
//
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	
//    [self initUI];
//    
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gotoMyAccount_MyMoneyCountViewController) name:GOtoMyAccount_MyMoneyCount object:nil];
//    
//    //有新项目显示小红点
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haveNewInvestmentShowRedPoint) name:HaveNewInvestment_ShowRedPoint object:nil];
//    //有新闻公告显示小红点
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haveNewsShowRedPoint) name:HaveNews_ShowRedPoint object:nil];
//    //有新版本显示小红点
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haveNewVervionShowRedPoint) name:HaveNewVervion_ShowRedPoint object:nil];
//    
//}
//
//
//
//-(void)initUI
//{
//    
//    investmentVC = [[InvestmentProjectViewController alloc] init];
//    myAccountVC = [[MyAccountViewController alloc] init];
//    moreThingVC = [[MoreThingViewController alloc] init];
//   
//    
//    UINavigationController * nc1 = [[UINavigationController alloc] initWithRootViewController:investmentVC];
//    UINavigationController * nc2 = [[UINavigationController alloc] initWithRootViewController:myAccountVC];
//    UINavigationController * nc3 = [[UINavigationController alloc] initWithRootViewController:moreThingVC];
//    
//    nc1.hidesBottomBarWhenPushed = YES;
//    nc2.hidesBottomBarWhenPushed = YES;
//    nc3.hidesBottomBarWhenPushed = YES;
//    
//    
//    self.viewControllers = [NSArray arrayWithObjects:nc1,nc2,nc3,nil];
//    
//    investmentVC.hidesBottomBarWhenPushed = YES;
//    myAccountVC.hidesBottomBarWhenPushed = YES;
//    moreThingVC.hidesBottomBarWhenPushed = YES;
//   
//   
//    bottomBarView = [[HP_UIView alloc] init];
//    [bottomBarView setFrame:CGRectMake(0,MainHeight-50, MainWidth,50)];
//    [bottomBarView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:bottomBarView];
//    
//    
//    
//    investmentButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    investmentButton.tag=0;
//    investmentButton.frame = CGRectMake(0, 0, 106, 50);
//    //[investmentButton setBackgroundColor:[HP_UIColorUtils colorWithHexString:HUI_979797]];
//    [investmentButton setBackgroundImage:[UIImage imageNamed:@"002_1"] forState:UIControlStateNormal];
//    [investmentButton setBackgroundImage:[UIImage imageNamed:@"002_1dj"] forState:UIControlStateHighlighted];
//    [investmentButton addTarget:self action:@selector(changeCurrentTabViewController:) forControlEvents:UIControlEventTouchUpInside];
//    //investmentButton.alpha=0.8;
//    [bottomBarView addSubview:investmentButton];
//    
//    redPointImageView0=[[HP_UIImageView alloc]initWithFrame:CGRectMake(65, 0, 25, 25)];
//    [redPointImageView0 setImage:[UIImage imageNamed:@"redpoint"]];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",HaveNewInvestment_ShowRedPoint,HaveNewInvestment_ShowRedPoint]]isEqualToString:HaveNewInvestment_ShowRedPoint])
//    {
//        redPointImageView0.alpha=1;
//        
//        
//    }
//    else
//    {
//        redPointImageView0.alpha=0;
//    }
//    [investmentButton addSubview:redPointImageView0];
//    
//    myAccountButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    myAccountButton.tag=1;
//    myAccountButton.frame = CGRectMake(106+1, 0, 106, 50);
//    //[myAccountButton setBackgroundColor:[HP_UIColorUtils colorWithHexString:TOPBAR_COLOR]];
//    [myAccountButton setBackgroundImage:[UIImage imageNamed:@"002_2"] forState:UIControlStateNormal];
//    [myAccountButton setBackgroundImage:[UIImage imageNamed:@"002_2dj"] forState:UIControlStateHighlighted];
//    [myAccountButton addTarget:self action:@selector(changeCurrentTabViewController:) forControlEvents:UIControlEventTouchUpInside];
//    //myAccountButton.alpha=0.8;
//    [bottomBarView addSubview:myAccountButton];
//    
//    redPointImageView1=[[HP_UIImageView alloc]initWithFrame:CGRectMake(60, 0, 25, 25)];
//    [redPointImageView1 setImage:[UIImage imageNamed:@"redpoint"]];
//    redPointImageView1.alpha=0;
//    [myAccountButton addSubview:redPointImageView1];
//    
//    
//    moreThingButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
//    moreThingButton.tag=2;
//    moreThingButton.frame = CGRectMake(MainWidth-106, 0, 106, 50);
//    //[moreThingButton setBackgroundColor:[HP_UIColorUtils colorWithHexString:HUI_979797]];
//    [moreThingButton setBackgroundImage:[UIImage imageNamed:@"002_3"] forState:UIControlStateNormal];
//    [moreThingButton setBackgroundImage:[UIImage imageNamed:@"002_3dj"] forState:UIControlStateHighlighted];
//    [moreThingButton addTarget:self action:@selector(changeCurrentTabViewController:) forControlEvents:UIControlEventTouchUpInside];
//    //moreThingButton.alpha=0.8;
//    [bottomBarView addSubview:moreThingButton];
//    
//    redPointImageView2=[[HP_UIImageView alloc]initWithFrame:CGRectMake(60, 0, 25, 25)];
//    [redPointImageView2 setImage:[UIImage imageNamed:@"redpoint"]];
//    
//    NSString* keyAndVAlueString=[NSString stringWithFormat:@"%@_%@",CurVervionString,HaveNewVervion_ShowRedPoint];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",HaveNews_ShowRedPoint,HaveNews_ShowRedPoint]]isEqualToString:HaveNews_ShowRedPoint]||[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",keyAndVAlueString,keyAndVAlueString]]isEqualToString:keyAndVAlueString])
//    {
//        redPointImageView2.alpha=1;
//        NSLog(@"hhhhh");
//        
//    }
//    else
//    {
//        redPointImageView2.alpha=0;
//    }
//    [moreThingButton addSubview:redPointImageView2];
//    
//    
//    UIView* garyLineView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 1)];
//    [garyLineView setBackgroundColor:[HP_UIColorUtils colorWithHexString:LINE_COLOR]];
//    [bottomBarView addSubview:garyLineView];
//    
//    redLineView= [[UIView alloc] initWithFrame:CGRectMake(0, 48, MainWidth/3, 2)];
//    [redLineView setBackgroundColor:[HP_UIColorUtils colorWithHexString:TOPBAR_COLOR]];
//    [bottomBarView addSubview:redLineView];
//    
//    
//    
//    
//    [self changeCurrentTabViewController:myAccountButton];
//    
//    
//    
//    
//    isfirstLogin=YES;
//    if (isfirstLogin)
//    {
//        
////        MyMoneyCountViewController* MMVC=[[MyMoneyCountViewController alloc]init];
////        MMVC.isfirstLogin=YES;
////        myAccountVC.navigationController.navigationBarHidden=YES;
////        [myAccountVC.navigationController pushViewController:MMVC animated:YES];
//        
//    }
//    
//    //[self initWelcomePage];return;
//    
////    NSString* keystring=[NSString stringWithFormat:@"%@_MainVC_WelcomePage",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
////    if (![[[NSUserDefaults standardUserDefaults] objectForKey:keystring]isEqualToString:keystring])
////    {
////        [self initWelcomePage];
////    }
//    
//}
//#pragma mark
//-(void)initWelcomePage
//{
//    topScrollView=[[UIScrollView alloc]init];
//    [topScrollView setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
//    topScrollView.backgroundColor=[UIColor clearColor];
//    [topScrollView setUserInteractionEnabled:YES];
//    topScrollView.delegate=self;
//    [self.view addSubview:topScrollView];
//    
//    
//    
//    for (int i=0; i<5; i++)
//    {
//    
//        
//        bigSquareImageView=[[HP_UIImageView alloc]initWithFrame:CGRectMake(MainWidth*i,0,MainWidth,MainHeight)];
//        bigSquareImageView.tag=2000+i;
//        [bigSquareImageView setUserInteractionEnabled:YES];
//        if (MainHeight>500)
//        {
//             [bigSquareImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"5come%d",i]]];
//        }
//        else
//        {
//             [bigSquareImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"4come%d",i]]];
//        }
//        
////        bigSquareImageView.layer.cornerRadius=6;
////        bigSquareImageView.layer.masksToBounds=YES;
//        bigSquareImageView.backgroundColor=[UIColor clearColor];
//        [topScrollView addSubview:bigSquareImageView];
//        
//    }
//    
//    [topScrollView setContentSize:CGSizeMake(MainWidth*5, MainHeight)];
//    topScrollView.pagingEnabled=YES;
//    topScrollView.showsHorizontalScrollIndicator=NO;
//    
//    
//  
//
//}
//
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    if (scrollView.contentOffset.x>MainWidth*4+50)
//    {
//        
//        NSString* keystring=[NSString stringWithFormat:@"%@_MainVC_WelcomePage",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//        [[NSUserDefaults standardUserDefaults] setObject:keystring forKey:keystring];
//        
//        [topScrollView removeFromSuperview];
//    }
//    
//    currentPage=(scrollView.contentOffset.x+MainWidth/2)/MainWidth;
//    topPageControl.currentPage=currentPage;
//}
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    currentPage=scrollView.contentOffset.x/MainWidth;
//    
//    topPageControl.currentPage=currentPage;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        [topScrollView setContentOffset:CGPointMake(MainWidth*currentPage, 0)];
//    }];
//}
//
//#pragma mark
//-(void)changeCurrentTabViewController:(UIButton *)button
//{
//    if (isfirstLogin)
//    {
//        [myAccountVC.navigationController popToRootViewControllerAnimated:YES];
//        isfirstLogin=NO;
//    }
//    
//    int tabIndex = button.tag;
//    
//    if (tabIndex==0)
//    {
//        [investmentButton setBackgroundImage:[UIImage imageNamed:@"002_1dj"] forState:UIControlStateNormal];
//        [myAccountButton setBackgroundImage:[UIImage imageNamed:@"002_2"] forState:UIControlStateNormal];
//        [moreThingButton setBackgroundImage:[UIImage imageNamed:@"002_3"] forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.1 animations:^{
//            [redLineView setFrame:CGRectMake(0, 48, MainWidth/3,2)];
//        }];
//        
//        redPointImageView0.alpha=0;
//        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[NSString stringWithFormat:@"%@%@",HaveNewInvestment_ShowRedPoint,HaveNewInvestment_ShowRedPoint]];
//        NSLog(@"HaveNewInvestment_ShowRedPoint %@",[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@%@",HaveNewInvestment_ShowRedPoint,HaveNewInvestment_ShowRedPoint]]);
//
//    }
//    else if(tabIndex==1)
//    {
//        [investmentButton setBackgroundImage:[UIImage imageNamed:@"002_1"] forState:UIControlStateNormal];
//        [myAccountButton setBackgroundImage:[UIImage imageNamed:@"002_2dj"] forState:UIControlStateNormal];
//        [moreThingButton setBackgroundImage:[UIImage imageNamed:@"002_3"] forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.1 animations:^{
//            [redLineView setFrame:CGRectMake(MainWidth/3, 48, MainWidth/3,2)];
//        }];
//        
//        redPointImageView1.alpha=0;
//
//    }
//    else if(tabIndex==2)
//    {
//        [investmentButton setBackgroundImage:[UIImage imageNamed:@"002_1"] forState:UIControlStateNormal];
//        [myAccountButton setBackgroundImage:[UIImage imageNamed:@"002_2"] forState:UIControlStateNormal];
//        [moreThingButton setBackgroundImage:[UIImage imageNamed:@"002_3dj"] forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.1 animations:^{
//            [redLineView setFrame:CGRectMake(MainWidth*2/3, 48, MainWidth/3,2)];
//        }];
//        
//        redPointImageView2.alpha=0;
//        
//        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[NSString stringWithFormat:@"%@%@",HaveNews_ShowRedPoint,HaveNews_ShowRedPoint]];
//        
//        NSString* keyAndVAlueString=[NSString stringWithFormat:@"%@_%@",CurVervionString,HaveNewVervion_ShowRedPoint];
//        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[NSString stringWithFormat:@"%@%@",keyAndVAlueString,keyAndVAlueString]];
//        
//    }
//    
//    [self setSelectedIndex:tabIndex];
//    
//    
//    
//}
//
//-(void)investmentSelectStatueWithType:(int)typee
//{
//    [investmentVC initDataWithType:typee];
//
//}
//-(void) setBottomBarHidden:(BOOL) isHidden
//{    
//    [bottomBarView setHidden:isHidden];
//    
//    if (isHidden)
//    {
//        
//    }
//}
//
//
//-(void)hideTabBar
//{
//    [self.tabBarController.tabBar setHidden:YES];
//    
//    UIView *contentView;
//    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
//        contentView = [self.view.subviews objectAtIndex:1];
//    else
//        contentView = [self.view.subviews objectAtIndex:0];
//    [contentView setFrame:CGRectMake(0,0, ScreenWidth , ScreenHeight+40)];
//}
//
//
//-(void)gotoMyAccount_MyMoneyCountViewController
//{
//    [self.navigationController popToViewController:self animated:NO];
//    
//    [self changeCurrentTabViewController:myAccountButton];
//   
////    MyMoneyCountViewController* MMVC=[[MyMoneyCountViewController alloc]init];
////    [self.navigationController pushViewController:MMVC animated:YES];
//   
//
//}
//
//-(void)haveNewInvestmentShowRedPoint
//{
//    NSLog(@"HaveNewI %@",[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@%@",HaveNewInvestment_ShowRedPoint,HaveNewInvestment_ShowRedPoint]]);
//    redPointImageView0.alpha=1;
//    
//    
//}
//-(void)haveNewsShowRedPoint
//{
//    
//    redPointImageView2.alpha=1;
//    
//    
//}
//-(void)haveNewVervionShowRedPoint
//{
//    
//    
//    redPointImageView2.alpha=1;
//    
//        
//}
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag==123)
//    {
//        if (buttonIndex==0)
//        {
//            [self changeCurrentTabViewController:myAccountButton];
//            
//
//            MyInformationViewController* MIVC=[[MyInformationViewController alloc]init];
//            [self.navigationController pushViewController:MIVC animated:NO];
//            
//            
//            RealNameAuthenticationViewController* RNAVC=[[RealNameAuthenticationViewController alloc]init];
//            RNAVC.type=1;
//            [self.navigationController pushViewController:RNAVC animated:YES];
//            
//        }
//    }
//    else if (alertView.tag==222)
//    {
//        if (buttonIndex==0)
//        {
//            [self changeCurrentTabViewController:myAccountButton];
//            
//            
//            MyInformationViewController* MIVC=[[MyInformationViewController alloc]init];
//            [self.navigationController pushViewController:MIVC animated:NO];
//            
//            
//            RealNameAuthenticationViewController* RNAVC=[[RealNameAuthenticationViewController alloc]init];
//            RNAVC.type=1;
//            [self.navigationController pushViewController:RNAVC animated:YES];
//            
//        }
//        else if (buttonIndex==1)
//        {
//            UIWebView* phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
//            [self.view addSubview:phoneCallWebView];
//            [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",KeFu_Telphone_for_tell]]]];
//        }
//    }
//    
//}
//-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    
//}
//
//
//
//
////继承navigationController  设置横竖屏翻转问题
////-(NSUInteger)supportedInterfaceOrientations{
////    if([[self ] isKindOfClass:[HP_BaseViewController class]])
////        return UIInterfaceOrientationMaskAllButUpsideDown;
////    else
////        return UIInterfaceOrientationMaskPortrait;
////}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
