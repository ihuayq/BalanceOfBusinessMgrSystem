//
//  DJYICReadCardInfoAniView.m
//  ipaycard
//
//  Created by Davidsph on 6/7/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYICReadCardInfoAniView.h"

#define Animation_Width 68

#define Animation_Left_duration 0.8

#define Animation_Right_duration 0.6


@interface DJYICReadCardInfoAniView ()
{
    
    UIImageView *bigGlassImageView;
    
    UIImageView *icCardImageView;
    
    CGRect originFrame;
    
    CGAffineTransform originBoxTransform;
    
}
@end
@implementation DJYICReadCardInfoAniView


-(id)initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType andBusType:(NSInteger)busType
{
    self = [super initWithFrame:frame];
    if (self) {
        
        icCardImageView = [[UIImageView alloc] init ];
        icCardImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        bigGlassImageView =[[UIImageView alloc] init ];

        
        if (animatType == 0) {
            icCardImageView.frame  = CGRectMake(36, 51, 191, 128);
            bigGlassImageView.frame = CGRectMake(104, 94, 69, 69);
            icCardImageView.image = [UIImage imageNamed:@"anim_ic-正面.png"];
        }else{
            icCardImageView.frame  = CGRectMake(36, 81, 191, 128);
            bigGlassImageView.frame = CGRectMake(104, 124, 69, 69);
            icCardImageView.image = [UIImage imageNamed:@"560x540_IC卡left.png"];
        }
        
        if (busType == 0) {
            icCardImageView.image = [UIImage imageNamed:@"ic卡.png"];
        }else if(busType == 1){
            icCardImageView.image = [UIImage imageNamed:@"金融卡.png"];
        }
        
        [self addSubview:icCardImageView];
        
        NSString *boxImageName = @"560x540_放大锯.png";
        
        
        bigGlassImageView.image = [UIImage imageNamed:boxImageName];
        bigGlassImageView.contentMode = UIViewContentModeScaleAspectFit;
        originBoxTransform = bigGlassImageView.transform;
        originFrame = bigGlassImageView.frame;
        
        [self addSubview:bigGlassImageView];
        
    }
    return self;
}

- (void) leftAnimation{
    
    [UIView animateWithDuration:Animation_Left_duration delay:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //取得仿射变换矩阵
        CGAffineTransform transform;
        
        //参照来做平移操作
        transform=CGAffineTransformTranslate(bigGlassImageView.transform,-Animation_Width,0);
        
        bigGlassImageView.transform = transform;

    } completion:^(BOOL finished) {
        
        [self rightAnimation];

    }];
    
    
    
}


- (void) rightAnimation{
    
    
    
    [UIView animateWithDuration:Animation_Right_duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //取得仿射变换矩阵
        CGAffineTransform transform;
        
        //参照来做平移操作
        transform=CGAffineTransformTranslate(bigGlassImageView.transform,Animation_Width,0);
        
        bigGlassImageView.transform = transform;
        

        
    } completion:^(BOOL finished) {
        
        [self leftAnimation];
        
    }];
    
}

- (void) beginAnimation{
    
    [self rightAnimation];
    
    
}
@end
