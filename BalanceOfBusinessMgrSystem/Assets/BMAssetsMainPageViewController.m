
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
#import "SVPullToRefresh.h"
#import "BankAccountItem.h"
#import "settingNaturalManInfoViewController.h"
#import "bindNetworkPointAccountViewController.h"
#import "bindBalanceAccountViewController.h"


@interface BMAssetsMainPageViewController ()<UIGestureRecognizerDelegate>{
    UIImageView *_arrowButton;
    
    UIView *_datingIndicatorView;
    UIView *_popView;
    BOOL _popItemMenu;           // is needed pop item menu
    
    
    UIAssetsPageCell *historyProfitCell;
    UIAssetsPageCell *futurePrincipalCell;
    
    UIScrollView * scrollView;
    
    //NSArray *itemHeightArray;
    float contentItemAverageHeight;
    
}
@property(strong,nonatomic) UITableView * tableView;
@end

@implementation BMAssetsMainPageViewController
@synthesize tableView = _tableView;


//资产收益
- (void)viewDidLoad {
    [super viewDidLoad];
    
    contentItemAverageHeight = (MainHeight-48.5f - 64.0f)/5;
    
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

    scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT,MainWidth, MainHeight-48.5f - 64.0f)];
    scrollView.contentSize=CGSizeMake(MainWidth, MainHeight-48.5f - 63.5f);
    [self.view addSubview:scrollView];
    __weak BMAssetsMainPageViewController *weakSelf = self;
    // setup pull-to-refresh
    [scrollView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshData];
    }];
    
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,MainWidth, MainHeight-48.5f - 44.0f - 200) style:UITableViewStyleGrouped];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,MainWidth, contentItemAverageHeight*3.3) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollEnabled = NO;
    [scrollView addSubview:self.tableView];

     //预约资金
    _datingIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height + self.tableView.frame.origin.y , MainWidth, contentItemAverageHeight*0.7)];
    //[_datingIndicatorView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    //[_datingIndicatorView.layer setBorderWidth:0.5f];
    [scrollView addSubview:_datingIndicatorView];
    
    UIView *verticaLine = [[UIView alloc]initWithFrame:CGRectMake(0,contentItemAverageHeight*0.7,MainWidth,0.5f)];
    verticaLine.backgroundColor = [UIColor lightGrayColor];
    [_datingIndicatorView addSubview:verticaLine];
    
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
    _popView = [[UIDatingAssetsViewTips alloc] initWithFrame:CGRectMake(0, _datingIndicatorView.frame.size.height + _datingIndicatorView.frame.origin.y, MainWidth, contentItemAverageHeight)];
    [scrollView addSubview:_popView];
    _popView.hidden = YES;
    
    UIView *verticaLinePop = [[UIView alloc]initWithFrame:CGRectMake(0,contentItemAverageHeight,MainWidth,0.5f)];
    verticaLinePop.backgroundColor = [UIColor lightGrayColor];
    [_popView addSubview:verticaLinePop];
    
    historyProfitCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(0, 0, MainWidth/2, contentItemAverageHeight) leftUIImage:[UIImage imageNamed:@"zuoriruzhangjine"] titleText:(NSString*)@"昨日入账（元）" numText:(NSString*) @"0.00"];
    [_popView addSubview:historyProfitCell];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(MainWidth/2,0, 0.5, contentItemAverageHeight)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_popView addSubview:line];
    
    futurePrincipalCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(MainWidth/2,0, MainWidth/2, contentItemAverageHeight) leftUIImage:[UIImage imageNamed:@"paiduizijin"] titleText:(NSString*)@"排队资金（元）" numText:(NSString*) @"0.00"];
    [_popView addSubview:futurePrincipalCell];
    
    historyProfitCell.moneyNum = self.assetInfo.historyProfit;
    futurePrincipalCell.moneyNum = self.assetInfo.futurePrincipal;
    
}

-(void)refreshData{
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,QueryMainAssetURL];
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    //[self showMBProgressHUDWithMessage:@"更新资产数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         //[self hidMBProgressHUD];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             NSLog(@"connDictionary:%@",responseJSONDictionary);
             
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"balanceInfo"] forKey:@"balanceInfo"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             // __weak BMAssetsMainPageViewController *weakSelf = self;
             
             int64_t delayInSeconds = 1.0;
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 //[weakSelf.tableView beginUpdates];
                 //[weakSelf.tableView endUpdates];
                 [self AssetChange:nil];
                 [scrollView.pullToRefreshView stopAnimating];
             });
         }
         //相同账号同时登陆，返回错误
         else if([ret isEqualToString:reLoginOutFlag])
         {
             [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
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
         //[[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         //[self hidMBProgressHUD];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
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
//    if (indexPath.row == 0) {
//        return contentItemAverageHeight*1.5;
//    }
//    else if (indexPath.row == 2) {
//        return 80;
//    }
//    return 72;
    
    if (indexPath.row == 0) {
        return contentItemAverageHeight*1.5;
    }
    else if (indexPath.row == 2) {
        return contentItemAverageHeight;
    }
    return contentItemAverageHeight * 0.8;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 0 ) {
         //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else{
        BMAssetsInfoSubViewController *vc = [[BMAssetsInfoSubViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

-(void)rightButtonClickEvent{
    
    NSLog(@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"addNaturalMark"]);
    //查看自然人手机号码是否已经添加完毕
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"addNaturalMark"] isEqualToString:@"0"]) {
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您的个人信息还没有完善，是否现在进行操作？" leftButtonTitle:@"是" rightButtonTitle:@"否"];
        [alert show];
        alert.leftBlock = ^() {
            settingNaturalManInfoViewController *info = [[settingNaturalManInfoViewController alloc] init];
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info
                                                 animated:NO];
        };
        alert.rightBlock = ^() {
            NSLog(@"Right button clicked");
            [self.navigationController popViewControllerAnimated:YES];
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
        };

        return;
    }
    else if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"addwebsiteFlag"] isEqualToString:@"0"]){
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您还没设置银行卡账号信息,是否现在设置!" leftButtonTitle:@"是" rightButtonTitle:@"否"];
        [alert show];
        alert.leftBlock = ^() {
            [self requestNetWork];
        };
        alert.rightBlock = ^() {
            NSLog(@"Right button clicked");
            [self.navigationController popViewControllerAnimated:YES];
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
        };
        
        return;
    }
    
    
    //需要判断是否已经设置交易密码
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"payMark"] isEqualToString:@"1"]) {
        BMWithDrawsCashViewController*vc = [[BMWithDrawsCashViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您还没有设置交易密码,暂时无法提现,是否现在设置?" leftButtonTitle:@"是" rightButtonTitle:@"否"];
        [alert show];
        alert.leftBlock = ^() {
            NSLog(@"Left button clicked");
            BMCreateTransactionpPasswordViewController *info = [[BMCreateTransactionpPasswordViewController alloc] init];
            [self.navigationController pushViewController:info
                                                 animated:NO];
        };
        alert.rightBlock = ^() {
            NSLog(@"Right button clicked");
            [self.navigationController popViewControllerAnimated:YES];
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
        };
    }
}

-(void)requestNetWork{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    //http://192.168.1.107:8080/superMoney-core/commercia/getCommercialWebsiteInfo?commercialId=M0060013&personId=7
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID] forKey:USER_ID];
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,AccountURL];
    
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"] forKey:@"personId"];
    
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求账号数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             //设定当前自然人信息
             //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
             //             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             //             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             //             [Dict setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"personId"]] forKey:@"no"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"personName"] forKey:@"name"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"phoneNum"] forKey:@"phonenum"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"idCard"] forKey:@"identifyno"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"websiteList"] forKey:@"accountinfo"];
             //             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:@"curNatureMenInfo"];
             //保存完毕，注意在修改自然人的入口需要重新设定curNatureMenInfo信息
             
             NSMutableArray *groupNet=[[NSMutableArray alloc]init];
             NSArray *array = [responseJSONDictionary objectForKey:@"websiteList"];
             for ( NSDictionary *dic in array) {
                 //NSDictionary *dic=[array objectAtIndex:0];
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [dic objectForKey:@"pubAccName"];
                 item.bankName = [dic objectForKey:@"pubBankNameDet"];
                 item.bankCardNumber = [dic objectForKey:@"balanceAccount"];
                 item.siteNum = [dic objectForKey:@"siteNum"];
                 item.bSelected = [[dic objectForKey:@"selectedAccFlag"]  boolValue] ;//结算账号选定标记
                 item.bNetworkSelected = [[dic objectForKey:@"selectedFlag"] boolValue];//网点账号选定标记
                 [groupNet addObject:item];
             }
             //methods为true的时候，即按照网点来结算业务，表示返回网点和结算账户都有，且两者相同
             //methods为false的时候，按照商户结算，结算账户必有且只有一个，但是商户账户可能有也可能没有，即websiteList可能为空
             [[NSUserDefaults standardUserDefaults]setObject:[responseJSONDictionary objectForKey:@"methods"] forKey:@"methods"];
             
             // 网点情况
             if ([[responseJSONDictionary objectForKey:@"methods"] isEqualToString:@"TRUE"]) {
                 bindNetworkPointAccountViewController *info = [[bindNetworkPointAccountViewController alloc] init];
                 info.groupBalance = nil;
                 info.groupNetWork = groupNet;
                 [self.navigationController pushViewController:info
                                                      animated:NO];
             }
             //为false的情况，商户情况,含有网点和没有网点的情况，
             else{
                 
                 NSMutableArray *groupBalance=[[NSMutableArray alloc]init];
                 
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [responseJSONDictionary objectForKey:@"cpubAccName"];
                 item.bankName = [responseJSONDictionary objectForKey:@"cpubBankNameDet"];
                 item.bankCardNumber = [responseJSONDictionary objectForKey:@"cbalanceAccount"];
                 item.bSelected = YES;
                 [groupBalance addObject:item];
                 //含有网点，进入网点，不可以选择
                 if (groupNet.count > 0) {
                     bindNetworkPointAccountViewController *info = [[bindNetworkPointAccountViewController alloc] init];
                     info.groupBalance = groupBalance;
                     info.groupNetWork = groupNet;
                     [self.navigationController pushViewController:info
                                                          animated:NO];
                 }
                 //直接跳过网点选择界面
                 else{
                     bindBalanceAccountViewController *info = [[bindBalanceAccountViewController alloc] init];
                     info.groupNetWork = groupNet;
                     info.groupBalance = groupBalance;
                     [self.navigationController pushViewController:info
                                                          animated:NO];
                 }
             }
         }
         //相同账号同时登陆，返回错误
         else if([ret isEqualToString:reLoginOutFlag])
         {
             [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
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


#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
////    if ([touch.view isKindOfClass:[UIScrollView class]]){
////        return NO;
////    }
//    
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
//        return NO;
//    }
//    
//    return YES;
//}
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
