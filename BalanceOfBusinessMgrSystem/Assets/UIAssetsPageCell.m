//
//  UIAssetsPageCell.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "UIAssetsPageCell.h"

@implementation UIAssetsPageCell
@synthesize backColor;
//- (id)initWithFrame:(CGRect)frame {
////    return [[FMPAImageView alloc] initWithFrame:frame
////                        backgroundProgressColor:[UIColor whiteColor]];
//}
-(void)setBackColor:(UIColor *)BackColor{
    backColor = BackColor;
    self.backgroundColor = backColor;
}

- (id)initWithFrame:(CGRect)frame leftUIImage:(UIImage *)leftUIImage titleText:(NSString*) titleText numText:(NSString*) numText
{
    self = [super initWithFrame:frame];
    if (self) {
        imageLeftView  = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, leftUIImage.size.width, leftUIImage.size.height)];
        //imageLeftView.frame =  CGRectMake(0, 0, leftUIImage.size.width, leftUIImage.size.height);
        [imageLeftView setImage:leftUIImage];
        [self addSubview:imageLeftView];
        
        titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(imageLeftView.frame.origin.x + imageLeftView.frame.size.width + 5, 5, self.frame.size.width-30, 30)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        titleLabel.text = titleText;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];

        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageLeftView.frame.origin.x +  5, titleLabel.frame.origin.y + titleLabel.frame.size.height + 5, self.frame.size.width-30, 20)];
        numLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        numLabel.text = numText;
        numLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numLabel];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
