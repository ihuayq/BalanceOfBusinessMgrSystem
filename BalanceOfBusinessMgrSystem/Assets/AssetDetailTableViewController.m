//
//  MovieTableViewController.m
//  FreeMusic
//
//  Created by 华永奇 on 15/4/8.
//  Copyright (c) 2015年 xiaozi. All rights reserved.
//

#import "AssetDetailTableViewController.h"
#import "FMLoadMoreFooterView.h"
//#import "FMSongListTableViewCell.h"
//#import "FMMusicViewController.h"
//#import "FMTDMovieModel.h"
//#import "FMTDMovieViewController.h"
//#import "DropDownListView.h"
//#import "FMTDTableViewCell.h"
//#import "FMTDSearchViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "ProgressHUD.h"
#import "AssetDetailTableViewCell.h"
#import "NSString+Utf8Encoding.h"
#import "Util.h"

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
    
}

@end

@implementation AssetDetailTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-48.5f - 44.0f)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *vieweg = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -120, MainWidth, 120)];
        vieweg.delegate = self;
        //[self.view insertSubview:vieweg belowSubview:self.tableView];
        [_tableView addSubview:vieweg];
        _refreshHeaderView = vieweg;
        
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
    
    footerView = [[FMLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 70)];
    _tableView.tableFooterView = footerView;
    
    list_total = 10;
    channelId = [self getChannelIDString:self.title];
//    pageNum = 1;
//    sort = @"v";
    //[self requestNetWork];
    if (channelId == 1) {
        [self loadMoreData];
    }
}

-(int)getChannelIDString:(NSString *)string
{
    int chId = 0;
    if ([string isEqualToString:@"预约"]) {
        chId = 1;
    }else if ([string isEqualToString:@"派息"]) {
        chId = 2;
    }else if ([string isEqualToString:@"成交"]) {
        chId = 3;
    }else if ([string isEqualToString:@"提现"]) {
        chId = 3;
    }
    return chId;
}

-(void)refreshViewData{
    if ([array count] > 0) {
        return;
    }
    
    [ProgressHUD show:nil];
    [self loadMoreData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
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
}

#define DEFAULT_HEIGHT_OFFSET 44.0f
#pragma mark UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoadingMore && !isCanLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if (scrollPosition < DEFAULT_HEIGHT_OFFSET) {
            [self loadMore];
        }
        else
        {
            [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        }
        
    }else
    {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
}
-(void)loadMore
{
    if (isLoadingMore) {
        [footerView.activeView startAnimating];
        list_total+=10;
        [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:0.1];
        isLoadingMore = NO;
        footerView.titleLabel.text = @"获取中...";
    }
}
-(void)loadMoreData
{
    if (list_total>50){
        //if (pageNum ==2) {
        //    pageNum =1;
        //    list_total =20;
        //}else{
        //    list_total = 20;
        //    pageNum =2;
        //}
        isCanLoadMore = YES; // signal that there won't be any more items to load
    }else{
        isCanLoadMore = NO;
    }
    
    if (isCanLoadMore) {
        [self loadMoreCompleted];
    }else{
        [self requestNetWork];
    }
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
    [connDictionary setObject:[NSString stringWithFormat:@"%d",channelId] forKey:@"queryFlag"];
    
    NSString *url =[NSString stringWithFormat:@"%@",AssetInfoUrl];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    
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
             
             //数据标题部队，服务器返回，必有得数据
             NSDictionary *title = [responseJSONDictionary objectForKey:@"title"];
             AssetRecordItemInfo *titleInfo = [AssetRecordItemInfo new];
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
                 NSLog(@"%@",sub);
                 
                 //缓存最新的资产信息
                 AssetRecordItemInfo *asset = [AssetRecordItemInfo new];
                 asset.count = sub.count;
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
             
              [_tableView reloadData];
             
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

-(void)loadMoreCompleted
{
    isLoadingMore = YES;
    if (isCanLoadMore) {
        _tableView.tableFooterView = nil;
    }else{
        [footerView.activeView stopAnimating];
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    [self loadMoreData];
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewWillBeginScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

@end
