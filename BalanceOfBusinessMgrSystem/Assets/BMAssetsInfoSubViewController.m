//
//  BMAssetsInfoSubViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMAssetsInfoSubViewController.h"
#import "NALLabelsMatrix.h"
@interface BMAssetsInfoSubViewController ()

@end

@implementation BMAssetsInfoSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    NALLabelsMatrix* matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(5, 60, 310, 100) andColumnsWidths:[[NSArray alloc] initWithObjects:@60,@125,@125, nil]];
    
    [matrix addRecord:[[NSArray alloc] initWithObjects:@" ", @"Old Value", @"New value ", nil]];
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"Field1", @"hello", @"This is a really really long string and should wrap to multiple lines.", nil]];
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"Some Date", @"06/24/2013", @"06/30/2013", nil]];
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"Field2", @"some value", @"some new value", nil]];
    [matrix addRecord:[[NSArray alloc] initWithObjects:@"Long Fields", @"The quick brown fox jumps over the little lazy dog.", @"some new value", nil]];
    
    
    [self.view addSubview:matrix];
  
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
