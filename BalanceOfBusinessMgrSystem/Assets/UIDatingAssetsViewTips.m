//
//  UIDatingAssetsViewCell.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "UIDatingAssetsViewTips.h"
#import "UIAssetsPageCell.h"
#pragma 预约资产表

@implementation UIDatingAssetsViewTips


- (id)initWithFrame:(CGRect)frame leftUIImage:(UIImage *)leftUIImage titleText:(NSString*) titleText numText:(NSString*) numText
{
    self = [super initWithFrame:frame];
    if (self) {
        principalCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height) leftUIImage:[UIImage imageNamed:@"理财本金.png"] titleText:(NSString*)@"理财本金（元）" numText:(NSString*) @"0.00"];
        [principalCell.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
        [principalCell.layer setBorderWidth:0.5f];
        [self addSubview:principalCell];
//
//        
//        receiptsCell = [[UIAssetsPageCell alloc] initWithFrame:CGRectMake( self.frame.size.width/2,0 ,self.frame.size.width/2, self.frame.size.height*2 -9)  leftUIImage:[UIImage imageNamed:@"累计收益.png"] titleText:(NSString*)@"理财收益（元）" numText:(NSString*) @"0.00"];
//        [receiptsCell.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
//        [receiptsCell.layer setBorderWidth:0.5f];
//        //receiptsCell.backgroundColor = [UIColor orangeColor];
//        [self addSubview:receiptsCell];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
