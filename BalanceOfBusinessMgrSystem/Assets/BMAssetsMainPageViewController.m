
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
#import "BMWithDrawsCashViewController.h"
#import "DXAlertView.h"
#import "BMCreateTransactionpPasswordViewController.h"


@interface BMAssetsMainPageViewController (){
    UIImageView *_arrowButton;
    
    UIView *_datingIndicatorView;
    UIView *_popView;
    BOOL _popItemMenu;           // is needed pop item menu
    
    
    UIAssetsPageCell *historyProfitCell;
    UIAssetsPageCell *futurePrincipalCell;
    
}
@property(strong,nonatomic) UITableView * tableView;
@end

@implementation BMAssetsMainPageViewController
@synthesize tableView = _tableView;


//资产收益
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AssetChange:) name:@"AssetChange" object:nil];

    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"我的资产";

    HP_UIButton *okButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setBackgroundColor:[UIColor redColor]];
    [okButton setFrame: CGRectMake(self.navigation.frame.size.width-44, self.navigation.frame.size.height/2-12, 44, 44)];
    [okButton addTarget:self action:@selector(touchRightButton) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitle:@"提现" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.navigation addSubview:okButton];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT,MainWidth, MainHeight-48.5f - 44.0f - 200) ];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
     //预约资金
    _datingIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height + self.tableView.frame.origin.y , MainWidth, 60)];
    [_datingIndicatorView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [_datingIndicatorView.layer setBorderWidth:0.5f];
    [self.view addSubview:_datingIndicatorView];
    
    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/2 - 35 ,8, 75,20)];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.text = @"预约金额";
    registerLabel.font = [UIFont systemFontOfSize:18];
    //registerLabel.frame = CGRectMake(MainWidth/2 - registerLabel.frame.size.width/2, MainHeight/2 - registerLabel.frame.size.height/2, registerLabel.frame.size.width, registerLabel.frame.size.height);
    [_datingIndicatorView addSubview:registerLabel];
    
    UIImage *noteImage = [UIImage imageNamed:@"sanjiaobiao"];
    _arrowButton  = [[UIImageView alloc]  initWithFrame:CGRectMake(MainWidth/2 - noteImage.size.width/2, _datingIndicatorView.bounds.size.height - noteImage.size.height, noteImage.size.width, noteImage.size.height)];
    //imageLeftView.frame =  CGRectMake(0, 0, leftUIImage.size.width, leftUIImage.size.height);
    [_arrowButton setImage:noteImage];
     _arrowButton.userInteractionEnabled = YES;
    [_datingIndicatorView addSubview:_arrowButton];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
    [_arrowButton addGestureRecognizer:tapGestureRecognizer];
    
    //隐藏资金部分
    _popView = [[UIDatingAssetsViewTips alloc] initWithFrame:CGRectMake(0, _datingIndicatorView.frame.size.height + _datingIndicatorView.frame.origin.y, MainWidth, 80)];
//    [_popView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
//    [_popView.layer setBorderWidth:0.5f];
    [self.view addSubview:_popView];
    _popView.hidden = YES;
    
    UIView *verticaLine = [[UIView alloc]initWithFrame:CGRectMake(0,80,MainWidth,0.5f)];
    verticaLine.backgroundColor = [UIColor lightGrayColor];
    [_popView addSubview:verticaLine];
    
    historyProfitCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(0, 0, MainWidth/2, 80) leftUIImage:[UIImage imageNamed:@"zuoriruzhangjine"] titleText:(NSString*)@"昨日入账（元）" numText:(NSString*) @"0.00"];
    [_popView addSubview:historyProfitCell];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(MainWidth/2,0, 0.5, 80)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_popView addSubview:line];
    
    futurePrincipalCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(MainWidth/2,0, MainWidth/2, 80) leftUIImage:[UIImage imageNamed:@"paiduizijin"] titleText:(NSString*)@"排队资金（元）" numText:(NSString*) @"0.00"];
    [_popView addSubview:futurePrincipalCell];
    
    historyProfitCell.moneyNum = self.assetInfo.historyProfit;
    futurePrincipalCell.moneyNum = self.assetInfo.futurePrincipal;
    
}

-(void)touchRightButton{
    [self rightButtonClickEvent];
}


- (void)AssetChange:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"textOne"]);
    NSLog(@"－－－－－接收到通知------");
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"balanceInfo"];
    NSLog(@"the balanceInfo is: %@",dic);
    
    self.assetInfo.totalAssets   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalAmount"]];
    self.assetInfo.oldProfit   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"yesterdayRevenue"]];
    self.assetInfo.curPrincipal   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"inAmount"]];
    self.assetInfo.curProfit   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"accruedIncome"]];
    self.assetInfo.historyProfit   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"yesterdayNetAmount"]];
    self.assetInfo.futurePrincipal   = [NSString stringWithFormat:@"%@",[dic objectForKey:@"queueMoney"]];
    
    historyProfitCell.moneyNum = self.assetInfo.historyProfit;
    futurePrincipalCell.moneyNum = self.assetInfo.futurePrincipal;
    [_tableView reloadData];
    
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
 
    if (indexPath.row == 0) {
            UITotalAssetsTableViewCell *cell = [[UITotalAssetsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
            cell.money = self.assetInfo.totalAssets;
        NSLog(@"money:%@",self.assetInfo.totalAssets);
        return cell;
    }
    else if (indexPath.row == 1){
        UIOldAssetsTableViewCell *cell = [[UIOldAssetsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
        cell.money = self.assetInfo.oldProfit;
        NSLog(@"Profit:%@",cell.money);
        return cell;
    }
    else if (indexPath.row == 2){
        UIOtherAssetsTableViewCell *cell = [[UIOtherAssetsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
        cell.principalMoney = self.assetInfo.curPrincipal;
        cell.receiptsMoney = self.assetInfo.curProfit;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 80;
    }
    return 72;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 0 ) {
         //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else{
        BMAssetsInfoSubViewController *vc = [[BMAssetsInfoSubViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

-(void)rightButtonClickEvent{
    //需要判断是否已经设置交易密码
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"payMark"] isEqualToString:@"1"]) {
        BMWithDrawsCashViewController*vc = [[BMWithDrawsCashViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您还没有设置交易密码,暂时无法提现,是否现在设置?" leftButtonTitle:@"是" rightButtonTitle:@"否"];
        [alert show];
        alert.leftBlock = ^() {
            NSLog(@"left button clicked");
            BMCreateTransactionpPasswordViewController *info = [[BMCreateTransactionpPasswordViewController alloc] init];
            [self.navigationController pushViewController:info
                                                 animated:NO];
        };
        alert.rightBlock = ^() {
            NSLog(@"right button clicked");
            [self.navigationController popViewControllerAnimated:YES];
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
        };
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
