//
//  HP_PullToLoadMoreView.m
//  youyouapp
//
//  Created by Yi Xu on 13-6-12.
//  Copyright (c) 2013年 CuiYiLong. All rights reserved.
//

#import "HP_PullToLoadMoreView.h"
#define LOAD_MORE_LIST_VIEW_HEIGHT 44
#define NORMAL_COLOR_STRING @"#696969"

@implementation HP_PullToLoadMoreView
@synthesize moreListSpinner;
@synthesize moreListTextLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        moreListTextLabel = [[HP_UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth, LOAD_MORE_LIST_VIEW_HEIGHT)];
        
        moreListTextLabel.backgroundColor = [UIColor clearColor];
        moreListTextLabel.font = [UIFont systemFontOfSize:14.0];
        moreListTextLabel.textAlignment = NSTextAlignmentCenter;
        moreListTextLabel.text = @"上拉加载更多";
        [moreListTextLabel setTextColor:[HP_UIColorUtils colorWithHexString:NORMAL_COLOR_STRING]];
        [self addSubview:moreListTextLabel];
        
        CGSize loadMoreTextSize = [NNString getTextSizeByString:@"上拉加载更多" byFont:[UIFont systemFontOfSize:14.0]];
        
        moreListSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        moreListSpinner.frame = CGRectMake(MainWidth/2-loadMoreTextSize.width/2-25, LOAD_MORE_LIST_VIEW_HEIGHT/2-20/2, 20, 20);
        moreListSpinner.hidesWhenStopped = YES;
        [self addSubview:moreListSpinner];
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
