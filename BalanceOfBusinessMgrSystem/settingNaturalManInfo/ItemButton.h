//
//  ItemButton.h
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/17.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemButton : UIButton

//typedef enum {
//    kLivelyButtonStyleSelectOn,
//    kLivelyButtonStyleSelectClose,
//
//} kLivelyButtonStyle;
//
//
//-(kLivelyButtonStyle) buttonStyle;
//
//-(void) setStyle:(kLivelyButtonStyle)style animated:(BOOL)animated;

@property (nonatomic,setter=setIsSelected:) BOOL isSelected;

- (id)initWithFrame:(CGRect)frame withSelect:(BOOL)selected;
-(void) switchStatus;


@end
