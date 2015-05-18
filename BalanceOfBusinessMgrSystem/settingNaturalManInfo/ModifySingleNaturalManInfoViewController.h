//
//  ModifySingleNaturalManInfoViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/13.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifySingleNaturalManInfoViewController : FMBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSString *natureName;
@property (nonatomic,copy) NSString *identifyNo;
@property (nonatomic,copy) NSString *telephoneNo;
@property (nonatomic,assign) uint nPos;


@end
