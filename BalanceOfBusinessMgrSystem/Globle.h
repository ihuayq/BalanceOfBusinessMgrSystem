//
//  Globle.h
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NatureManEntranceType) {
    ADD_NATUREMAN_ENTRANCE,                  //
    MODIFY_NATUREMAN_ENTRANCE,                 //
    NOABLE_MODIFY_NATUREMAN_ENTRANCE
};

@interface Globle : NSObject

+(Globle*)shareGloble;

@property (nonatomic,assign) NatureManEntranceType whichBalanceAccountEntranceType;//结算账号入口类型
@property (nonatomic,assign) BOOL isCanModifyBalanceAccount;////结算账号可修改类型

@property (nonatomic,assign) BOOL isApplicationEnterBackground;

@property (nonatomic,assign) NSIndexPath * index;

@end
