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
    UILabel *manHeadLabel ;
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
    manHeadLabel.text = [NSString stringWithFormat:@"自然人%d:",_model.nPosition];
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //自然人
        manHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 72, 20)];
        manHeadLabel.textAlignment = NSTextAlignmentLeft;
        manHeadLabel.backgroundColor = [UIColor clearColor];
        manHeadLabel.textColor = [UIColor blackColor];
        manHeadLabel.font = [UIFont systemFontOfSize:16.0f];
        //manHeadLabel.text = [NSString stringWithFormat:@"自然人%d:",1];
        [self.contentView addSubview:manHeadLabel];
        
        manNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(manHeadLabel.frame.origin.x + manHeadLabel.frame.size.width,5, 120, 20)];
        manNameLabel.textAlignment = NSTextAlignmentLeft;
        manNameLabel.backgroundColor = [UIColor clearColor];
        manNameLabel.textColor = [UIColor lightGrayColor];
        manNameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:manNameLabel];
        
        //身份证号码
        UILabel *identifyHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, manNameLabel.frame.origin.y + manNameLabel.frame.size.height + 2, 100, 20)];
        identifyHeadLabel.textAlignment = NSTextAlignmentLeft;
        identifyHeadLabel.backgroundColor = [UIColor clearColor];
        identifyHeadLabel.textColor = [UIColor blackColor];
        identifyHeadLabel.font = [UIFont systemFontOfSize:16.0f];
        identifyHeadLabel.text = @"身份证号码:";
        [self.contentView addSubview:identifyHeadLabel];
        
        identifyNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyHeadLabel.frame.origin.x + identifyHeadLabel.frame.size.width, manNameLabel.frame.origin.y + manNameLabel.frame.size.height + 2, 200, 20)];
        identifyNumberLabel.textAlignment = NSTextAlignmentLeft;
        identifyNumberLabel.backgroundColor = [UIColor clearColor];
        identifyNumberLabel.textColor = [UIColor lightGrayColor];
        identifyNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:identifyNumberLabel];
        
        //手机号码
        UILabel *teleHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, identifyNumberLabel.frame.origin.y + identifyNumberLabel.frame.size.height + 2, 80, 20)];
        teleHeadLabel.textAlignment = NSTextAlignmentLeft;
        teleHeadLabel.backgroundColor = [UIColor clearColor];
        teleHeadLabel.textColor = [UIColor blackColor];
        teleHeadLabel.font = [UIFont systemFontOfSize:16.0f];
        teleHeadLabel.text = @"手机号码:";
        [self.contentView addSubview:teleHeadLabel];
        
        telephoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(teleHeadLabel.frame.origin.x + teleHeadLabel.frame.size.width, identifyNumberLabel.frame.origin.y + identifyNumberLabel.frame.size.height + 2, 140, 20)];
        telephoneNumberLabel.textAlignment = NSTextAlignmentLeft;
        telephoneNumberLabel.backgroundColor = [UIColor clearColor];
        telephoneNumberLabel.textColor = [UIColor lightGrayColor];
        telephoneNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:telephoneNumberLabel];
        
        //状态
        UILabel *statusHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,  telephoneNumberLabel.frame.origin.y + telephoneNumberLabel.frame.size.height + 2, 60, 20)];
        statusHeadLabel.textAlignment = NSTextAlignmentLeft;
        statusHeadLabel.backgroundColor = [UIColor clearColor];
        statusHeadLabel.textColor = [UIColor blackColor];
        statusHeadLabel.font = [UIFont systemFontOfSize:16.0f];
        statusHeadLabel.text = @"状态:";
        [self.contentView addSubview:statusHeadLabel];
        
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusHeadLabel.frame.origin.x + statusHeadLabel.frame.size.width, telephoneNumberLabel.frame.origin.y + telephoneNumberLabel.frame.size.height + 2, 120, 20)];
        statusLabel.textAlignment = NSTextAlignmentLeft;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.textColor = [UIColor lightGrayColor];
        statusLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:statusLabel];
        
        
        //可修改状态
        noteModifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, self.frame.size.height+20, 60, 20)];
        noteModifyLabel.textAlignment = NSTextAlignmentCenter;
        noteModifyLabel.backgroundColor = [UIColor clearColor];
        noteModifyLabel.textColor = [UIColor lightGrayColor];
        noteModifyLabel.font = [UIFont systemFontOfSize:14.0f];
        //noteModifyLabel.text = @"可修改";
        [self.contentView addSubview:noteModifyLabel];
        

    }
    return self;
}




- (UITableView *)relatedTable
{
    if ([self.superview isKindOfClass:[UITableView class]])
        return (UITableView *)self.superview;
    else if ([self.superview.superview isKindOfClass:[UITableView class]])
        return (UITableView *)self.superview.superview;
    else
    {
        NSAssert(NO, @"UITableView shall always be found.");
        return nil;
    }
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
