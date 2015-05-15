//
//  AssetDetailTableViewCell.h
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/14.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetRecordItemInfo.h"

@interface AssetDetailTableViewCell : UITableViewCell{
    UILabel * FirstLabel;
    UILabel * SecondLabel;
    UILabel * ThirdLabel;
    UILabel * FourthLabel;
}

@property (nonatomic,strong) AssetRecordItemInfo *model;
@property (nonatomic,assign) uint labelCount;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withColumCount:(uint)columCount;

@end
