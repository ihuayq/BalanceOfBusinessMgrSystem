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
@end


@interface UIOldAssetsTableViewCell : StyledTableViewCell{
    UILabel * titleLabel;
    UILabel * moneyLabel;
}
@end


@interface UIOtherAssetsTableViewCell : StyledTableViewCell{
    
    UIAssetsPageCell *principalCell;
    UIAssetsPageCell *receiptsCell;
}
@end
