//
//  TotalAssetInfoModel.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/12.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TotalAssetInfoModel : NSObject

@property (nonatomic,copy) NSString *totalAssets;
@property (nonatomic,copy) NSString *oldProfit;
@property (nonatomic,copy) NSString *curPrincipal;
@property (nonatomic,copy) NSString *curProfit;

@property (nonatomic,copy) NSString *historyProfit;
@property (nonatomic,copy) NSString *futurePrincipal;

@end


