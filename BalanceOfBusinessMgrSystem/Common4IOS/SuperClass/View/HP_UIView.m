//
//  HP_UIView.m
//  blog
//
//  Created by Yi Xu on 12-11-25.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import "HP_UIView.h"

@implementation HP_UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setBackgroundImage:(UIImage *) image{
    [self setBackgroundColor:[UIColor colorWithPatternImage: image]];
}


@end
