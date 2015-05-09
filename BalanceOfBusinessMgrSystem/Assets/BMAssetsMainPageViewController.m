//
//  BMEarningMainPageViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMAssetsMainPageViewController.h"
#import "UIAssetsTableViewCell.h"
#import "UIAssetsPageCell.h"
#import "UIDatingAssetsViewTips.h"
#import "BMAssetsInfoSubViewController.h"

@interface BMAssetsMainPageViewController (){
    UIImageView *_arrowButton;
    
    UIView *_datingIndicatorView;
    UIView *_popView;
    BOOL            _popItemMenu;           // is needed pop item menu
}
@property(strong,nonatomic) UITableView * tableView;
@end

@implementation BMAssetsMainPageViewController
@synthesize tableView = _tableView;
//资产收益
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.navigaionBackColor =  [UIColor orangeColor];
    self.navigation.title = @"我的资产";
    self.navigation.rightImage = [UIImage imageNamed:@"earnings.png"];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT,MainWidth, MainHeight-48.5f - 44.0f - 200) ];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    _datingIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height + self.tableView.frame.origin.y , MainWidth, 60)];
    [_datingIndicatorView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [_datingIndicatorView.layer setBorderWidth:0.5f];
    [self.view addSubview:_datingIndicatorView];
    
    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/2 - 35 ,0, 75,20)];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    //registerLabel.backgroundColor = [UIColor clearColor];
    registerLabel.text = @"预约金额";
    //registerLabel.textColor = [UIColor whiteColor];
    registerLabel.font = [UIFont systemFontOfSize:18];
    //registerLabel.frame = CGRectMake(MainWidth/2 - registerLabel.frame.size.width/2, MainHeight/2 - registerLabel.frame.size.height/2, registerLabel.frame.size.width, registerLabel.frame.size.height);
    [_datingIndicatorView addSubview:registerLabel];
    
    UIImage *noteImage = [UIImage imageNamed:@"sanjiaobiao.png"];
    _arrowButton  = [[UIImageView alloc]  initWithFrame:CGRectMake(MainWidth/2 - noteImage.size.width/2, _datingIndicatorView.bounds.size.height - noteImage.size.height, noteImage.size.width, noteImage.size.height)];
    //imageLeftView.frame =  CGRectMake(0, 0, leftUIImage.size.width, leftUIImage.size.height);
    [_arrowButton setImage:noteImage];
     _arrowButton.userInteractionEnabled = YES;
    [_datingIndicatorView addSubview:_arrowButton];
    
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
    [_arrowButton addGestureRecognizer:tapGestureRecognizer];
    
    _popView = [[UIDatingAssetsViewTips alloc] initWithFrame:CGRectMake(0, _datingIndicatorView.frame.size.height + _datingIndicatorView.frame.origin.y, MainWidth, 60)];
    [_popView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [_popView.layer setBorderWidth:0.5f];
    [self.view addSubview:_popView];
    _popView.hidden = YES;
    
    UIAssetsPageCell *principalCell1 = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(0, 0, MainWidth/2, 60) leftUIImage:[UIImage imageNamed:@"昨日入账.png"] titleText:(NSString*)@" 昨日入账（元）" numText:(NSString*) @"0.00"];
    [principalCell1.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [principalCell1.layer setBorderWidth:0.5f];
    [_popView addSubview:principalCell1];
    
    UIAssetsPageCell *principalCell2 = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(MainWidth/2,0, MainWidth/2, 60) leftUIImage:[UIImage imageNamed:@"排队资金.png"] titleText:(NSString*)@"排队资金（元）" numText:(NSString*) @"0.00"];
    [principalCell2.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [principalCell2.layer setBorderWidth:0.5f];
    [_popView addSubview:principalCell2];


}

- (void)popItemMenu:(BOOL)pop
{
    if (pop)
    {
        //[self viewShowShadow:_arrowButton shadowRadius:DOT_COORDINATE shadowOpacity:DOT_COORDINATE];
        [UIView animateWithDuration:0.5f animations:^{
            //_navgationTabBar.hidden = YES;
            _arrowButton.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                if (!_popView)
                {

                }
                _popView.hidden = NO;
            }];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            _popView.hidden = !_popView.hidden;
            _arrowButton.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //_navgationTabBar.hidden = !_navgationTabBar.hidden;
            [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
        }];
    }
}

- (void)functionButtonPressed
{
    _popItemMenu = !_popItemMenu;
    [self popItemMenu:_popItemMenu];
    
//    [_delegate shouldPopNavgationItemMenu:_popItemMenu height:[self popMenuHeight]];
}

- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    //view.layer.shadowRadius = shadowRadius;
    //view.layer.shadowOpacity = shadowOpacity;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    UITableViewCell *cell;
    if (!cell) {
        if (indexPath.row == 0) {
            
            //UITotalAssetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
            if (cell == nil) {
                cell = [[UITotalAssetsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
            }
        }
        else if (indexPath.row == 1){
            cell = [[UIOldAssetsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
        }
        else if (indexPath.row == 2){
            cell = [[UIOtherAssetsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];  
        }
        else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
        }
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0 ) {
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else{
        BMAssetsInfoSubViewController *vc = [[BMAssetsInfoSubViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
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
