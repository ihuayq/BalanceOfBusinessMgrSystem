//
//  MovieTableViewController.h
//  FreeMusic
//
//  Created by 华永奇 on 15/4/8.
//  Copyright (c) 2015年 xiaozi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCNavTabBar.h"
#import "EGORefreshTableHeaderView.h"


@interface AssetDetailTableViewController : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    BOOL _reloading;
}



@property (retain, nonatomic)  UITableView *tableView;

- (void)refreshViewData;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
