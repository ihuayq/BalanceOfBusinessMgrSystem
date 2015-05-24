//
//  bindNetworkPointAccountViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

@interface bindNetworkPointAccountViewController : HP_BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)  NSMutableArray *groupNetWork;//网点账号
@property (nonatomic,strong)  NSMutableArray *groupBalance;//结算账号


@end
