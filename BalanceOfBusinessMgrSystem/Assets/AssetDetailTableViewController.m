//
//  MovieTableViewController.m
//  FreeMusic
//
//  Created by 华永奇 on 15/4/8.
//  Copyright (c) 2015年 xiaozi. All rights reserved.
//

#import "AssetDetailTableViewController.h"
//#import "FMLoadMoreFooterView.h"
//#import "FMSongListTableViewCell.h"
//#import "FMMusicViewController.h"
//#import "FMTDMovieModel.h"
//#import "FMTDMovieViewController.h"
//#import "DropDownListView.h"
//#import "FMTDTableViewCell.h"
//#import "FMTDSearchViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "ProgressHUD.h"

@interface AssetDetailTableViewController ()<UIScrollViewDelegate>
{
    BOOL isLoadingMore;
    BOOL isCanLoadMore;
    //FMLoadMoreFooterView * footerView;
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
//    footerView = [[FMLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, _tableView.size.width, 70)];
//    _tableView.tableFooterView = footerView;
    
//    list_total = 10;
//    channelId = [self getChannelIDString:self.title];
//    pageNum = 1;
//    sort = @"v";
    
    if (channelId == 99) {
        [self loadMoreData];
    }
    //[self loadMoreData];
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
    //return [array count];
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    UITableViewCell *cell = cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
//    FMTDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
//    if (cell == nil) {
//        cell = [[FMTDTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
//    }
//    FMTDMovieModel * model = [array objectAtIndex:indexPath.row];
//    cell.model = model;
    cell.textLabel.text = @"huayq";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FMTDMovieModel* model = [array objectAtIndex:indexPath.row];
//    FMTDMovieViewController * pushController = [[FMTDMovieViewController alloc] init];
//    pushController.model = model;
//    [self.navigationController pushViewController:pushController animated:YES];
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
//    if (isLoadingMore) {
//        [footerView.activeView startAnimating];
//        list_total+=10;
//        [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:0.1];
//        isLoadingMore = NO;
//        footerView.titleLabel.text = @"获取中...";
//    }
}
-(void)loadMoreData
{
    if (list_total>50){
        //        if (pageNum ==2) {
        //            pageNum =1;
        //            list_total =20;
        //        }else{
        //            list_total = 20;
        //            pageNum =2;
        //        }
        isCanLoadMore = YES; // signal that there won't be any more items to load
    }else{
        isCanLoadMore = NO;
    }
    
    if (isCanLoadMore) {
        [self loadMoreCompleted];
    }else{
//        MCDataEngine * network = [MCDataEngine new];
//        [network getTDMovieListWith:pageNum :list_total :channelId :sort WithCompletionHandler:^(FMTDMovieList *movieList) {
//            [ProgressHUD dismiss];
//            array = movieList.movieLists;
//            [_tableView reloadData];
//            [self loadMoreCompleted];
//        } errorHandler:^(NSError *error) {
//            [ProgressHUD showError:@"服务器错误"];
//        }];
    }
}

-(void)loadMoreCompleted
{
    isLoadingMore = YES;
    if (isCanLoadMore) {
        _tableView.tableFooterView = nil;
    }else{
//        [footerView.activeView stopAnimating];
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

@end
