//
//  ItemButton.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/17.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ItemButton.h"
@interface ItemButton()

//@property (nonatomic) kLivelyButtonStyle buttonStyle;

@end

@implementation ItemButton
@synthesize isSelected = _isSelected;

- (id)initWithFrame:(CGRect)frame withSelect:(BOOL)selected
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isSelected = selected;
        [self setButtonBackImage];
        
    }
    return self;
}

-(void) setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    [self setButtonBackImage];
}

-(void) switchStatus{
    _isSelected = !_isSelected;
    
    [self setButtonBackImage];
}

-(void) setButtonBackImage
{
    UIImage *image;
    if (_isSelected)
    {
        image = [UIImage imageNamed:@"列表-选择后"];
         //NSLog(@"width:%f,height:%f",image.size.width,image.size.height);
    }
    else
    {
        image = [UIImage imageNamed:@"列表-选择前"];
    }
    //UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    [self setBackgroundImage:image forState:UIControlStateNormal];
}


@end
