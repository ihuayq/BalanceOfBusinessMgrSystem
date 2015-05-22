//
//  BaseViewController.m
//  Canada
//
//  Created by zhaojianguo on 13-10-9.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import "FMBaseViewController.h"
@interface FMBaseViewController ()

@end

@implementation FMBaseViewController
@synthesize navigation = _navigation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * systeam = [UIDevice currentDevice].systemVersion;
    float number = [systeam floatValue];
    
    CGFloat height = 0.0f;
    NSInteger type = 0;
    if (number <= 6.9) {
        type = 0;
        height = 44.0f;
    }else{
        type = 1;
        height = 66.0f;
    }
    
    //globle = [Globle shareGloble];
    
    self.navigation = [[ZZNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    _navigation.type = type;
    _navigation.leftImage  = [UIImage imageNamed:@"nav_backbtn.png"];
    _navigation.delegate = self;
    _navigation.backgroundColor = UISTYLECOLOR;
    //_navigation.backgroundColor = [self getRandomColor];
    [self.view addSubview:_navigation];
    
     NSLog(@"the title navigation is:%@",self.navigation);

	// Do any additional setup after loading the view.
}
- (UIColor *)getRandomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return color;
}

#pragma mark ##### ZZNavigationViewDelegate ####
-(void)previousToViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClickEvent
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
