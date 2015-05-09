//
//  DjyBaseView.h
//  动画测试
//
//  Created by Davidsph on 5/29/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <UIKit/UIKit.h>


#define ALL_AnimationView_Frame  CGRectMake(187, 82, 99, 79)

@interface DjyBaseView : UIView

// 0 I 版 1 S版


@property(nonatomic,assign)NSInteger animationType;

-(void)beginAnimation;

-(void)changeBackImage:(NSInteger )businessType;

-(void)stopAnimation;

-(void)changeFrameToZore;

- (id) initWithFrame:(CGRect)frame animationtype:(NSInteger) animatType ;

- (id) initWithFrame:(CGRect)frame animationtype:(NSInteger) animatType andBusType:(NSInteger) busType;


@end
