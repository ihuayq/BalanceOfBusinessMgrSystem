//
//  ModifySingleNaturalManInfoViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/13.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"
@class NaturalManItemModel;
@interface ModifySingleNaturalManInfoViewController : HP_BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NaturalManItemModel *model;

@property (nonatomic,copy) NSString *natureName;
@property (nonatomic,copy) NSString *identifyNo;
@property (nonatomic,copy) NSString *telephoneNo;
@property (nonatomic,assign) uint nPos;//personid


@end
