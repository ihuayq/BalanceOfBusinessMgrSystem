//
//  bindAccountConfirmViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

@interface bindAccountConfirmViewController:HP_BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *balanceAccountSelected;
@property (nonatomic,strong) NSMutableArray *networkAccountSelected;

@end
