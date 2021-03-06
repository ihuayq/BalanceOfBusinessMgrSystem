//
//  HP_PullToRefreshView.h
//  youyouapp
//
//  Created by Yi Xu on 13-6-12.
//  Copyright (c) 2013年 CuiYiLong. All rights reserved.
//

#define REFRESH_HEADER_HEIGHT 60.0f
#define LOAD_MORE_FOOTER_HEIGHT 60.0f
#define REFRESH_LIST_VIEW_HEIGHT 44
#define LOAD_MORE_LIST_VIEW_HEIGHT 44
#define ARROW_WIDTH 27
#define ARROW_HEIGHT 44



#import <UIKit/UIKit.h>
#import "HP_Common4IOS.h"

@interface HP_PullToRefreshView : UIView
@property (nonatomic,retain) HP_UILabel * refreshListTextLabel;
@property (nonatomic,retain) HP_UIImageView *refreshListArrowImageView;
@property (nonatomic,retain) UIActivityIndicatorView *refreshListSpinner;
@property (nonatomic,retain) HP_UILabel *refreshListLastDateLabel;
@end
