//
//  UIAssetsPageCell.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAssetsPageCell : UIView {
    

}

@property (nonatomic,strong)   UIImageView *imageLeftView;

@property (nonatomic,strong)   UILabel * titleLabel;
//Reiceipts 收益
@property (nonatomic,strong)   UILabel * numLabel;


- (id)initWithFrame:(CGRect)frame leftUIImage:(UIImage *)leftUIImage titleText:(NSString*) titleText numText:(NSString*) numText;

@end
