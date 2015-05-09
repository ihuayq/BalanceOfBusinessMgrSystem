//
//  ImageShowUIView.m
//  ipaycard
//
//  Created by han bing on 13-1-6.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "ImageShowUIView.h"

@implementation ImageShowUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
        curImageV = [[UIImageView alloc] initWithFrame:frame];
        [curImageV setImage:[UIImage imageNamed:@"ad_1.jpg"]];
        
        [self addSubview:curImageV];
        animationTime = 2;
        [self setBackgroundColor:[UIColor colorWithPatternImage:[curImageV.image scaleToSize:CGSizeMake(320, 100)]]];
        NSTimer *imageAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(loadNextImage) userInfo:nil repeats:YES];
        NSLog(@"imageAnimationTimer=%@",imageAnimationTimer);
    }
    return self;
}

-(void) loadNextImage{
    switch (imageIndex) {
        case 1:
            [curImageV setImage:[UIImage imageNamed:@"ad_2.jpg"]];
            [curImageV setFrame:CGRectMake(320, 0, 0, 0)];
            [UIView beginAnimations:@"imageV2Animation" context:(__bridge void *)(curImageV)];
            [UIView setAnimationDuration:animationTime];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(setUIViewBackgoundImage)];
            [curImageV setFrame:CGRectMake(0, 0, 320, 100)];
            [UIView commitAnimations];
            break;
        case 2:
            [curImageV setImage:[UIImage imageNamed:@"ad_3.jpg"]];
            [curImageV setFrame:CGRectMake(-320, 100, 0, 0)];
            [UIView beginAnimations:@"imageV3Animation" context:(__bridge void *)(curImageV)];
            [UIView setAnimationDuration:animationTime];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(setUIViewBackgoundImage)];
            [curImageV setFrame:CGRectMake(0, 0, 320, 100)];
            [UIView commitAnimations];
            break;
        default:
            [curImageV setImage:[UIImage imageNamed:@"ad_1.jpg"]];
            [curImageV setFrame:CGRectMake(320, 100, 0, 0)];
            [UIView beginAnimations:@"imageV1Animation" context:(__bridge void *)(curImageV)];
            [UIView setAnimationDuration:animationTime];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(setUIViewBackgoundImage)];
            [curImageV setFrame:CGRectMake(0, 0, 320, 100)];
            [UIView commitAnimations];
            break;
    }
    imageIndex += 1;
    if (imageIndex > 3) {
        imageIndex = 1;
    }
    //  [self setBackgroundColor:[UIColor colorWithPatternImage:curImageV.image]];
}

-(void) setUIViewBackgoundImage{
    [self setBackgroundColor:[UIColor colorWithPatternImage:[curImageV.image scaleToSize:CGSizeMake(320, 100)]]];
}

@end
