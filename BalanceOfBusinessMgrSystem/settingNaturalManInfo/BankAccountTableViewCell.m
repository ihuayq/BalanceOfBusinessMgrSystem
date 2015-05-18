//
//  NetworkPointAccountTableViewCell.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BankAccountTableViewCell.h"
#import "RadioButton.h"

@interface BankAccountTableViewCell ()<RadioButtonDelegate>
{
    UILabel * titleLabel;
    
    UILabel * bankNameLabel;
    UILabel * bankCardNumberLabel;
    RadioButton *selectButton;
}
@end

@implementation BankAccountTableViewCell
@synthesize title= _title;
@synthesize bankCardNumber =_bankCardNumber;
@synthesize bankName = _bankName;
@synthesize bSelected =_bSelected;
@synthesize bShowRadioBtn =_bShowRadioBtn;

//-(BankAccountTableViewCell*)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2, 30, 20)];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.font = [UIFont systemFontOfSize:16.0f];
//        [self.contentView addSubview:titleLabel];
//        
//        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, 120, 20)];
//        bankNameLabel.textAlignment = NSTextAlignmentCenter;
//        bankNameLabel.backgroundColor = [UIColor clearColor];
//        bankNameLabel.textColor = [UIColor whiteColor];
//        bankNameLabel.font = [UIFont systemFontOfSize:16.0f];
//        [self.contentView addSubview:bankNameLabel];
//        
//        bankCardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2 + 20 , 120, 20)];
//        bankCardNumberLabel.textAlignment = NSTextAlignmentCenter;
//        bankCardNumberLabel.backgroundColor = [UIColor clearColor];
//        bankCardNumberLabel.textColor = [UIColor whiteColor];
//        bankCardNumberLabel.font = [UIFont systemFontOfSize:16.0f];
//        [self.contentView addSubview:bankCardNumberLabel];
//        
//    }
//    return self;
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.bounds.size.height/2, 60, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:titleLabel];
        
        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-30, self.bounds.size.height/2-10, 120, 20)];
        bankNameLabel.textAlignment = NSTextAlignmentLeft;
        bankNameLabel.backgroundColor = [UIColor clearColor];
        bankNameLabel.textColor = [UIColor grayColor];
        bankNameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:bankNameLabel];
        
        bankCardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-15-40, self.bounds.size.height/2 + 10 , 180, 20)];
        bankCardNumberLabel.textAlignment = NSTextAlignmentLeft;
        bankCardNumberLabel.backgroundColor = [UIColor clearColor];
        bankCardNumberLabel.textColor = [UIColor grayColor];
        bankCardNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:bankCardNumberLabel];
        
        selectButton=[[RadioButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40, self.bounds.size.height/2, 15, 15) typeCheck:NO];
        [selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        selectButton.titleLabel.font=[UIFont systemFontOfSize:12];
        selectButton.delegate=self;
        selectButton.tag=707;
        [self.contentView addSubview:selectButton];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hasSelectBtn:(bool)hasSelectBtn
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.bounds.size.height/2, 60, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:titleLabel];
        
        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-30, self.bounds.size.height/2-10, 120, 20)];
        bankNameLabel.textAlignment = NSTextAlignmentLeft;
        bankNameLabel.backgroundColor = [UIColor clearColor];
        bankNameLabel.textColor = [UIColor grayColor];
        bankNameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:bankNameLabel];
        
        bankCardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-15-40, self.bounds.size.height/2 + 10 , 180, 20)];
        bankCardNumberLabel.textAlignment = NSTextAlignmentLeft;
        bankCardNumberLabel.backgroundColor = [UIColor clearColor];
        bankCardNumberLabel.textColor = [UIColor grayColor];
        bankCardNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:bankCardNumberLabel];
        

        if (hasSelectBtn) {
            selectButton=[[RadioButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40, self.bounds.size.height/2, 15, 15) typeCheck:NO];
            [selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            selectButton.titleLabel.font=[UIFont systemFontOfSize:12];
            selectButton.delegate=self;
            selectButton.tag=707;
            [self.contentView addSubview:selectButton];
        }
        
        
    }
    return self;
}


- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect{
    int flags = 0;
    if (tagselect==708) {
    }
    
}


-(BankAccountTableViewCell *)initWithTitle:(NSString *)title bankName:(NSString*)bankName bankCardNumber:(NSString*)bankCardNumber{
    if (self=[super init]) {
        _title=title;
        _bankCardNumber = bankName;
        _bankCardNumber = bankCardNumber;
    }
    return self;
}

+(BankAccountTableViewCell *)initWithTitle:(NSString *)title bankName:(NSString*)bankName bankCardNumber:(NSString*)bankCardNumber{
    BankAccountTableViewCell *cell = [[BankAccountTableViewCell alloc] initWithTitle:title bankName:bankName bankCardNumber:bankName];
    return cell;
}

-(void)setBankCardNumber:(NSString *)bankCardNumber{
    bankCardNumberLabel.text = bankCardNumber;
}

-(void)setBankName:(NSString *)bankName{
    bankNameLabel.text = bankName;
}

-(void)setTitle:(NSString *)title{
    titleLabel.text = title;
}

-(void)setBShowRadioBtn:(bool)bShowRadioBtn{
    _bShowRadioBtn = bShowRadioBtn;
    selectButton.hidden = _bShowRadioBtn;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

