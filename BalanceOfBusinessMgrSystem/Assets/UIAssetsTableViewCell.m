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
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.contentView.size.width-30, 30)];
        titleLabel.font = [UIFont systemFontOfSize:18.0f];
        titleLabel.text = @"总资产（元）";
        [self.contentView addSubview:titleLabel];

        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (MainHeight-48.5f - 64.0f)/5 * 1.5 /2 -30, self.contentView.size.width, 60)];
        moneyLabel.font = [UIFont systemFontOfSize:36.0f];
        moneyLabel.textColor =  UIColorFromRGB(0xF9551C);
        moneyLabel.text = @"0.00";
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:moneyLabel];
    }
    return self;
}


-(void)setMoney:(NSString *)money{
    _money = money;
    
    if ([money isEqualToString:@"0"]) {
        moneyLabel.text = @"0.00";
    }
    else{
        moneyLabel.text = _money;
    }
    
}
@end


@implementation UIOldAssetsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 4, self.contentView.size.width-30, 30)];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.text = @"昨日收益（元）";
        [self.contentView addSubview:titleLabel];
        
        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.size.height+titleLabel.origin.y-4, self.contentView.size.width, titleLabel.size.height)];
        moneyLabel.font = [UIFont systemFontOfSize:24.0f];
        moneyLabel.textColor = UIColorFromRGB(0xF9551C);
        moneyLabel.text = @"0.00";
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:moneyLabel];
    }
    return self;
}

-(void)setMoney:(NSString *)money{
    _money = money;
    if ([money isEqualToString:@"0"]) {
        moneyLabel.text = @"0.00";
    }
    else{
        moneyLabel.text = _money;
    }
}

@end


@implementation UIOtherAssetsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        principalCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(0, 0, self.contentView.size.width/2, (MainHeight-48.5f - 64.0f)/5) leftUIImage:[UIImage imageNamed:@"licaibenjin"] titleText:(NSString*)@"理财本金（元）" numText:(NSString*) @"0.00"];
        [self.contentView addSubview:principalCell];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.contentView.size.width/2, 0, 0.5, (MainHeight-48.5f - 64.0f)/5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
        
        receiptsCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake( self.contentView.size.width/2,0 ,self.contentView.size.width/2, (MainHeight-48.5f - 64.0f)/5)  leftUIImage:[UIImage imageNamed:@"leijishouyi"] titleText:(NSString*)@"累计收益（元）" numText:(NSString*) @"0.00"];
//        [receiptsCell.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
//        [receiptsCell.layer setBorderWidth:0.5f];
        [self.contentView addSubview:receiptsCell];
    }
    return self;
}


-(void)setPrincipalMoney:(NSString *)principalMoney{
    _principalMoney = principalMoney;
    principalCell.moneyNum = principalMoney;
}

-(void)setReceiptsMoney:(NSString *)receiptsMoney{
    _receiptsMoney = receiptsMoney;
    receiptsCell.moneyNum = receiptsMoney;
    
}

@end

