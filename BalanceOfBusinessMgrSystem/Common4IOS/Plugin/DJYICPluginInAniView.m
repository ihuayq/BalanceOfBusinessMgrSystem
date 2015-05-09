//
//  DJYICPluginInAniView.m
//  ipaycard
//
//  Created by Davidsph on 6/7/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYICPluginInAniView.h"

#define Animation_Height 50

#define Animation_UP_duration 0.9

#define Animation_Down_duration 0.7


@interface DJYICPluginInAniView ()
{
    UIImageView *boxImageview;
    
    UIImageView *phoneImageView;
    
    CGRect originFrame;
    
    CGAffineTransform originBoxTransform;
 
}
@end
@implementation DJYICPluginInAniView

-(id)initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType andBusType:(NSInteger)busType{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSString *boxImageName;
        if (animatType == 1) {
            boxImageName = @"560x540_盒子_蓝280.png";
        }else{
            boxImageName = @"560x540_盒子_红.png";
        }
        boxImageview =[[UIImageView alloc] initWithFrame:CGRectMake(20, (animatType == 1)?56:50, 79, 113) ];
        
        boxImageview.image = [UIImage imageNamed:boxImageName];
        boxImageview.contentMode = UIViewContentModeScaleAspectFit;
        originBoxTransform = boxImageview.transform;
        originFrame = boxImageview.frame;
        
        [self addSubview:boxImageview];
        
        phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 165, 275, 85) ];
        phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        phoneImageView.image = [UIImage imageNamed:@"560x540_iPhoneTop.png"];
        [self addSubview:phoneImageView];
        
    }
    return self;

}

-(id)initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSString *boxImageName;
        if (animatType == 1) {
            boxImageName = @"560x540_盒子_蓝280.png";
        }else{
            boxImageName = @"560x540_盒子_红.png";
        }
        boxImageview =[[UIImageView alloc] initWithFrame:CGRectMake(20, (animatType == 1)?56:50, 79, 113) ];
        
        boxImageview.image = [UIImage imageNamed:boxImageName];
        boxImageview.contentMode = UIViewContentModeScaleAspectFit;
        originBoxTransform = boxImageview.transform;
        originFrame = boxImageview.frame;
        [self addSubview:boxImageview];
        
        phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 165, 275, 85) ];
        phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        phoneImageView.image = [UIImage imageNamed:@"560x540_iPhoneTop.png"];
        [self addSubview:phoneImageView];
        
        
    }
    return self;

}



- (void) upAnimation{
   
  
    [UIView animateWithDuration:Animation_UP_duration delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
       
        //取得仿射变换矩阵
        CGAffineTransform transform;
        
        //参照来做平移操作
        transform=CGAffineTransformTranslate(boxImageview.transform, 0, -Animation_Height);
        
        boxImageview.transform = transform;

    } completion:^(BOOL finished) {
        
         [self downAnimation];
    }];
    
       
}


- (void) downAnimation{
    
    
    [UIView animateWithDuration:Animation_Down_duration delay:0.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        //取得仿射变换矩阵
        CGAffineTransform transform;
        
        //参照来做平移操作
        transform=CGAffineTransformTranslate(boxImageview.transform, 0, Animation_Height);
        
        boxImageview.transform = transform;        
        
    } completion:^(BOOL finished) {
        
          [self upAnimation];
        
    }];
     
}

- (void) beginAnimation{
    
    [self downAnimation];
    
    
}





@end
/*

 - (id)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 
 
 NSString *boxImageName = @"560x540_盒子_蓝280.png";
 
 
 boxImageview =[[UIImageView alloc] initWithFrame:CGRectMake(20, 54, 79, 113) ];
 
 boxImageview.image = [UIImage imageNamed:boxImageName];
 boxImageview.contentMode = UIViewContentModeScaleAspectFit;
 originBoxTransform = boxImageview.transform;
 originFrame = boxImageview.frame;
 
 [self addSubview:boxImageview];
 
 phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 165, 275, 85) ];
 phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
 
 phoneImageView.image = [UIImage imageNamed:@"560x540_iPhoneTop.png"];
 [self addSubview:phoneImageView];
 
 
 }
 return self;
 }

*/