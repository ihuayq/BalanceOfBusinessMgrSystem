//
//  cardSwipeAlertView.m
//  navigationbar
//
//  Created by han on 13-1-5.
//  Copyright (c) 2013年 wsyd. All rights reserved.
//

#import "cardSwipeAlertView.h"

@implementation cardSwipeAlertView
@synthesize csd;

- (id)initWithFrame:(CGRect)frame
{
//    self = [super initWithFrame:CGRectMake(30, -50, 230, 128)];
    //30, -50, 230, 128
    self = [super initWithFrame:frame];
    if (self) {
        movingImage = [[UIImageView alloc] initWithFrame:CGRectMake(150, -35, 100, 45)];
        [movingImage setImage:[UIImage imageNamed:@"handcard.png"]];
        
      UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, 2, 80, 80)];
        [backgroundImage setImage:[UIImage imageNamed:@"handmobile.png"]];
      
        
        UIImageView *backColorImage = [[UIImageView alloc] initWithFrame:self.frame];
        [backColorImage setImage:[UIImage imageNamed:@"cardSwipeBackground.png"]];
        [backColorImage setBackgroundColor:[UIColor clearColor]];
        
        UILabel *showLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, -15, 100, 45)];
        [showLbl setBackgroundColor:[UIColor clearColor]];
        [showLbl setText:@"请刷卡..."];
        [showLbl setTextColor:[UIColor whiteColor]];
        [showLbl setFont:[UIFont fontWithName:@"Helvetica" size:25]];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(20, 45, 60, 40)];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
        
        NSTimer *swipeTimer =  [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(swipeCardAnimation) userInfo:nil repeats:YES];

        NSLog(@"swipeTimer=%@",swipeTimer);
        
        [self addSubview:backColorImage];
        [self addSubview:movingImage];
        [self addSubview:backgroundImage];
        [self addSubview:showLbl];
        [self addSubview:btnCancel];
    }
    return self;
}

-(void) swipeCardAnimation{
  [movingImage setFrame:CGRectMake(150, -35, 100, 45)];
  [UIView beginAnimations:@"cardmove" context:( void *)(movingImage)];
  [UIView setAnimationDuration:2];
  [movingImage setFrame:CGRectMake(175, -35, 100, 45)];
  [UIView commitAnimations];
}

-(void) hideAnimation{
    [csd stopSwipe];
}
@end
