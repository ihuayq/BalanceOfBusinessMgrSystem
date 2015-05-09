//
//  HP_UIScrollView.m
//  jxtuan
//
//  Created by 融通互动 on 13-8-29.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "HP_UIScrollView.h"

@implementation HP_UIScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //相应点击事件
    if (!self.dragging) {
        [[self nextResponder]touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging) {
        [[self nextResponder]touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event]; 
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
