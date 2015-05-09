//
//  DjyInputPwdAniView.m
//  动画测试
//
//  Created by Davidsph on 6/4/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "DjyInputPwdAniView.h"


@interface DjyInputPwdAniView ()
{
    
    UIImageView *handImageView;
    UIImageView *keyBoardView;
    UIImageView *circleView;
    UIView *baseViewOfCircleAndKeyBoard;
    
    CGRect baseViewOriginFrame;
    
    CGAffineTransform circleOrginTransform; //圆环
    
    CGAffineTransform baseViewTransform; //圆环和小手
    
    
}
@end
@implementation DjyInputPwdAniView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.clipsToBounds = YES;
        self.autoresizesSubviews = YES;
        
        
        //背景键盘
        keyBoardView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,52, 54)];
        keyBoardView.image = [UIImage imageNamed:@"200x120_键盘.png"];
        
        keyBoardView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:keyBoardView];
        
        //小手和圆环的父视图
        baseViewOfCircleAndKeyBoard = [[UIView alloc] initWithFrame:CGRectMake(8,30, 31, 29)];
        
        baseViewOfCircleAndKeyBoard.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
        
        baseViewTransform = baseViewOfCircleAndKeyBoard.transform;
        
        
        baseViewOfCircleAndKeyBoard.clipsToBounds =YES;
        
        
        baseViewOriginFrame = baseViewOfCircleAndKeyBoard.frame;
        
        //小手
        handImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6,4, 15, 25)];
        handImageView.contentMode = UIViewContentModeScaleAspectFit;
        handImageView.image =[UIImage imageNamed:@"200x120_小手.png"];
        
        [baseViewOfCircleAndKeyBoard addSubview:handImageView];
        //圆环
        circleView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 4, 8, 8)];
        circleView.contentMode =UIViewContentModeScaleAspectFit;
        circleView.image =[UIImage imageNamed:@"椭圆-4@2x.png"];
        circleView.alpha = 0;
        circleOrginTransform = circleView.transform;
        [baseViewOfCircleAndKeyBoard addSubview:circleView];
        
        [self addSubview:baseViewOfCircleAndKeyBoard];
        
        baseViewOfCircleAndKeyBoard.alpha = 0.0;
        
    }
    return self;
}


//开始圆环动画 仿射变换参数 以及动画结束后 要之下那个的下一个动画
- (void) begainCircleAnimationWithTransform:(CGAffineTransform) newTransform goToSlecetor:(SEL) selector
{
    
    circleView.alpha = 1.0;
    CGAffineTransform  transform;
    
    //有参照
    transform=CGAffineTransformScale(circleView.transform, 1.4, 1.4);
    
    [UIView animateWithDuration:0.5 animations:^{
        circleView.alpha = 0.0;
        circleView.transform=transform;
    } completion:^(BOOL finished) {
        
        circleView.alpha = 0.0;
        circleView.transform = circleOrginTransform;
        
        if (selector) {
            [self performSelector:selector];
        }
        
    }];
    
}

//开始手指的动画 x y 分别表示 在x轴和Y轴移动的距离

- (void)begainBaseHandViewAnimationWithX_value:(CGFloat)xValue andY_Value:(CGFloat) yValue {
    
    baseViewOfCircleAndKeyBoard.alpha = 1.0;
    //取得仿射变换矩阵
    CGAffineTransform transform;
    
    //参照来做平移操作
    transform=CGAffineTransformTranslate(baseViewOfCircleAndKeyBoard.transform, xValue, yValue);
    
    baseViewOfCircleAndKeyBoard.transform = transform;
    
    
    
}

//第一个动画
- (void) firstAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        [self begainBaseHandViewAnimationWithX_value:-4 andY_Value:-15];
        
        
    } completion:^(BOOL finished) {
        
        
        [self begainCircleAnimationWithTransform:circleView.transform goToSlecetor:@selector(secondAniamtion)];
        
    }];
    
}

//第二个动画
- (void) secondAniamtion{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        [self begainBaseHandViewAnimationWithX_value:15 andY_Value:-12];
        
        
    } completion:^(BOOL finished) {
        
        [self begainCircleAnimationWithTransform:circleView.transform goToSlecetor:@selector(thirdAnimation)];
        
    }];
    
    
}

//第三个动画
- (void) thirdAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self begainBaseHandViewAnimationWithX_value:18 andY_Value:13];
        
        
    } completion:^(BOOL finished) {
        [self begainCircleAnimationWithTransform:circleView.transform goToSlecetor:@selector(fourthAnomation)];
        
    }];
    
}

//第四个动画
- (void) fourthAnomation{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self begainBaseHandViewAnimationWithX_value:-16 andY_Value:9];
        
    } completion:^(BOOL finished) {
        
        [self begainCircleAnimationWithTransform:circleView.transform goToSlecetor:@selector(begainAllAnimationAgain)];
    }];
}

//重新开始所有动画
- (void) begainAllAnimationAgain{
    
    
    baseViewOfCircleAndKeyBoard.transform = baseViewTransform;
    baseViewOfCircleAndKeyBoard.alpha = 0;
    
    [self firstAnimation];
    
}

- (void) beginAnimation{
    
    [self firstAnimation];
    
}

- (void) changeFrameToZore{
    
    
}


@end
