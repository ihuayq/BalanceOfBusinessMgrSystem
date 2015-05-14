//
//  AssetDetailTableViewCell.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/14.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "AssetDetailTableViewCell.h"

@implementation AssetDetailTableViewCell

-(void)setModel:(AssetRecordItemInfo *)model_
{
    _model = model_;
    
    CGSize FirstTitleSize = [model_.FirstItem sizeWithFont:FirstLabel.font constrainedToSize:CGSizeMake(MainWidth/4, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    if (FirstTitleSize.width>MainWidth/4) {
        FirstTitleSize.width = MainWidth/4;
    }
    FirstLabel.frame = CGRectMake(MainWidth/4*0, 0, FirstTitleSize.width, FirstTitleSize.height);
    FirstLabel.text = model_.FirstItem ;
    
    CGSize SecondTitleSize = [model_.SecondItem sizeWithFont:SecondLabel.font constrainedToSize:CGSizeMake(MainWidth/4, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    if (SecondTitleSize.width>MainWidth/4) {
        SecondTitleSize.width = MainWidth/4;
    }
    SecondLabel.frame = CGRectMake(MainWidth/4*1, 0, SecondTitleSize.width, SecondTitleSize.height);
    SecondLabel.text = model_.SecondItem ;
    
    CGSize ThirdTitleSize = [model_.ThirdItem sizeWithFont:FirstLabel.font constrainedToSize:CGSizeMake(MainWidth/4, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    if (ThirdTitleSize.width>MainWidth/4) {
        ThirdTitleSize.width = MainWidth/4;
    }
    ThirdLabel.frame = CGRectMake(MainWidth/4*2, 0, ThirdTitleSize.width, ThirdTitleSize.height);
    ThirdLabel.text = model_.ThirdItem ;
    
    CGSize FourthTitleSize = [model_.FourthItem sizeWithFont:FourthLabel.font constrainedToSize:CGSizeMake(MainWidth/4, CGFLOAT_MAX) lineBreakMode:NSLineBreakByClipping];
    if (FourthTitleSize.width>MainWidth/4) {
        FourthTitleSize.width = MainWidth/4;
    }
    FourthLabel.frame = CGRectMake(MainWidth/4*3, 0, FourthTitleSize.width, FourthTitleSize.height);
    FourthLabel.text = model_.FourthItem ;
    


}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSNumber *width = [[NSNumber alloc] initWithInt:MainWidth/4];
        
        //初始化label
        FirstLabel =  [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/4*0,0,0,0)];;
        FirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        FirstLabel.textAlignment = NSTextAlignmentCenter;
        FirstLabel.backgroundColor = [UIColor clearColor];
        FirstLabel.textColor = [UIColor whiteColor];
        FirstLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:FirstLabel];
        
        SecondLabel =  [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/4*1,0,0,0)];;
        SecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        SecondLabel.textAlignment = NSTextAlignmentCenter;
        SecondLabel.backgroundColor = [UIColor clearColor];
        SecondLabel.textColor = [UIColor whiteColor];
        SecondLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:SecondLabel];
        
        ThirdLabel =  [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/4*2,0,0,0)];;
        ThirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        ThirdLabel.textAlignment = NSTextAlignmentCenter;
        ThirdLabel.backgroundColor = [UIColor clearColor];
        ThirdLabel.textColor = [UIColor whiteColor];
        ThirdLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:ThirdLabel];
        
        FourthLabel =  [[UILabel alloc] initWithFrame:CGRectMake(MainWidth/4*3,0,0,0)];;
        FourthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        FourthLabel.textAlignment = NSTextAlignmentCenter;
        FourthLabel.backgroundColor = [UIColor clearColor];
        FourthLabel.textColor = [UIColor whiteColor];
        FourthLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:FourthLabel];
        
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
