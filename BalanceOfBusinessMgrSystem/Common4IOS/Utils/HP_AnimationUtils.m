//
//  HP_AnimationUtils.m
//  common4ios
//
//  Created by Yi Xu on 12-10-18.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import "HP_AnimationUtils.h"

@implementation HP_AnimationUtils

//+(void)doAnimationForView:(UIView *)view toDegree:(float)toDegree duration:(float)duration{
//
//    int times90 = toDegree/M_PI/180;
//    float timesDuration = duration/times90;
//
//    [UIView animateWithDuration:duration animations:^{
//        view.transform = CGAffineTransformMakeRotation(-M_PI_4);
//    } completion:^(BOOL finished) {
//        [self doAnimationForView:view toDegree:toDegree>90?90:toDegree-90 duration:toDegree>90?timesDuration*90:duration-timesDuration*90];
//    }];
//}

+ (id)rotateXFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration{
    
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.fromValue = [NSNumber numberWithInt:fromValue];
	rotationAnimation.toValue = [NSNumber numberWithInt:toValue];
    rotationAnimation.duration = duration;
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    //动画旋转完毕，需要将view 的transform重新设置一下。
    //    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return rotationAnimation;
    
    //  [NSNumber numberWithFloat:(2 * M_PI) * direction];
    
    //	[logoLayer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
    
}

+ (id)rotateYFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration{
    
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
	rotationAnimation.toValue = [NSNumber numberWithFloat:toValue];
    rotationAnimation.duration = duration;
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    return rotationAnimation;
    
}

+ (id)rotateZFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration{
    
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
	rotationAnimation.toValue = [NSNumber numberWithFloat:toValue];
    rotationAnimation.duration = duration;
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    return rotationAnimation;
    
}

+ (void) doAnimationForView:(UIView *) view toAlpha:(float) toAlpha duration:(float) duration{
    
    [UIView animateWithDuration:duration animations:^{
        view.alpha = toAlpha;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void) doAnimationForView:(UIView *) view fromAlpha:(float) fromAlpha toAlpha:(float) toAlpha duration:(float) duration{
    
    view.alpha = fromAlpha;
    
    [UIView animateWithDuration:duration animations:^{
        view.alpha = toAlpha;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void) doAnimationForView:(UIView *) view toPoint:(CGPoint) toPoint duration:(float) duration{
    
    [UIView animateWithDuration:duration animations:^{
        view.frame = CGRectMake(toPoint.x, toPoint.y,view.frame.size.width,view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

+ (void) doAnimationForView:(UIView *) view toX:(float) toX duration:(float) duration{
    
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(toX, view.center.y);
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void) doAnimationForView:(UIView *) view fromX:(float) fromX toX:(float) toX duration:(float) duration{
    
    view.center = CGPointMake(fromX, view.center.y);
    
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(toX, view.center.y);
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void) doAnimationForView:(UIView *) view fromPoint:(CGPoint) fromPoint toPoint:(CGPoint) toPoint duration:(float) duration{
    
    view.frame = CGRectMake(fromPoint.x, fromPoint.y,view.frame.size.width,view.frame.size.height);
    
    [UIView animateWithDuration:duration animations:^{
        view.frame = CGRectMake(toPoint.x, toPoint.y,view.frame.size.width,view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

+(void) doAnimationForView:(UIView *)view toSize:(CGSize) toSize duration:(float) duration{
    
    [UIView animateWithDuration:duration animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, toSize.width, toSize.height);
    } completion:^(BOOL finished) {
        
    }];
}

+(void) doAnimationForView:(UIView *)view fromSize:(CGSize) fromSize toSize:(CGSize) toSize duration:(float) duration{
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, fromSize.width, fromSize.height);
    [UIView animateWithDuration:duration animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, toSize.width, toSize.height);
    } completion:^(BOOL finished) {
        
    }];
}

+(void) doAnimationForView:(UIView *) view duration:(float) duration AnimationBlock:(AnimationBlock)AnimationBlock AnimationCompletionBlock:(AnimationCompletionBlock)AnimationCompletionBlock{
    [UIView animateWithDuration:duration animations:^{
        AnimationBlock();
    } completion:^(BOOL finished) {
        AnimationCompletionBlock(finished);
    }];
    
}
//+ (CAAnimationGroup *)_blowupAnimationAtPoint:(CGPoint)p
//{
//    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    positionAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:p], nil];
//    positionAnimation.keyTimes = [NSArray arrayWithObjects: [NSNumber numberWithFloat:.3], nil];
//
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(3, 3, 1)];
//
//    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
//
//    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
//    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, scaleAnimation, opacityAnimation, nil];
//    animationgroup.duration = 0.3f;
//    animationgroup.fillMode = kCAFillModeForwards;
//
//    return animationgroup;
//}
//
//+ (CAAnimationGroup *)_shrinkAnimationAtPoint:(CGPoint)p
//{
//    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//
//    NSLog(@"%@",[NSValue valueWithCGPoint:p]);
//    NSLog(@"%@",@"asdf");
//    positionAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:p], nil];
//
//    positionAnimation.keyTimes = [NSArray arrayWithObjects: [NSNumber numberWithFloat:.3], nil];
//
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.01, .01, 1)];
//
//    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
//
//    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
//    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, scaleAnimation, opacityAnimation, nil];
//    animationgroup.duration = 0.3f;
//    animationgroup.fillMode = kCAFillModeForwards;
//
//    return animationgroup;
//}

@end
