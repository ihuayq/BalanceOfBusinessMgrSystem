//
//  ModifyNaturalManIdentifyInfoViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/18.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"
typedef void (^ReturnTextBlock)(NSString *nameText,NSString *identifyText);

@class NaturalManItemModel;
@interface ModifyNaturalManIdentifyInfoViewController : HP_BaseViewController

@property (nonatomic,strong) NaturalManItemModel *model;

@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

- (void)returnText:(ReturnTextBlock)block;

@end
