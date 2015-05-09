//
//  HP_PullToRefreshView.m
//  youyouapp
//
//  Created by Yi Xu on 13-6-12.
//  Copyright (c) 2013年 CuiYiLong. All rights reserved.
//

#import "HP_PullToRefreshView.h"

#define REFRESH_HEADER_HEIGHT 60.0f
#define LOAD_MORE_FOOTER_HEIGHT 60.0f

#define NORMAL_COLOR_STRING @"#696969"
//#define ORANGE_COLOR_STRING @"#f06000"

#define ARROW_WIDTH 27
#define ARROW_HEIGHT 44

#define REFRESH_LIST_VIEW_HEIGHT 44


@implementation HP_PullToRefreshView
@synthesize refreshListTextLabel;
@synthesize refreshListArrowImageView;
@synthesize refreshListSpinner;
@synthesize refreshListLastDateLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFrame:CGRectMake(0, -REFRESH_LIST_VIEW_HEIGHT+3, MainWidth, REFRESH_LIST_VIEW_HEIGHT)];
        
        
        refreshListArrowImageView = [[HP_UIImageView alloc] init];
        [refreshListArrowImageView setImage:[UIImage imageNamed:@"arrow_bottom"]];
        [refreshListArrowImageView setFrame:CGRectMake(20, REFRESH_LIST_VIEW_HEIGHT/2-ARROW_HEIGHT/2, ARROW_WIDTH, ARROW_HEIGHT)];
        [self addSubview:refreshListArrowImageView];
        
        refreshListSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        refreshListSpinner.frame = CGRectMake(20, REFRESH_LIST_VIEW_HEIGHT/2-20/2, 20, 20);
        refreshListSpinner.hidesWhenStopped = YES;
        [self addSubview:refreshListSpinner];
        
        refreshListTextLabel = [[HP_UILabel alloc] initWithFrame:CGRectMake(0, -10, MainWidth, REFRESH_LIST_VIEW_HEIGHT)];
        refreshListTextLabel.backgroundColor = [UIColor clearColor];
        refreshListTextLabel.font = [UIFont systemFontOfSize:12.0];
        refreshListTextLabel.textAlignment = NSTextAlignmentCenter;
        [refreshListTextLabel setTextColor:[HP_UIColorUtils colorWithHexString:NORMAL_COLOR_STRING]];
        [self addSubview:refreshListTextLabel];
        
        //时间显示位置
        refreshListLastDateLabel = [[HP_UILabel alloc] initWithFrame:CGRectMake(0, 10, MainWidth, REFRESH_LIST_VIEW_HEIGHT)];
        refreshListLastDateLabel.backgroundColor = [UIColor clearColor];
        refreshListLastDateLabel.font = [UIFont systemFontOfSize:12.0];
        [refreshListLastDateLabel setTextColor:[HP_UIColorUtils colorWithHexString:NORMAL_COLOR_STRING]];
        refreshListLastDateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:refreshListLastDateLabel];
    }
    return self;
}


@end
