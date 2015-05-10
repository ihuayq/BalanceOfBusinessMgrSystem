//
//  NetworkPointAccountTableViewCell.h
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyledTableViewCell.h"

@interface BankAccountTableViewCell : StyledTableViewCell
{

}

#pragma mark 标签名
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *bankName;
@property (nonatomic,copy) NSString *bankCardNumber;
@property (nonatomic,assign) bool bSelected;
@end
