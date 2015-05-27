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

//    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, ScreenWidth, 30) items:@[@"预约",@"派息",@"成交",@"提现"]];
//    segmentView.tintColor = [self getRandomColor];
//    segmentView.delegate = self;
//    [self.view addSubview:segmentView];
    
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
    
    
    NSMutableArray *chooseArray = [NSMutableArray arrayWithObjects:@"入账",@"成交",@"派息",@"提现",nil];
    NSMutableArray *chooseControllerArray = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger index = 0; index < 4; index++)
    {
        AssetDetailTableViewController * mc = [[AssetDetailTableViewController alloc] init];
        mc.title = [chooseArray objectAtIndex:(NSUInteger)index];
        [chooseControllerArray addObject:mc];
    }
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] initWithSubViewControllers:chooseControllerArray andParentViewController:self showArrowButton:NO];
    [navTabBarController.view setFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT,MainWidth, MainHeight - 44.0f -48.5f)];
    [self.view addSubview:navTabBarController.view];
    [self addChildViewController:navTabBarController];
    
    //[self requestNetWor                       k];
    //[_scrollView addSubview:matrix];
  
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
