//
//  BMEarningMainPageViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TotalAssetInfoModel.h"

@interface BMAssetsMainPageViewController : HP_BaseViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) TotalAssetInfoModel * assetInfo;

@end
