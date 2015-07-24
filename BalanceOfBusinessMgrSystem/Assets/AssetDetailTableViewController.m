//
//  MovieTableViewController.m
//  FreeMusic
//
//  Created by 华永奇 on 15/4/8.
//  Copyright (c) 2015年 xiaozi. All rights reserved.
//

#import "AssetDetailTableViewController.h"
#import "FMLoadMoreFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "ProgressHUD.h"
#import "AssetDetailTableViewCell.h"
#import "NSString+Utf8Encoding.h"
#import "Util.h"
#import "SVPullToRefresh.h"
#import "MJRefresh.h"

@interface AssetDetailTableViewController ()<UIScrollViewDelegate>
{
    BOOL isLoadingMore;
    BOOL isCanLoadMore;
    FMLoadMoreFooterView * footerView;
    NSMutableArray * array ;
    int list_total;
    int channelId;
    int pageNum;
    NSString * sort;
    NSMutableArray *chooseArray ;
    int nPos;
}

@end

@implementation AssetDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigation.hidden = YES;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-48.5f - 44.0f)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.estimatedRowHeight = 32.0f;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    footerView = [[FMLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 0)];
    _tableView.tableFooterView = footerView;
    
    [self.view addSubview:_tableView];
    
    [self setupRefresh];
    
//    __weak AssetDetailTableViewController *weakSelf = self;
//    
//    // setup pull-to-refresh
//    [_tableView addPullToRefreshWithActionHandler:^{
//        [weakSelf requestNetWork];
//        [weakSelf insertRowAtTop];
//    }];
//    
//    // setup infinite scrolling
//    [_tableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf requestAddMoreNetWork];
//    }];
    
//    if (_refreshHeaderView == nil) {
//        EGORefreshTableHeaderView *vieweg = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -120, MainWidth, 120)];
//        vieweg.delegate = self;
//        //[self.view insertSubview:vieweg belowSubview:self.tableView];
//        [_tableView addSubview:vieweg];
//        _refreshHeaderView = vieweg;
//        
//    }
//    
//    //  update the last update date
//    [_refreshHeaderView refreshLastUpdatedDate];
    
    pageNum = 1;
    channelId = [self getChannelIDString:self.title];
    if (channelId == 1) {
        [self.tableView headerBeginRefreshing];
    }
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    //[self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"刷新中...";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"加载中...";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加数据
    [self requestNetWork];
    
//    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView headerEndRefreshing];
//    });
}

- (void)footerRereshing
{
    // 1.添加数据
    [self requestAddMoreNetWork];
    
//    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView footerEndRefreshing];
//    });
}

//- (void)insertRowAtTop {
//    __weak AssetDetailTableViewController *weakSelf = self;
//    
//    int64_t delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
////        [weakSelf.tableView beginUpdates];
////        [weakSelf.dataSource insertObject:[NSDate date] atIndex:0];
////        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
////        [weakSelf.tableView endUpdates];
//        
//        [weakSelf.tableView.pullToRefreshView stopAnimating];
//    });
//}
//
//- (void)insertRowAtBottom {
//    __weak AssetDetailTableViewController *weakSelf = self;
//    
//    int64_t delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
////        [weakSelf.tableView beginUpdates];
////        [weakSelf.dataSource addObject:[weakSelf.dataSource.lastObject dateByAddingTimeInterval:-90]];
////        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
////        [weakSelf.tableView endUpdates];
//        [weakSelf.tableView.infiniteScrollingView stopAnimating];
//    });
//}

-(int)getChannelIDString:(NSString *)string
{
     //@"入账",@"成交",@"派息",@"提现"
    int chId = 0;
    if ([string isEqualToString:@"入账"]) {
        chId = 1;
    }else if ([string isEqualToString:@"成交"]) {
        chId = 2;
    }else if ([string isEqualToString:@"派息"]) {
        chId = 3;
    }else if ([string isEqualToString:@"提现"]) {
        chId = 4;
    }
    return chId;
}

-(void)refreshViewData{
    if ([array count] > 0) {
        return;
    }
    
    [ProgressHUD show:nil];
    //[self reloadData];
    [self.tableView headerBeginRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"the row is %ld",indexPath.row);
    NSLog(@"the array cout is %ld",array.count);
    
    static NSString * dentifier = @"cell";
    AssetRecordItemInfo * model = [array objectAtIndex:indexPath.row];

    AssetDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[AssetDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier withColumCount:model.count];
    }
    
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//-(void)loadMore
//{
//    if (isLoadingMore) {
//        [footerView.activeView startAnimating];
//        [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:0.1];
//        isLoadingMore = NO;
//        footerView.titleLabel.text = @"获取中...";
//    }
//}
//
//-(void)loadMoreData
//{
//    if (pageNum>10){
//        isCanLoadMore = YES; // signal that there won't be any more items to load
//    }else{
//        isCanLoadMore = NO;
//    }
//    
//    if (isCanLoadMore) {
//        [self loadMoreCompleted];
//    }else{
//        [self requestAddMoreNetWork];
//    }
//}
//
//-(void)reloadData
//{
//    [self requestNetWork];
//}

-(void)requestNetWork{
    //请求页面的信息
    pageNum = 1;
        
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:@"1" forKey:@"pageNow"];
    [connDictionary setObject:[NSString stringWithFormat:@"%d",channelId] forKey:@"queryFlag"];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,AssetInfoUrl];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    NSLog(@"connDictionary:%@",connDictionary);
    //[self showProgressViewWithMessage:@"正在请求数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         //[[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         [ProgressHUD dismiss];
         if([ret isEqualToString:@"100"])
         {
             
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             if (array == nil) {
                 array = [NSMutableArray new];
             }
             [array removeAllObjects];
             
            [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"assetData"] forKey:@"assetData"];
            NSArray *results = [responseJSONDictionary objectForKey:@"assetData"];
             
             nPos = 0;
             //数据标题部队，服务器返回，必有得数据
             NSDictionary *title = [responseJSONDictionary objectForKey:@"title"];
             AssetRecordItemInfo *titleInfo = [AssetRecordItemInfo new];
             titleInfo.nPosition = nPos;
             titleInfo.count = title.count;
             titleInfo.FirstItem = [[title objectForKey:@"money"] URLDecodedString];
             titleInfo.SecondItem = [[title objectForKey:@"time"] URLDecodedString];
             if (titleInfo.count == 3) {
                 titleInfo.ThirdItem = [[title objectForKey:@"type"] URLDecodedString];
             }
             else {
                 titleInfo.ThirdItem = [[title objectForKey:@"status"] URLDecodedString];
                 titleInfo.FourthItem = [[title objectForKey:@"type"] URLDecodedString];
             }
             [array addObject:titleInfo];
             
             //数据部分
             for (NSDictionary * sub in results) {
                 //NSLog(@"%@",sub);
                 
                 //缓存最新的资产信息
                 AssetRecordItemInfo *asset = [AssetRecordItemInfo new];
                 asset.count = sub.count;
                 asset.nPosition = ++ nPos;
                 asset.FirstItem = [NSString stringWithFormat:@"%@",[sub objectForKey:@"amount"]];
                 asset.SecondItem = [sub objectForKey:@"createtime"];

                 if ( asset.count == 3) {
                     NSString *temp =[sub objectForKey:@"type"];
                     asset.ThirdItem = [temp URLDecodedString];
                 }   
                 else{
                     asset.ThirdItem = [sub objectForKey:@"status"];
                     
                     NSString *temp =[sub objectForKey:@"type"];
                     asset.FourthItem = [temp URLDecodedString];
                 }
                 
                 [array addObject:asset];
             }
             pageNum ++;
             [self.tableView reloadData];
             
             
             // 2.2秒后刷新表格UI
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 // 刷新表格
                 //[self.tableView reloadData];
                 
                 // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                 [self.tableView headerEndRefreshing];
             });
             //[_tableView reloadData];
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

-(void)requestAddMoreNetWork{
    //__weak AssetDetailTableViewController *weakSelf = self;
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:[NSString stringWithFormat:@"%d",pageNum] forKey:@"pageNow"];
    [connDictionary setObject:[NSString stringWithFormat:@"%d",channelId] forKey:@"queryFlag"];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,AssetInfoUrl];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    //[self showProgressViewWithMessage:@"正在请求数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         //[[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         [ProgressHUD dismiss];
         if([ret isEqualToString:@"100"])
         {
             
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             //[[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"assetData"] forKey:@"assetData"];
             NSArray *results = [responseJSONDictionary objectForKey:@"assetData"];
             if (results.count == 0) {
                 //[weakSelf.tableView.infiniteScrollingView stopAnimating];
                 // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                 [self.tableView footerEndRefreshing];
                 return ;
             }
             
             //数据部分
             NSMutableArray * moreArray = [NSMutableArray new] ;
             for (NSDictionary * sub in results) {
                 //NSLog(@"%@",sub);
                 
                 //缓存最新的资产信息
                 AssetRecordItemInfo *asset = [AssetRecordItemInfo new];
                 asset.count = sub.count;
                 asset.nPosition = ++ nPos;
                 asset.FirstItem = [NSString stringWithFormat:@"%@",[sub objectForKey:@"amount"]];
                 asset.SecondItem = [sub objectForKey:@"createtime"];
                 
                 if ( asset.count == 3) {
                     NSString *temp =[sub objectForKey:@"type"];
                     asset.ThirdItem = [temp URLDecodedString];
                 }
                 else{
                     asset.ThirdItem = [sub objectForKey:@"status"];
                     
                     NSString *temp =[sub objectForKey:@"type"];
                     asset.FourthItem = [temp URLDecodedString];
                 }
                 
                 [moreArray addObject:asset];
             }
             
             [array addObjectsFromArray:moreArray];
             
             // 2.2秒后刷新表格UI
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 // 刷新表格
                 //[self.tableView reloadData];
                 [self.tableView beginUpdates];
                 
                 NSMutableArray *insertion = [[NSMutableArray alloc] init];
                 for (int i = 0 ; i< moreArray.count ; i++ ) {
                     [insertion addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                 }
                 [self.tableView insertRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationFade];
                 [self.tableView endUpdates];
                 
                 [self.tableView reloadData];
                 
                 // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                 [self.tableView footerEndRefreshing];
                 
                 
             });
             
             
             
//             //添加到array中
//             int64_t delayInSeconds = 1.0;
//             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                 
//                [weakSelf.tableView beginUpdates];
//
//                 NSMutableArray *insertion = [[NSMutableArray alloc] init];
//                 for (int i = 0 ; i< moreArray.count ; i++ ) {
//                     [insertion addObject:[NSIndexPath indexPathForRow:array.count + i inSection:0]];
//                 }
//                [weakSelf.tableView insertRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationNone];
//                [weakSelf.tableView endUpdates];
//                 
//                [weakSelf.tableView.infiniteScrollingView stopAnimating];
//             });
             
            pageNum ++;
             
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

//-(void)loadMoreCompleted
//{
//    isLoadingMore = YES;
//    if (isCanLoadMore) {
//        _tableView.tableFooterView = nil;
//    }else{
//        [footerView.activeView stopAnimating];
//    }
//}

#define DEFAULT_HEIGHT_OFFSET 44.0f
#pragma mark UIScrollViewDelegate
//- (void) scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (isLoadingMore && !isCanLoadMore) {
//        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
//        if (scrollPosition < DEFAULT_HEIGHT_OFFSET) {
//            [self loadMore];
//        }
//        else
//        {
//            [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
//        }
//
//    }else
//    {
//        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
//    }
//
//}

//#pragma mark Data Source Loading / Reloading Methods
//- (void)reloadTableViewDataSource{
//    
//    //  should be calling your tableviews data source model to reload
//    //  put here just for demo
//    [self reloadData];
//    _reloading = YES;
//    
//}
//
//- (void)doneLoadingTableViewData{
//    
//    //  model should call this when its done loading
//    _reloading = NO;
//    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
//    
//}
//
//
//#pragma mark -
//#pragma mark UIScrollViewDelegate Methods
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [_refreshHeaderView egoRefreshScrollViewWillBeginScroll:scrollView];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
//    
//}
//
//
//#pragma mark -
//#pragma mark EGORefreshTableHeaderDelegate Methods
//
//- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
//    
//    [self reloadTableViewDataSource];
//    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
//    
//}
//
//- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
//    
//    return _reloading; // should return if data source model is reloading
//    
//}
//
//- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
//    
//    return [NSDate date]; // should return date data source was last changed
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
