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
        
        bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2-10, 120, 20)];
        bankNameLabel.textAlignment = NSTextAlignmentCenter;
        bankNameLabel.backgroundColor = [UIColor clearColor];
        bankNameLabel.textColor = [UIColor blackColor];
        bankNameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:bankNameLabel];
        
        bankCardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2 + 10 , 120, 20)];
        bankCardNumberLabel.textAlignment = NSTextAlignmentCenter;
        bankCardNumberLabel.backgroundColor = [UIColor clearColor];
        bankCardNumberLabel.textColor = [UIColor blackColor];
        bankCardNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:bankCardNumberLabel];
        
        selectButton=[[RadioButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20, self.bounds.size.height/2, 15, 15) typeCheck:YES];
        [selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[selectButton setTitle:@"我已阅读并且同意投资授权协议" forState:UIControlStateNormal];
        selectButton.titleLabel.font=[UIFont systemFontOfSize:12];
        selectButton.delegate=self;
        selectButton.tag=707;
        [self.contentView addSubview:selectButton];
        
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


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

