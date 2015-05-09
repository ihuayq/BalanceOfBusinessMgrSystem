//
//  SearchDownView.m
//  ipaycard
//
//  Created by RenLongfei on 13-12-26.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "SearchDownView.h"

@implementation SearchDownView

@synthesize searchTxtField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame]; //60 320
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"图层-46.png"]];
        
        UIImageView  *uplineImg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        uplineImg.image = [UIImage imageNamed:@"cell_longline.png"];
        [self addSubview:uplineImg];
        
        UIImageView *frameImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 300, 50)];
        frameImage.image = [UIImage imageNamed:@"方框back.png"];
        frameImage.userInteractionEnabled = YES;
        [self addSubview:frameImage];
        
        UIImageView *searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 37, 40)];
        searchImage.image = [UIImage imageNamed:@"ticket_search.png"];
        [frameImage addSubview:searchImage];
        
        searchTxtField = [[UITextField alloc]initWithFrame:CGRectMake(45, 5, 250, 40)];
        searchTxtField.placeholder = @"输入首字母\\数字搜索";
        searchTxtField.keyboardType = UIKeyboardTypeASCIICapable;
        searchTxtField.tag = 10002;
        searchTxtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [frameImage addSubview:searchTxtField];
        
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
