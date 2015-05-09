//
//  DJYReWriteCardDataAniView.m
//  ipaycard
//
//  Created by Davidsph on 6/9/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYReWriteCardDataAniView.h"

@implementation DJYReWriteCardDataAniView

- (id)initWithFrame:(CGRect)frame
{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self = [super initWithFrame:frame];
    if (self) {
        //Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        CCLog(@"*********");
        
    } else{
        CCLog(@"&&&&&&&&&&");
    }
    
    //    [self initAlpha];
    return self;
}

- (void)changeBackImage:(NSInteger)businessType{
    if (businessType == 0) {
        self.backImage.image = [UIImage imageNamed:@"ic卡.png"];
    }else if(businessType == 1){
        self.backImage.image = [UIImage imageNamed:@"金融卡.png"];
    }else{
        self.backImage.image = [UIImage imageNamed:@"560x540_IC卡left.png"];

    }
}

- (void) initAlpha{
    
    self.icImageView_7.alpha =0;
    self.icImageView_8.alpha =0;
    self.icImageView_2.alpha = 0;
    self.icImageView_5.alpha = 0;
    self.icImageView_6.alpha = 0;
    self.icImageView_3.alpha =0;
    
}

- (void) beginAnimation{
    
    [self beginAllAAction];
    
}

- (void)changeFrameToZore{
    
    
}

//重新开始所有动画 动画之间是互不影响的
- (void) beginAllAAction{
    
    [self initAlpha];
    
    [self beginAction_2];
    [self beginAction_7];
    [self beginAction_8];
    [self beginAction_5];
    [self beginAction_6];
    [self beginAction_3];
    
}



- (void) beginAnimationWithView:(UIImageView *)animationView
                       duration:(NSTimeInterval)aniDuration
                 animationDelay:(NSTimeInterval)delayTime
                       newFrame:(CGRect) newFrame
                   newTransform:(CGAffineTransform) newTransform
                       newAlpha:(CGFloat) newAlpha
                completionBlock:(void(^)(void))block

{
    
    CGRect originFrame = animationView.frame;
    CGAffineTransform originTransform = animationView.transform;
    
    [UIView animateWithDuration:aniDuration delay:delayTime options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        animationView.frame = newFrame;
        animationView.alpha = newAlpha;
        animationView.transform = newTransform;
        
    } completion:^(BOOL finished) {
        
        animationView.transform = originTransform;
        animationView.frame = originFrame;
        animationView.alpha = 0;
        block();
        
    }];
}



- (void) beginAction_5{
    
    
    
    CGRect newFrame = CGRectMake(self.icImageView_5.frame.origin.x+10, self.icImageView_5.frame.origin.y+80, self.icImageView_5.frame.size.width, self.icImageView_5.frame.size.height);
    
    CGAffineTransform tran1 ;
    
    tran1 = CGAffineTransformScale(self.icImageView_5.transform, 0.001, 0.001);
    
    [self beginAnimationWithView:self.icImageView_5 duration:1.5 animationDelay:0.8 newFrame:newFrame newTransform:tran1 newAlpha:0.8 completionBlock:^{
        
        [self beginAllAAction];
        
    }];
    
    
}


- (void) beginAction_8{
    
    CGRect newFrame = CGRectMake(self.icImageView_8.frame.origin.x+80, self.icImageView_8.frame.origin.y, self.icImageView_8.frame.size.width, self.icImageView_8.frame.size.height);
    
    
    CGAffineTransform tran1 ;
    
    tran1 = CGAffineTransformScale(self.icImageView_8.transform, 0.001, 0.001);
    
    
    [self beginAnimationWithView:self.icImageView_8 duration:1.5 animationDelay:0.6 newFrame:newFrame newTransform:tran1 newAlpha:1.0 completionBlock:^{
        
        
    }];
    
    
}



- (void) beginAction_7{
    
    
    
    CGAffineTransform  transform;
    
    //有参照
    transform=CGAffineTransformScale(self.icImageView_7.transform,0.0001, 0.00001);
    
    [self beginAnimationWithView:self.icImageView_7 duration:1.2 animationDelay:0.3 newFrame:self.icImageView_7.frame newTransform:transform newAlpha:0.5 completionBlock:^{
        
        
    }];
    
    
    
}

- (void) beginAction_6{
    
    
    
    CGRect newFrame = CGRectMake(self.icImageView_6.frame.origin.x-20, self.icImageView_6.frame.origin.y-20, self.icImageView_6.frame.size.width, self.icImageView_6.frame.size.height);
    
    
    CGAffineTransform tran1 ;
    
    tran1 = CGAffineTransformScale(self.icImageView_6.transform, 0.001, 0.001);
    
    
    [self beginAnimationWithView:self.icImageView_6 duration:1 animationDelay:0.45 newFrame:newFrame newTransform:tran1 newAlpha:1.0 completionBlock:^{
        
        
    }];
    
    
    
}

- (void) beginAction_3{
    
    
    CGRect newFrame = CGRectMake(self.icImageView_3.frame.origin.x+30, self.icImageView_3.frame.origin.y-55, self.icImageView_3.frame.size.width, self.icImageView_3.frame.size.height);
    
    
    CGAffineTransform tran1 ;
    
    tran1 = CGAffineTransformScale(self.icImageView_3.transform, 0.001, 0.001);
    
    
    [self beginAnimationWithView:self.icImageView_3 duration:1.2 animationDelay:0.65 newFrame:newFrame newTransform:tran1 newAlpha:1.0 completionBlock:^{
        
        
    }];
    
    
}

- (void) beginAction_2{
    
    
    CGAffineTransform tran1 ;
    
    tran1 = CGAffineTransformScale(self.icImageView_2.transform, 0.001, 0.001);
    
    [self beginAnimationWithView:self.icImageView_2 duration:1 animationDelay:0 newFrame:self.icImageView_2.frame newTransform:tran1 newAlpha:0.5 completionBlock:^{
   
    }];
 
    
}


@end

