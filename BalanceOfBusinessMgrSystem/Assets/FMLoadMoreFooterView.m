//
//  FMLoadMoreFooterView.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-28.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "FMLoadMoreFooterView.h"
#import "UIView+Additions.h"
@implementation FMLoadMoreFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.activeView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(frame.size.width/2-(30+100)/2, frame.size.height/2-30/2, 30, 30)];
        _activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        _activeView.backgroundColor =[UIColor redColor];
        [self addSubview:_activeView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_activeView.size.width+_activeView.origin.x, frame.size.height/2-25/2, 100, 25)];
//        _titleLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_titleLabel];
    }
    return self;
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
