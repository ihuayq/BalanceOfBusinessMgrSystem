//
//  ViewController.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/5.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoadingGuidType) {
    NATUREMAN_GUIDE,                //自然人引导页
    SUPPLYER_GUIDE,                 //商户引导页
    GLOBE_GUIDE                     //整个app系统引导页
};

@interface GuidViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,assign) LoadingGuidType type;
@end

