//
//  MRLoadingView.h
//  TestRequest
//
//  Created by 孙朋贞 on 13-8-28.
//  Copyright (c) 2013年 www.icardpay.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MRLoadingView : UIView
{
    
    UILabel * _activityLabel;
    UIActivityIndicatorView * _activityIndicator;
    UIView * _activityView;
}

@property (nonatomic,retain) UILabel * activityLabel;
@property (nonatomic,retain) UIActivityIndicatorView * activityIndicator;
@property (nonatomic,retain) UIView * activityView;

/**在页面中显示**/
- (void)showInView:(UIView *) view withMessage:(NSString *)msg;

/**从view上面移走**/
- (void)removeSelfFromSuperView:(id)sender;

@end
