//
//  BMAccountCellInfo.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMAccountCellInfo : NSObject
#pragma mark 标签名
@property (nonatomic,copy) NSString *title;


-(BMAccountCellInfo *)initWithFirstName:(NSString *)title;

#pragma mark 带参数的静态对象初始化方法
+(BMAccountCellInfo *)initWithFirstName:(NSString *)title;

@end



@interface BMAccountCellGroup : NSObject

#pragma mark 组名
@property (nonatomic,copy) NSString *name;

#pragma mark 分组描述
@property (nonatomic,copy) NSString *detail;

#pragma mark 联系人
@property (nonatomic,strong) NSMutableArray *groups;


-(BMAccountCellGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)groups;

+(BMAccountCellGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)groups;

@end