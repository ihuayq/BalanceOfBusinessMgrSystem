//
//  DjyReadCardAniView.m
//  动画测试
//
//  Created by Davidsph on 5/29/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "DjyReadCardAniView.h"

@interface DjyReadCardAniView ()
{
    
    UIImageView *handImageView; //刷卡的手
    
    UIView *phone_boxView;
    
    
    UIImageView *imageview1;
    
    UIImageView *imageView2; //手机
    
    CGRect originFrame_hand;
    
    CGRect orginFrame_phone;
    
    CGAffineTransform originPhoneBoxTransform;
    CGAffineTransform originHandImageViewTran;
    //阴影黑线
    UIImageView *lineImgv;
}

@end

@implementation DjyReadCardAniView

- (id)initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType
{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        NSString *string = @"红";
        if (animatType == 1) {
            string = @"蓝";
        }

        handImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-25, 11, 50, 34)];
        handImageView.contentMode = UIViewContentModeScaleAspectFit;
        originHandImageViewTran = handImageView.transform;
        
//        handImageView.image = [UIImage imageNamed:@"200x120_手拿卡.png"];
        handImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"200x120_手拿卡" ofType:@"png"]];
        handImageView.alpha =0;
        
        [self addSubview:handImageView];
        
        originFrame_hand = handImageView.frame;
        
        //8, 33,x
        
        phone_boxView=[[UIView alloc] initWithFrame:CGRectMake(1, -8, 99, 65)];
        
        orginFrame_phone = phone_boxView.frame;
        originPhoneBoxTransform = phone_boxView.transform;
        imageview1 =[[UIImageView alloc] initWithFrame:CGRectMake(10, 27, 20, 27)];//CGRectMake(10, 29, 20, 27)
        imageview1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"200x120_%@盒",string] ofType:@"png"]];
        imageview1.contentMode = UIViewContentModeScaleAspectFit;
        [phone_boxView addSubview:imageview1];
        
        imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(6, 43, 45, 13)];//CGRectMake(6, 45, 45, 13)
        //        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        imageView2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"200x120_iPhoneTop" ofType:@"png"]];
        [phone_boxView addSubview:imageView2];
        
        
        [self addSubview:phone_boxView];
        
        lineImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 66, 4)];
        lineImgv.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"200x120_刷卡时下边界阴影(加不加都可)" ofType:@"png"]];
        [self addSubview:lineImgv];
        lineImgv.alpha = 0;
    }
    return self;
}


- (void) readForShuakaAnimation{
    
    
    [UIView animateWithDuration:1.2 animations:^{
        
        CGAffineTransform  transform;
        
        //有参照
        transform=CGAffineTransformTranslate(originHandImageViewTran, 60, 0);
        
        handImageView.transform = transform;
        handImageView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.8 animations:^{
            
            handImageView.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            handImageView.transform = originHandImageViewTran;
            
            [self readForShuakaAnimation];
            
        }];
    }];
    
    
}


//刷卡动画开始
- (void) shuaKaAnimation{
    
    CGAffineTransform  transform;
    
    //有参照
    transform=CGAffineTransformTranslate(originPhoneBoxTransform, 12, 20);
    handImageView.alpha = 0;
    
    [UIView animateWithDuration:0.8 animations:^{
        
        
        phone_boxView.transform = transform;
        
        
    } completion:^(BOOL finished) {
        
        lineImgv.alpha = 1.0;
        [self readForShuakaAnimation];
        
    }];
}



- (void) beginAnimation{
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
         [self shuaKaAnimation];
    });
  
    
}


- (void) changeFrameToZore{
    
    
    
}



@end
