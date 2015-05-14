//
//  BMAssetsInfoSubViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMAssetsInfoSubViewController.h"
#import "NALLabelsMatrix.h"
#import "RFSegmentView.h"
#import "SCNavTabBarController.h"
#import "AssetDetailTableViewController.h"

@interface BMAssetsInfoSubViewController ()<RFSegmentViewDelegate>{
    UIScrollView * _scrollView;
}
@property (nonatomic,strong) UIWebView * webView;
@end

@implementation BMAssetsInfoSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"资产变动明细";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    //self.navigation.rightImage = [UIImage imageNamed:@"earnings.png"];
    
    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, ScreenWidth, 30) items:@[@"预约",@"派息",@"成交",@"提现"]];
    segmentView.tintColor = [self getRandomColor];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT+30, self.view.frame.size.width, MainHeight-48.5f - NAVIGATION_OUTLET_HEIGHT)];
//    //    _scrollView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:_scrollView];
//    _scrollView.showsVerticalScrollIndicator= NO;
//    
//    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width,MainHeight-48.5f - NAVIGATION_OUTLET_HEIGHT + 100);
//     [self.view addSubview:_scrollView];
//    
//    NSNumber* average =  [NSNumber numberWithInt:MainWidth/4];
//    NSArray *array = [[NSArray alloc] initWithObjects:average,average,average,average,nil];
//    NALLabelsMatrix* matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0,0, MainWidth, 100)
//                                                    andColumnsWidths:array];
//    [matrix addRecord:[[NSArray alloc] initWithObjects:@" ", @"Old Value", @"New value ", @"New value ",nil]];
//    [matrix addRecord:[[NSArray alloc] initWithObjects:@"Field1", @"hello", @"This is a really really long string and should wrap to multiple lines.", @"hello", nil]];
//    [matrix addRecord:[[NSArray alloc] initWithObjects:@"Some Date", @"06/24/2013", @"06/30/2013", @"hello", nil]];
//    [matrix addRecord:[[NSArray alloc] initWithObjects:@"Field2", @"some value", @"some new value",@"hello",  nil]];
//    [matrix addRecord:[[NSArray alloc] initWithObjects:@"Long Fields", @"The quick brown fox jumps over the little lazy dog.", @"some new value",@"hello",  nil]];
    
    
    NSMutableArray *chooseArray = [NSMutableArray arrayWithObjects:@"预约",@"派息",@"成交",@"提现",nil];
    NSMutableArray *chooseControllerArray = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger index = 0; index < 4; index++)
    {
        AssetDetailTableViewController * mc = [[AssetDetailTableViewController alloc] init];
        mc.title = [chooseArray objectAtIndex:(NSUInteger)index];
        [chooseControllerArray addObject:mc];
    }
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] initWithSubViewControllers:chooseControllerArray andParentViewController:self showArrowButton:NO];
    [navTabBarController.view setFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT,MainWidth, MainHeight- -48.5f)];
    [self.view addSubview:navTabBarController.view];
    [self addChildViewController:navTabBarController];
    
    [self requestNetWork];
    //[_scrollView addSubview:matrix];
  
}

-(void)requestNetWork{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    
    //    queryDetail
    //    韩韶茹  17:25:24
    //    String signature = request.getParameter("signature");
    //    String querType = request.getParameter("queryFlag");
    //    String personId = request.getParameter("personId");
    //    String pageNow = request.getParameter("pageNow");
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:@"1" forKey:@"pageNow"];
    [connDictionary setObject:@"1" forKey:@"queryFlag"];
    
    NSString *url =[NSString stringWithFormat:@"%@",AssetInfoUrl];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             //缓存最新的资产信息
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"assetInfo"] forKey:@"assetInfo"];

         }
         else
         {
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error,NSString * msg) {
         NSLog(@"error:%@",error.debugDescription);
         if (![request isCancelled])
         {
             [request cancel];
         }
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)getRandomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return color;
}

- (void)segmentViewSelectIndex:(NSInteger)index
{
    NSLog(@"current index is %d",index);
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
