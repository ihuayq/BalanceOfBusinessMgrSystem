//
//  HP_UILabel.h
//  blog
//
//  Created by Yi Xu on 12-11-26.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HP_UILabel : UILabel

@property(nonatomic) BOOL isUnderline;
@property(nonatomic,retain) UIColor *underLineColor ;
@property(nonatomic) UIEdgeInsets insets;

//根据内边距初始化UILabel
- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets) insets;

//根据内边距初始化UILabel
- (id)initWithInsets:(UIEdgeInsets) insets;

@end
