//
//  HP_UITextField.m
//  youyouapp
//
//  Created by 融通互动 on 12-12-3.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import "HP_UITextField.h"

@implementation HP_UITextField

@synthesize insets = _insets;

//-(id)init{
//
//    self = [super init];
//    if (self)
//    {
//        _hasChangePlaceHolderColor = NO;
//        _hasChangePlaceHolderFont = NO;
//    }
//    return self;
//}
//-(void)setPlaceHolderColor:(UIColor *)placeHolderColor
//{
//    _hasChangePlaceHolderColor = YES;
//    _placeHolderColor = placeHolderColor;
//}
//
//-(void)setPlaceHolderFont:(UIFont *)placeHolderFont
//{
//    _hasChangePlaceHolderFont = YES;
//    _placeHolderFont = placeHolderFont;
//}
//
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        
        //设置输入框中的内容垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
   
        
    }
    return self;
}

//设置默认文字和是否消除文字
//-(void)setPlaceholder:(NSString *)str andClearButton:(BOOL)flag
//{
//    [self setPlaceholder:str];
//    
//    if (flag)
//    {
//        self.clearButtonMode = UITextFieldViewModeAlways;
//    }
//    else
//    {
//        self.clearButtonMode = UITextFieldViewModeNever;
//    }
//}
//
//
////控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    if (_hasChangePlaceHolderColor)
//    {
//        [_placeHolderColor setFill];
//    }
//    else
//    {
//        [[UIColor grayColor] setFill];
//    }
//    
//    if (_hasChangePlaceHolderFont)
//    {
//        
//        [[self placeholder] drawInRect:rect withFont:_placeHolderFont];
//        
//    }
//    else
//    {
//        [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
//       
//    }
//    
//    
//}

@end
