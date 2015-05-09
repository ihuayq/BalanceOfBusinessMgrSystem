//
//  HP_UITextField.h
//  youyouapp
//
//  Created by 融通互动 on 12-12-3.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HP_UITextField : UITextField

@property(nonatomic) UIEdgeInsets insets;

@property BOOL hasChangePlaceHolderColor;

@property BOOL hasChangePlaceHolderFont;

@property(nonatomic,retain) UIColor *placeHolderColor;

@property(nonatomic,retain) UIFont *placeHolderFont;

/*
    str:textField默认文字
    flag: YES为带有消除文字键，NO为没有消除文字键
*/
-(void)setPlaceholder:(NSString *)str andClearButton:(BOOL)flag;

//- (CGRect)textRectForBounds:(CGRect)bounds ;
//控制文本的位置

//- (CGRect)editingRectForBounds:(CGRect)bounds;

@end
