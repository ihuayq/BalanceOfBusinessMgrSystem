//
//  NaturalManInfoTableViewCell.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyledTableViewCell.h"
#import "NaturalManItemModel.h"

@interface NaturalManInfoTableViewCell : StyledTableViewCell

@property (nonatomic,strong) NaturalManItemModel * model;

@end