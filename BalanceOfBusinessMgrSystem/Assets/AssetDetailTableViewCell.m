//
//  AssetDetailTableViewCell.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/14.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "AssetDetailTableViewCell.h"

@implementation AssetDetailTableViewCell

@synthesize labelCount = _labelCount;
-(void)setModel:(AssetRecordItemInfo *)model_
{
    _model = model_;
    NSLog(@"model is%@",_model);
    
    float width = MainWidth/_labelCount;
    
    CGSize FirstTitleSize = [model_.FirstItem sizeWithFont:FirstLabel.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    if (FirstTitleSize.width>MainWidth/4) {
        FirstTitleSize.width = MainWidth/4;
    }
    FirstLabel.frame = CGRectMake(width*0, 0, width, FirstTitleSize.height+16);
    FirstLabel.text = model_.FirstItem ;
    
    CGSize SecondTitleSize = [model_.SecondItem sizeWithFont:SecondLabel.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    if (SecondTitleSize.width>width) {
        SecondTitleSize.width = width;
    }
    SecondLabel.frame = CGRectMake(width*1, 0, width, SecondTitleSize.height+16);
    SecondLabel.text = model_.SecondItem ;
    
    if (model_.nPosition == 0) {
        CGSize ThirdTitleSize = [model_.ThirdItem sizeWithFont:FirstLabel.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
        if (ThirdTitleSize.width>width) {
            ThirdTitleSize.width = width;
        }
        ThirdLabel.frame = CGRectMake(width*2, 0, width, ThirdTitleSize.height+16);
        ThirdLabel.text = model_.ThirdItem ;
        ThirdPicView.hidden = YES;
    }
    
    else{
        [ThirdPicView setFrame:CGRectMake(width*2 + width/2 - 8, 8, 16, 16)];
        if ([model_.ThirdItem isEqualToString:@"100"]) {
            [ThirdPicView setImage:[UIImage imageNamed:@"成功"]];
        }
        else{
            [ThirdPicView setImage:[UIImage imageNamed:@"失败"]];
        }
        ThirdLabel.hidden = YES;
    }
    
    if (_labelCount == 4) {
        CGSize FourthTitleSize = [model_.FourthItem sizeWithFont:FourthLabel.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
        if (FourthTitleSize.width>width) {
            FourthTitleSize.width = width;
        }
        FourthLabel.frame = CGRectMake(width*3, 0, width, FourthTitleSize.height+16);
        FourthLabel.text = model_.FourthItem ;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withColumCount:(uint)columCount
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _labelCount = columCount;
        //NSNumber *width = [[NSNumber alloc] initWithInt:MainWidth/_labelCount];
        float width = MainWidth/_labelCount;
        
        //初始化label
        FirstLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*0,0,0,0)];;
        FirstLabel.textAlignment = NSTextAlignmentCenter;
        FirstLabel.backgroundColor = [UIColor clearColor];
        //FirstLabel.textColor = [UIColor whiteColor];
        FirstLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:FirstLabel];
        
        SecondLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*1,0,0,0)];;
        SecondLabel.textAlignment = NSTextAlignmentCenter;
        SecondLabel.backgroundColor = [UIColor clearColor];
        //SecondLabel.textColor = [UIColor whiteColor];
        SecondLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:SecondLabel];
        
        ThirdLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*2,0,0,0)];;
        ThirdLabel.textAlignment = NSTextAlignmentCenter;
        ThirdLabel.backgroundColor = [UIColor clearColor];
        ThirdLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:ThirdLabel];
        
        ThirdPicView = [[UIImageView alloc] initWithFrame:CGRectMake(width*2, 0,0,0)];
        [self.contentView addSubview:ThirdPicView];
        
        if (_labelCount == 4) {
            FourthLabel =  [[UILabel alloc] initWithFrame:CGRectMake(width*3,0,0,0)];;
            FourthLabel.textAlignment = NSTextAlignmentCenter;
            FourthLabel.backgroundColor = [UIColor clearColor];
            //FourthLabel.textColor = [UIColor whiteColor];
            FourthLabel.font = [UIFont systemFontOfSize:14.0f];
            [self.contentView addSubview:FourthLabel];
        }

        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
