//
//  DJYICSignInAniView.m
//  ipaycard
//
//  Created by Davidsph on 6/7/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYICSignInAniView.h"

#define ImageView_Animation_Duration 0.8

@interface DJYICSignInAniView ()
{
    
    UIImageView *imageview1;
    
    UIImageView *imageView2;
    
    UIImageView *imagView_Lister;
    
    CGRect originFrame;
}
@end

@implementation DJYICSignInAniView

-(id)initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType andBusType:(NSInteger)busType{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageview1 =[[UIImageView alloc] initWithFrame:CGRectMake(20, 108, 79, 113) ];
        
        if (animatType == 1) {
            imageview1.image = [UIImage imageNamed:@"560x540_盒子_蓝280.png"];
            
        }else{
            imageview1.image = [UIImage imageNamed:@"560x540_盒子_红.png"];
        }
        imageview1.contentMode = UIViewContentModeScaleAspectFit;
        originFrame = imageview1.frame;
        
        [self addSubview:imageview1];
        
        imagView_Lister = [[UIImageView alloc] initWithFrame:CGRectMake(87, 65, 57, 58)];
        UIImage *image1, *image2, *image3, *image4;
        if (animatType == 1) {
            image1 = [UIImage imageNamed:@"560x540_闪灰.png"];
            image2 = [UIImage imageNamed:@"560x540_闪蓝1.png"];
            
            image3 = [UIImage imageNamed:@"560x540_闪蓝2.png"];
            
            image4 = [UIImage imageNamed:@"560x540_闪蓝3.png"];
        }else{
            image1 = [UIImage imageNamed:@"560x540_闪灰.png"];
            image2 = [UIImage imageNamed:@"560x540_闪红1.png"];
            
            image3 = [UIImage imageNamed:@"560x540_闪红2.png"];
            
            image4 = [UIImage imageNamed:@"560x540_闪红3.png"];
        }
        
        
        
        imagView_Lister.contentMode = UIViewContentModeScaleAspectFit;
        imagView_Lister.animationImages = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];
        
        imagView_Lister.animationDuration = ImageView_Animation_Duration;
        
        [self addSubview:imagView_Lister];
        
        
        imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(7, 165, 240, 85) ];
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView2.image = [UIImage imageNamed:@"560x540_iPhoneTop.png"];
        
        [self addSubview:imageView2];
    }
    return self;
  
}

-(id)initWithFrame:(CGRect)frame animationtype:(NSInteger)animatType
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageview1 =[[UIImageView alloc] initWithFrame:CGRectMake(20, 108, 79, 113) ];
        
        if (animatType == 1) {
            imageview1.image = [UIImage imageNamed:@"560x540_盒子_蓝280.png"];
        }else{
            imageview1.image = [UIImage imageNamed:@"560x540_盒子_红.png"];
        }
        imageview1.contentMode = UIViewContentModeScaleAspectFit;
        originFrame = imageview1.frame;
        
        [self addSubview:imageview1];
                
        imagView_Lister = [[UIImageView alloc] initWithFrame:CGRectMake(87, 65, 57, 58)];
        UIImage *image1, *image2, *image3, *image4;
        if (animatType == 1) {
            image1 = [UIImage imageNamed:@"560x540_闪灰.png"];
            image2 = [UIImage imageNamed:@"560x540_闪蓝1.png"];
            
            image3 = [UIImage imageNamed:@"560x540_闪蓝2.png"];
            
            image4 = [UIImage imageNamed:@"560x540_闪蓝3.png"];
        }else{
            image1 = [UIImage imageNamed:@"560x540_闪灰.png"];
            image2 = [UIImage imageNamed:@"560x540_闪红1.png"];
            
            image3 = [UIImage imageNamed:@"560x540_闪红2.png"];
            
            image4 = [UIImage imageNamed:@"560x540_闪红3.png"];
        }
        imagView_Lister.contentMode = UIViewContentModeScaleAspectFit;
        imagView_Lister.animationImages = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];
        
        imagView_Lister.animationDuration = ImageView_Animation_Duration;
        
        [self addSubview:imagView_Lister];
        
        imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(7, 165, 240, 85) ];
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView2.image = [UIImage imageNamed:@"560x540_iPhoneTop.png"];
        
        [self addSubview:imageView2];
    }
    return self;
}


- (void) beginAnimation{
    
    [imagView_Lister startAnimating];
    
}

- (void) changeFrameToZore{
    
    [imagView_Lister stopAnimating];
    
}




@end
