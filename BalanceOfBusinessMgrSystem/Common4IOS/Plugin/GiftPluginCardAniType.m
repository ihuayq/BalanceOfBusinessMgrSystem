//
//  GiftPluginCardAniType.m
//  ipaycard
//
//  Created by RenLongfei on 13-9-10.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "GiftPluginCardAniType.h"

@interface GiftPluginCardAniType ()
{
    
    UIView * phone_boxView;    
    
    UIImageView *imageview1;
    
    UIImageView *imageView2;
    
    CGRect originFrame_phone;
    
    CGAffineTransform originPhoneTransform;
    
    UIImageView *icCardImageView;
    
    CGRect originFrame;
    
    CGAffineTransform originIcCardTransform;
    
}
@end

@implementation GiftPluginCardAniType
-(id)initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType andBusType:(NSInteger)busType{
    
    self  = [super initWithFrame:frame];
    if (self) {
        
        icCardImageView = [[UIImageView alloc] init]; //69---74 240 --132  123- 88  74-35 = 39
        icCardImageView.frame = CGRectMake(-10, 39, 162, 123);
        
        NSLog(@"\nbusType =%d",busType);
        UIImage *image1 ; //560x540_IC卡left ic卡反  金融卡反
        if (busType ==4)
        {
            NSLog(@"\nanimatType =%d",animatType);
            icCardImageView.frame = CGRectMake(-10, 20, 162, 123);
            if (animatType == 0)
            {
                image1 = [UIImage imageNamed:@"anim_cardi"];
            }else if (animatType == 1)
            {
                image1 = [UIImage imageNamed:@"anim_cards"];
            }
        }
        else
        {
            image1 = [UIImage imageNamed:@"anim_hand_card-正面.png"];
        }
        
        icCardImageView.image = image1;
        
        originIcCardTransform = icCardImageView.transform;
        
        icCardImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        icCardImageView.alpha = 0;
        
        [self addSubview:icCardImageView];
        
        phone_boxView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        phone_boxView.backgroundColor = [UIColor clearColor];
        originFrame_phone = phone_boxView.frame;
        originPhoneTransform = phone_boxView.transform;
        
        imageview1 =[[UIImageView alloc] initWithFrame:CGRectMake(20, 108, 79, 113) ];
        
        if (animatType == 1) {
            imageview1.image = [UIImage imageNamed:@"560x540_盒子_蓝280.png"];
        }else{
            imageview1.image = [UIImage imageNamed:@"560x540_盒子_红.png"];
        }
        
        imageview1.contentMode = UIViewContentModeScaleAspectFit;
        originFrame = imageview1.frame; ////!!!!!!!!!!!what
        
        [phone_boxView addSubview:imageview1];
        
        imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(7, 165, 240, 85) ];
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView2.image = [UIImage imageNamed:@"560x540_iPhoneTop.png"];
        
        [phone_boxView addSubview:imageView2];
        
        [self addSubview:phone_boxView];
        
    }
    return self;

}
-(id)initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType{
    
    self  = [super initWithFrame:frame];
    if (self) {
        
        icCardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 39, 162, 123)]; //69---74 240 --132  123- 88  74-35 = 39
        
        UIImage *image1 = [UIImage imageNamed:@"anim_hand_card-正面.png"]; //560x540_IC卡left
        
        icCardImageView.image = image1;
        
        originIcCardTransform = icCardImageView.transform;
        
        icCardImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        icCardImageView.alpha = 0;
        
        [self addSubview:icCardImageView];
        
        phone_boxView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        phone_boxView.backgroundColor = [UIColor clearColor];
        originFrame_phone = phone_boxView.frame;
        originPhoneTransform = phone_boxView.transform;
        
        imageview1 =[[UIImageView alloc] initWithFrame:CGRectMake(20, 108, 79, 113) ];
        
        if (animatType == 1) {
            imageview1.image = [UIImage imageNamed:@"560x540_盒子_蓝280.png"];
        }else{
            imageview1.image = [UIImage imageNamed:@"560x540_盒子_红.png"];
        }
        
        imageview1.contentMode = UIViewContentModeScaleAspectFit;
        originFrame = imageview1.frame; ////!!!!!!!!!!!what
        
        [phone_boxView addSubview:imageview1];
        
        imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(7, 165, 240, 85) ];
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView2.image = [UIImage imageNamed:@"560x540_iPhoneTop.png"];
        
        [phone_boxView addSubview:imageView2];
        
        [self addSubview:phone_boxView];

    }
    return self;
    
}


- (void) continueToLeftAnimation{
    
    icCardImageView.alpha = 1;

    [UIView animateWithDuration:1.5 delay:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //取得仿射变换矩阵
        CGAffineTransform transform;
        
        //参照来做平移操作
        transform=CGAffineTransformTranslate(icCardImageView.transform, 200, 0);
        
        icCardImageView.transform = transform;
        
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            icCardImageView.alpha = 0;
        } completion:^(BOOL finished) {
            
            icCardImageView.transform = originIcCardTransform;
            
            [self continueToLeftAnimation];
        }];
        
    }];
    
}

- (void) toLeftAnimation{
    

    icCardImageView.alpha = 1;
    [UIView animateWithDuration:0.6 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //取得仿射变换矩阵
        CGAffineTransform transform;
        
        //参照来做平移操作
        transform=CGAffineTransformTranslate(icCardImageView.transform, 30, 0);
        
        icCardImageView.transform = transform;
        
        
    } completion:^(BOOL finished) {
        
        
        [self continueToLeftAnimation];
        
    }];
    
}

//刷卡动画开始
- (void) shuaKaAnimation{
    
    CGAffineTransform  transform;
    //有参照
    transform=CGAffineTransformTranslate(originPhoneTransform, 102, 0);
    icCardImageView.alpha = 0;
    
    [UIView animateWithDuration:1.4 animations:^{
        
        phone_boxView.transform = transform;
        
    } completion:^(BOOL finished) {
        
        [self continueToLeftAnimation];
        
    }];
}

- (void) beginAnimation{

    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self shuaKaAnimation];
    });
    
    //[self toLeftAnimation];
    
}

- (void) changeFrameToZore{
    
    
    
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

/*

 - (id)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 
 }
 return self;
 }
*/