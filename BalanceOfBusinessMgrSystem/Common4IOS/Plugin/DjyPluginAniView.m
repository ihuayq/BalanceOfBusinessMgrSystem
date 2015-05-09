//
//  DjyPluginAniView.m
//  动画测试
//
//  Created by Davidsph on 5/29/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "DjyPluginAniView.h"

#define Animation_Height 11
#define Animation_UP_duration 0.8

#define Animation_Down_duration 0.5

@interface DjyPluginAniView ()

{
    
    UIImageView *boxImageView;
    
    UIImageView *phoneImageView;
    
    CGRect originFrame;
    
    CGAffineTransform originBoxTransform;
    
    
}

@end
@implementation DjyPluginAniView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}



- (id) initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        NSString *boxImageName = @"200x120_红盒";
        
        CCLog(@"animationType= %d",animatType);
        
        if (animatType == 1) {
            
            boxImageName = @"200x120_蓝盒";
        }
        
        //self CGRectMake(16, -10, 50, 30)
        boxImageView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 20, 27)];
        boxImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:boxImageName ofType:@"png"]];
        boxImageView.contentMode = UIViewContentModeScaleAspectFit;
        originFrame = boxImageView.frame;
        originBoxTransform = boxImageView.transform;
        [self addSubview:boxImageView];
        
        phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 45, 45, 13)];
        //        phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
        phoneImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"200x120_iPhoneTop" ofType:@"png"]];
        [self addSubview:phoneImageView];
    }
    return self;
    
    
    
    
}

- (void) upAnimation{
    
    
    
    [UIView animateWithDuration:0.05 animations:^{
        
      
        //取得仿射变换矩阵
        CGAffineTransform transform;
        
        //参照来做平移操作
        transform=CGAffineTransformTranslate(boxImageView.transform, 0, -13);
        
        boxImageView.transform = transform;

        
    } completion:^(BOOL finished) {
        
        
        [self downAnimation];
        
    }];
    
}


- (void) downAnimation{
    
    
    [UIView animateWithDuration:1.8 animations:^{
        
        
        //取得仿射变换矩阵
        CGAffineTransform transform;
        
        //参照来做平移操作
        transform=CGAffineTransformTranslate(boxImageView.transform, 0, 13);
        
        boxImageView.transform = transform;
        
        
    } completion:^(BOOL finished) {
        
        [self upAnimation];

//        [UIView animateWithDuration:0.8 animations:^{
//            
//        } completion:^(BOOL finished) {
//            
//            [self upAnimation];
//        }];
        
    }];
 
}

- (void) beginAnimation{
    
    [self downAnimation];
    
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
