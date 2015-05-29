//
//  UIAssetsPageCell.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/8.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "UIAssetsPageCell.h"

@implementation UIAssetsPageCell

- (id)initWithFrame:(CGRect)frame leftUIImage:(UIImage *)leftUIImage titleText:(NSString*) titleText numText:(NSString*) numText
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageLeftView  = [[UIImageView alloc]  initWithFrame:CGRectMake(5, 10, leftUIImage.size.width, leftUIImage.size.height)];
        //imageLeftView.frame =  CGRectMake(0, 0, leftUIImage.size.width, leftUIImage.size.height);
        [_imageLeftView setImage:leftUIImage];
        [self addSubview:_imageLeftView];
        
        _titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(_imageLeftView.frame.origin.x + _imageLeftView.frame.size.width + 5, 5, self.frame.size.width-30, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.text = titleText;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];

        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 5, self.frame.size.width-5*2, 20)];
        _numLabel.font = [UIFont systemFontOfSize:24.0f];
        if ([numText isEqualToString:@"0"]) {
            _numLabel.text = @"0.00";
        }
        else{
            _numLabel.text = numText;
        }
        _numLabel.textColor = UIColorFromRGB(0xF9551C);
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numLabel];

    }
    return self;
}

-(void)setMoneyNum:(NSString *)moneyNum{
    _moneyNum = moneyNum;
    if ([_moneyNum isEqualToString:@"0"]) {
        _numLabel.text = @"0.00";
    }
    else{
        _numLabel.text = _moneyNum;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
