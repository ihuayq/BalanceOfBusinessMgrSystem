//
//  HP_UILabel.m
//  blog
//
//  Created by Yi Xu on 12-11-26.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import "HP_UILabel.h"

@implementation HP_UILabel

@synthesize isUnderline;
@synthesize underLineColor;

@synthesize insets = _insets;

-(id) init
{
    self = [super init];
    if (self)
    {
        isUnderline = NO;
        underLineColor = [UIColor redColor];
    }
    
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isUnderline = NO;
        underLineColor = [UIColor redColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self) {
        self.insets = insets;
    }
    return self;
}

- (id)initWithInsets:(UIEdgeInsets)insets
{
    self = [super init];
    if(self)
    {
        self.insets = insets;
    }
    return self;
}


- (void)drawTextInRect:(CGRect)rect
{
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (isUnderline)
    {
        
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGSize fontSize = [self.text sizeWithFont:self.font forWidth:self.bounds.size.width lineBreakMode:NSLineBreakByTruncatingTail];
//        CGSize fontSize =[self.text sizeWithFont:self.font
//                                        forWidth:self.bounds.size.width
//                                   lineBreakMode:UILineBreakModeTailTruncation];
        // Get the fonts color.
        CGColorRef colorRef = [underLineColor CGColor];
        int numComponents = CGColorGetNumberOfComponents(colorRef);
        if (numComponents >= 3){
            const CGFloat *rgbComponents = CGColorGetComponents(colorRef);
            CGContextSetRGBFillColor(ctx, rgbComponents[0], rgbComponents[1], rgbComponents[2], rgbComponents[3]);
        }
        
        // Line Width : make thinner or bigger if you want
        CGContextSetLineWidth(ctx, 1.0f);
        
        // Calculate the starting point (left) and target (right)
        CGPoint l = CGPointMake(self.frame.size.width/2.0 - fontSize.width/2.0,
                                self.frame.size.height/2.0 +fontSize.height/2.0);
        CGPoint r = CGPointMake(self.frame.size.width/2.0 + fontSize.width/2.0,
                                self.frame.size.height/2.0 + fontSize.height/2.0);
        
        
        // Add Move Command to point the draw cursor to the starting point
        CGContextMoveToPoint(ctx, l.x, l.y);
        
        // Add Command to draw a Line
        CGContextAddLineToPoint(ctx, r.x, r.y);
        
        
        // Actually draw the line.
        CGContextStrokePath(ctx);
        
        // should be nothing, but who knows...
    }
}

-(void)underLineColor:(UIColor*)color
{

    underLineColor=color;
}

@end
