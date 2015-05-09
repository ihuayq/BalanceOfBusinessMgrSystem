//
//  DjyGetDeviceInfoAniView.m
//  动画测试
//
//  Created by Davidsph on 5/29/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "DjyGetDeviceInfoAniView.h"

#define ImageView_Animation_Duration 0.8

@interface DjyGetDeviceInfoAniView ()
{
    
    UIImageView *imageview1;
    
    UIImageView *imageView2;
    
    UIImageView *imagView_Lister;
    
    CGRect originFrame;

}
@end

@implementation DjyGetDeviceInfoAniView

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
        NSString *string = @"红";
        
        if (animatType==1) {
            
            string = @"蓝";
        }
        
        
        imageview1 =[[UIImageView alloc] initWithFrame:CGRectMake(10, 29, 20, 27)];//CGRectMake(10, 16, 20, 27)
        //200x120_红盒
        imageview1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"200x120_%@盒",string] ofType:@"png"]];
        imageview1.contentMode = UIViewContentModeScaleAspectFit;
        originFrame = imageview1.frame;
        
        [self addSubview:imageview1];
        
        
        imagView_Lister = [[UIImageView alloc] initWithFrame:CGRectMake(29, 18, 14, 14)];
        
        UIImage *image1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"200x120_闪灰" ofType:@"png"]];
        UIImage *image2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"200x120_闪%@1",string] ofType:@"png"]];
        UIImage *image3 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"200x120_闪%@2",string] ofType:@"png"]];
        UIImage *image4 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"200x120_闪%@3",string] ofType:@"png"]];
        imagView_Lister.contentMode = UIViewContentModeScaleAspectFit;
        imagView_Lister.animationImages = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];
        
        imagView_Lister.animationDuration = 1.2;
        
        [self addSubview:imagView_Lister];
        
        
        imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(6, 45, 45, 13)];//CGRectMake(6, 45, 45, 13)
        //        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView2.image = [UIImage imageNamed:@"200x120_iPhoneTop.png"];
        
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
