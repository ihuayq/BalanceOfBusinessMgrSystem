//
//  MRLoadingView.m
//  TestRequest
//
//  Created by 孙朋贞 on 13-8-28.
//  Copyright (c) 2013年 www.icardpay.com. All rights reserved.
//

#import "MRLoadingView.h"

@implementation MRLoadingView
@synthesize activityLabel = _activityLabel;
@synthesize activityView = _activityView;
@synthesize activityIndicator = _activityIndicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView * activityView = [[UIView alloc] initWithFrame:CGRectMake(110.0f, 150.0f, 100.0f, 100.0f)];
        //[[activityView layer] setCornerRadius:5.0f];
        self.activityView = activityView;
        [self.activityView.layer setContents:(id)[[UIImage imageNamed:@"autoalert_bg.png"] CGImage]];
        [self addSubview:self.activityView];
        [activityView release];
        
        
        UILabel * activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100,22)];
        activityLabel.backgroundColor = [UIColor clearColor];
        activityLabel.text = @"...";
        activityLabel.font = [UIFont systemFontOfSize:13];
        activityLabel.textAlignment = NSTextAlignmentCenter;
        activityLabel.textColor = [UIColor whiteColor];
        self.activityLabel = activityLabel;
        [activityLabel release];
        [self.activityView addSubview:self.activityLabel];
        
        UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(9, 30, 20, 20); //26 = 32-3x2
        self.activityIndicator = activityIndicator;
        [activityIndicator release];
        [self.activityView addSubview:activityIndicator];
        
        self.activityIndicator.center = CGPointMake(50,50);
        
        
    }
    return self;
}

- (void)dealloc
{
    [_activityLabel release];
    [_activityView release];
    [_activityIndicator release];
    [super dealloc];
}
//根据字符串获得对应的长度CGSize
- (CGSize)getStringSize:(NSString *)string withFont:(UIFont *)font
      withconstrainSize:(CGSize)constraintSize
{
    CGSize size;
    
    size  = [string sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];//UILineBreakModeWordWrap
    return size;
}

/**在页面中显示**/
- (void)showInView:(UIView *)view withMessage:(NSString *)msg
{
    self.frame = CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height);
    
    CGSize nameSize = [self getStringSize:msg withFont:[UIFont systemFontOfSize:13] withconstrainSize:CGSizeMake(200.0f, 22.0f)];
    if (nameSize.width < 100.0f) {
        nameSize.width = 100.0f;
    }
    self.activityView.frame = CGRectMake((view.frame.size.width-nameSize.width)/2.0f, (view.frame.size.height-100.0f)/2.0f, nameSize.width+10, 100.0f);
    self.activityIndicator.frame = CGRectMake((nameSize.width-20.0f)/2.0f, 30.0f, 20.0f, 20.0f);
    
    self.activityLabel.frame = CGRectMake(5.0f, 60.0f, nameSize.width, 22.0f);
    if (msg) {
        self.activityLabel.text = msg;
    }
    self.activityView.center = view.center;
    if (![self superview]) {
        [view addSubview:self];
    }
    [self.activityIndicator startAnimating];
}

/**从view上面移走**/
- (void)removeSelfFromSuperView:(id)sender
{
    if ([self superview]) {
        [self removeFromSuperview];
    }
    [self.activityIndicator stopAnimating];
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
