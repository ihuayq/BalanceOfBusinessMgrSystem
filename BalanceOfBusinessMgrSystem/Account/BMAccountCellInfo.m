//
//  BMAccountCellInfo.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMAccountCellInfo.h"

@interface BMAccountCellInfo ()

@end

@implementation BMAccountCellInfo
-(BMAccountCellInfo *)initWithFirstName:(NSString *)title{
    if (self=[super init]) {
        self.title=title;
     }
    return self;
}

+(BMAccountCellInfo *)initWithFirstName:(NSString *)title{
    BMAccountCellInfo *cell = [[BMAccountCellInfo alloc] initWithFirstName:title];
    return cell;
}


@end


#pragma mark 分组描述
@implementation BMAccountCellGroup


-(BMAccountCellGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)groups{
    if (self=[super init]) {
        self.name=name;
        self.detail=detail;
        self.groups=groups;
    }
    return self;
}

+(BMAccountCellGroup *)initWithName:(NSString *)name andDetail:(NSString *)detail andContacts:(NSMutableArray *)groups{
    BMAccountCellGroup *group1=[[BMAccountCellGroup alloc]initWithName:name andDetail:detail andContacts:groups];
    return group1;
}
@end
