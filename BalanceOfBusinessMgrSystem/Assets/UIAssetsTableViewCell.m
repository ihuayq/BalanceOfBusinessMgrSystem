//
//  UIAssetsTableViewCell.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "UIAssetsTableViewCell.h"
#import "UIAssetsPageCell.h"
#import "UIView+Additions.h"

@implementation UITotalAssetsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, self.contentView.size.width-30, 30)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        titleLabel.text = @"总资产（元）";
        [self.contentView addSubview:titleLabel];

        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.origin.x + 160, titleLabel.size.height+titleLabel.origin.y+5, titleLabel.size.width, titleLabel.size.height-10)];
        moneyLabel.font = [UIFont systemFontOfSize:18.0f];
        //moneyLabel.textColor = [UIColor lightGrayColor];
        moneyLabel.text = @"0.00";
        
        [self.contentView addSubview:moneyLabel];
    }
    return self;
}

@end


@implementation UIOldAssetsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;

        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, self.contentView.size.width-30, 30)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        titleLabel.text = @"昨日收益（元）";
        [self.contentView addSubview:titleLabel];
        
        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.origin.x + 160, titleLabel.size.height+titleLabel.origin.y+5, titleLabel.size.width, titleLabel.size.height-10)];
        moneyLabel.font = [UIFont systemFontOfSize:18.0f];
        //moneyLabel.textColor = [UIColor lightGrayColor];
        moneyLabel.text = @"0.00";
        
        [self.contentView addSubview:moneyLabel];
    }
    return self;
}

@end


@implementation UIOtherAssetsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        principalCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(0, 0, self.contentView.size.width/2, self.contentView.size.height*2 -9) leftUIImage:[UIImage imageNamed:@"理财本金.png"] titleText:(NSString*)@"理财本金（元）" numText:(NSString*) @"0.00"];
        [principalCell.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
        [principalCell.layer setBorderWidth:0.5f];
        [self.contentView addSubview:principalCell];
        
        
        receiptsCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake( self.contentView.size.width/2,0 ,self.contentView.size.width/2, self.contentView.size.height*2 -9)  leftUIImage:[UIImage imageNamed:@"累计收益.png"] titleText:(NSString*)@"理财收益（元）" numText:(NSString*) @"0.00"];
        [receiptsCell.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
        [receiptsCell.layer setBorderWidth:0.5f];
        receiptsCell.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:receiptsCell];
        
    }
    return self;
}
@end

