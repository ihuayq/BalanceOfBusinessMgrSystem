//
//  BankAccountItem.h
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/17.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankAccountItem : NSObject
@property (nonatomic,copy) NSString *siteNum;
@property (nonatomic,copy) NSString *accountName;
@property (nonatomic,copy) NSString *bankName;
@property (nonatomic,copy) NSString *bankCardNumber;
@property (nonatomic,assign) bool bSelected;
@property (nonatomic,assign) bool bNetworkSelected;
@end
