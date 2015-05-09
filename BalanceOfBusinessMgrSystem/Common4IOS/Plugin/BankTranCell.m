//
//  BankTranCell.m
//  ipaycard
//
//  Created by apple on 13-4-7.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "BankTranCell.h"

@implementation BankTranCell
@synthesize nameLabel;
@synthesize cardNum;
@synthesize temImage;
@synthesize littleImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame =CGRectMake(0, 0 , 320, 60);
        self.backgroundColor = [UIColor whiteColor];
        
        temImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        //temImage.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        temImage.image = [UIImage imageNamed:@""];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 10, 90, 15)];
        //nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        nameLabel.text = @"";
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.backgroundColor = [UIColor clearColor];
        
        cardNum  = [[UILabel alloc] initWithFrame:CGRectMake (55, 30, 210, 15)];
        cardNum.text = @"";
        cardNum.font = [UIFont systemFontOfSize:14];
        cardNum.textColor = [UIColor darkGrayColor];
        //cardNum.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        cardNum.backgroundColor = [UIColor clearColor];
        
        littleImage = [[UIImageView alloc]initWithFrame:CGRectMake(150, 10, 15, 15)];
        //littleImage.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        littleImage.image = [UIImage imageNamed:@""];
        
        [self.contentView addSubview:temImage];
        [self.contentView addSubview:cardNum];
        [self.contentView addSubview:nameLabel];
        [self.contentView addSubview:littleImage];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subview in self.subviews) {
        self.backgroundView.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height);
        self.backgroundColor = [UIColor whiteColor];

        for (UIView *subview2 in subview.subviews) {
            if ([NSStringFromClass([subview2 class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) { // move delete confirmation view
                [subview bringSubviewToFront:subview2];
            }
        }
    }
}

@end
