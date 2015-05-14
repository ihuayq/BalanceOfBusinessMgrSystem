//
//  NaturalManInfoTableViewCell.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "NaturalManInfoTableViewCell.h"

@interface NaturalManInfoTableViewCell ()
{
    //UILabel *titleLabel;
    UILabel *manNameLabel;
    UILabel *identifyNumberLabel;
    UILabel *telephoneNumberLabel;
    UILabel *statusLabel;
    UILabel *noteModifyLabel;
    
}
@end


@implementation NaturalManInfoTableViewCell

-(void)setModel:(NaturalManItemModel *)model_
{
    _model = model_;
    //titleLabel.text = _model.title;
    manNameLabel.text  = _model.manName;
    identifyNumberLabel.text  = _model.identifyNumber;
    telephoneNumberLabel.text  = _model.telephoneNumber;
    statusLabel.text  = _model.status ;
    
    if (_model.bCanModify){
        noteModifyLabel.text  = @"可修改";
    }
    else{
        noteModifyLabel.text  = @"不可修改";
    }
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //自然人
        UILabel *manHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 72, 20)];
        manHeadLabel.textAlignment = NSTextAlignmentCenter;
        manHeadLabel.backgroundColor = [UIColor clearColor];
        manHeadLabel.textColor = [UIColor blackColor];
        manHeadLabel.font = [UIFont systemFontOfSize:16.0f];
        manHeadLabel.text = [NSString stringWithFormat:@"自然人%d:",1];
        [self.contentView addSubview:manHeadLabel];
        
        manNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(manHeadLabel.frame.origin.x + manHeadLabel.frame.size.width, 2, 120, 20)];
        manNameLabel.textAlignment = NSTextAlignmentLeft;
        manNameLabel.backgroundColor = [UIColor clearColor];
        manNameLabel.textColor = [UIColor blackColor];
        manNameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:manNameLabel];
        
        //身份证号码
        UILabel *identifyHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, manNameLabel.frame.origin.y + manNameLabel.frame.size.height + 5, 100, 20)];
        identifyHeadLabel.textAlignment = NSTextAlignmentCenter;
        identifyHeadLabel.backgroundColor = [UIColor clearColor];
        identifyHeadLabel.textColor = [UIColor blackColor];
        identifyHeadLabel.font = [UIFont systemFontOfSize:16.0f];
        identifyHeadLabel.text = @"身份证号码:";
        [self.contentView addSubview:identifyHeadLabel];
        
        identifyNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyHeadLabel.frame.origin.x + identifyHeadLabel.frame.size.width, manNameLabel.frame.origin.y + manNameLabel.frame.size.height + 5, 120, 20)];
        identifyNumberLabel.textAlignment = NSTextAlignmentLeft;
        identifyNumberLabel.backgroundColor = [UIColor clearColor];
        identifyNumberLabel.textColor = [UIColor blackColor];
        identifyNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:identifyNumberLabel];
        
        //手机号码
        UILabel *teleHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, identifyNumberLabel.frame.origin.y + identifyNumberLabel.frame.size.height + 5, 80, 20)];
        teleHeadLabel.textAlignment = NSTextAlignmentCenter;
        teleHeadLabel.backgroundColor = [UIColor clearColor];
        teleHeadLabel.textColor = [UIColor blackColor];
        teleHeadLabel.font = [UIFont systemFontOfSize:16.0f];
        teleHeadLabel.text = @"手机号码:";
        [self.contentView addSubview:teleHeadLabel];
        
        telephoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(teleHeadLabel.frame.origin.x + teleHeadLabel.frame.size.width, identifyNumberLabel.frame.origin.y + identifyNumberLabel.frame.size.height + 5, 140, 20)];
        telephoneNumberLabel.textAlignment = NSTextAlignmentLeft;
        telephoneNumberLabel.backgroundColor = [UIColor clearColor];
        telephoneNumberLabel.textColor = [UIColor blackColor];
        telephoneNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:telephoneNumberLabel];
        
        //状态
        UILabel *statusHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  telephoneNumberLabel.frame.origin.y + telephoneNumberLabel.frame.size.height + 5, 60, 20)];
        statusHeadLabel.textAlignment = NSTextAlignmentCenter;
        statusHeadLabel.backgroundColor = [UIColor clearColor];
        statusHeadLabel.textColor = [UIColor blackColor];
        statusHeadLabel.font = [UIFont systemFontOfSize:16.0f];
        statusHeadLabel.text = @"状态:";
        [self.contentView addSubview:statusHeadLabel];
        
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusHeadLabel.frame.origin.x + statusHeadLabel.frame.size.width, telephoneNumberLabel.frame.origin.y + telephoneNumberLabel.frame.size.height + 5, 120, 20)];
        statusLabel.textAlignment = NSTextAlignmentLeft;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.textColor = [UIColor blackColor];
        statusLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:statusLabel];
        
        
        //可修改状态
        noteModifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width -80, self.frame.size.height+20, 72, 20)];
        noteModifyLabel.textAlignment = NSTextAlignmentCenter;
        noteModifyLabel.backgroundColor = [UIColor clearColor];
        noteModifyLabel.textColor = [UIColor blackColor];
        noteModifyLabel.font = [UIFont systemFontOfSize:14.0f];
        noteModifyLabel.text = @"可修改";
        [self.contentView addSubview:noteModifyLabel];
        
        //确定
        UIButton *modifyButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
        [modifyButton setBackgroundImage:[UIImage imageNamed:@"modify"] forState:UIControlStateNormal];
        [modifyButton setBackgroundImage:[UIImage imageNamed:@"modify"] forState:UIControlStateHighlighted];
        [modifyButton setBackgroundColor:[UIColor greenColor]];
        [modifyButton setFrame:CGRectMake(self.frame.size.width -80, self.frame.size.height, 20, 20)];
        [modifyButton addTarget:self action:@selector(touchModifyButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:modifyButton];
    }
    return self;
}


-(void)touchModifyButton{
    
}

//-(NaturalManInfoTableViewCell *)initWithTitle:(NSString *)title bankName:(NSString*)bankName bankCardNumber:(NSString*)bankCardNumber{
//    if (self=[super init]) {
//        _title=title;
//        _bankCardNumber = bankName;
//        _bankCardNumber = bankCardNumber;
//    }
//    return self;
//}
//
//+(NaturalManInfoTableViewCell *)initWithTitle:(NSString *)title bankName:(NSString*)bankName bankCardNumber:(NSString*)bankCardNumber{
//    NaturalManInfoTableViewCell *cell = [[NaturalManInfoTableViewCell alloc] initWithTitle:title bankName:bankName bankCardNumber:bankName];
//    return cell;
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
