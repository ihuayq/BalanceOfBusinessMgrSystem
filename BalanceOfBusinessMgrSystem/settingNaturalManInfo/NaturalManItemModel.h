//
//  NaturalManItemModel.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NaturalManItemModel : NSObject
@property (nonatomic,assign) uint nPosition;

@property (nonatomic,copy) NSString *personID;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *manName;
@property (nonatomic,copy) NSString *identifyNumber;
@property (nonatomic,copy) NSString *telephoneNumber;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,assign) bool bCanModify;

@end


@interface ManInfoList : NSObject

@property (nonatomic,retain) NSMutableArray * manInfoLists;
@property (nonatomic,assign) int totalCount;

@end