//
//  bindBalanceAccountViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bindBalanceAccountViewController :FMBaseViewController<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) NSMutableArray *networkAccountSelect;
//@property (nonatomic,strong) NSMutableArray *balanceAccountSelect;
//@property (nonatomic,strong) NSMutableArray *group;
@property (nonatomic,strong)  NSMutableArray *groupNetWork;//cell数组
@property (nonatomic,strong)  NSMutableArray *groupBalance;

@end
