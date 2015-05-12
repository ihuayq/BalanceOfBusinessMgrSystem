//
//  UIAssetsTableViewCell.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyledTableViewCell.h"
@class UIAssetsPageCell;
@interface UITotalAssetsTableViewCell : StyledTableViewCell{
    
    UILabel * titleLabel;
    UILabel * moneyLabel;
}

@property (nonatomic,copy) NSString * money;
@end


@interface UIOldAssetsTableViewCell : StyledTableViewCell{
    UILabel * titleLabel;
    UILabel * moneyLabel;
}

@property (nonatomic,copy) NSString * money;
@end


@interface UIOtherAssetsTableViewCell : StyledTableViewCell{
    
    UIAssetsPageCell *principalCell;
    UIAssetsPageCell *receiptsCell;
}

@property (nonatomic,copy) NSString * principalMoney;
@property (nonatomic,copy) NSString * receiptsMoney;

@end
