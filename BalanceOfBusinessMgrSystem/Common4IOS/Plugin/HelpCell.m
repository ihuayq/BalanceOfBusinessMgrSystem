//
//  CommentsCell.m
//  糗百
//
//  Created by Apple on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelpCell.h"

@implementation HelpCell
@synthesize  bankImage,bankName,succeTime,centerimageView,footView;
@synthesize cellType=_cellType;
@synthesize authUserLab,userLab,noAuthLab,noLab;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
     
        UIImage *centerimage=[UIImage imageNamed:@"block_center_background.png"];
        centerimageView=[[UIImageView alloc] initWithImage:centerimage];
        [centerimageView setFrame:CGRectMake(0, 0, 320, 220)];
        
        
        UIImage *footimage = [UIImage imageNamed:@"交易记录line.png"];
        footView = [[UIImageView alloc]initWithImage:footimage];
        footView.frame = CGRectMake(0, 100, 320, 1);
       
    }
    return self;
}

-(UILabel *)bankName{
    if (!bankName) {
        bankName = [[UILabel alloc] init];
        [bankName setBackgroundColor:[UIColor clearColor]];
        [bankName setFrame:CGRectMake(10, bankImage.frame.origin.y +bankImage.frame.size.width ,100, 30)];
        [bankName setFont:[UIFont systemFontOfSize:13.0]];
        
    }
    return bankName;
}

- (UILabel *)succeTime{
    if (!succeTime) {
        succeTime = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 120, 25)];
        [succeTime setBackgroundColor:[UIColor clearColor]];
        //succeTime.adjustsLetterSpacingToFitWidth = YES;
        [succeTime setFont:[UIFont systemFontOfSize:13.0]];

    }
    return succeTime;
}

- (UIImageView * )bankImage{
    if (!bankImage) {
        
        bankImage = [[UIImageView alloc] init];
        [bankImage setFrame:CGRectMake(10, 20, 50, 50)];
    }
    return bankImage;
}
-(void)setCellType:(BaseCellTypeType)cellType{
    _cellType = cellType;
    switch (cellType) {
        case BaseCellTypeFirstType:
            
            
            userLab =  [self creatLabelInCell:CGRectMake(100, 30, 75, 25) Text:@"未认证用户" TextColor:[UIColor blackColor]  withFont:[UIFont systemFontOfSize:14]];
            
            authUserLab  =  [self creatLabelInCell:CGRectMake(userLab.frame.origin.x+userLab.frame.size.width , userLab.frame.origin.y, 150, 25) Text:@"：单笔还款限额5万" TextColor:[UIColor darkGrayColor] withFont:[UIFont systemFontOfSize:13]];
            //authUserLab.backgroundColor = [UIColor redColor];
            
           // dayLimit= [self creatLabelInCell:CGRectMake(authUserLab.frame.origin.x , userLab.frame.origin.y+5, 150, 50) Text:@"日累计还款限额5000元" TextColor:[UIColor darkGrayColor] withFont:[UIFont systemFontOfSize:13]];
            
            noLab =  [self creatLabelInCell:CGRectMake(userLab.frame.origin.x, userLab.frame.origin.y+20, userLab.frame.size.width, userLab.frame.size.height) Text:@"认证用户" TextColor:[UIColor blackColor]  withFont:[UIFont systemFontOfSize:14]];
             
            noAuthLab =  [self creatLabelInCell:CGRectMake(authUserLab.frame.origin.x, noLab.frame.origin.y,authUserLab.frame.size.width,authUserLab.frame.size.height) Text:@"：单笔还款限额50万" TextColor:[UIColor darkGrayColor]   withFont:[UIFont systemFontOfSize:13]];
            
          //dayLiMitTwo =  [self creatLabelInCell:CGRectMake(authUserLab.frame.origin.x, noAuthLab.frame.origin.y + 18,authUserLab.frame.size.width+10,authUserLab.frame.size.height) Text:@"日累计还款限额25000元" TextColor:[UIColor darkGrayColor]   withFont:[UIFont systemFontOfSize:13]];
            
            
            footView.frame = CGRectMake(0, 100, 320, 1);
            iconImage = [[UIImageView alloc] init];
            iconImage.frame = CGRectMake(40, 30, 50, 50);
            iconImage.image = [UIImage imageNamed:@"icIcon.png"];
            
            [self.contentView addSubview:userLab];
            [self.contentView addSubview:authUserLab];
            [self.contentView addSubview:noLab];
            [self.contentView addSubview:noAuthLab];
            [self.contentView addSubview:footView];
            [self.contentView addSubview:iconImage];
    
            break;
            
        case BaseCellTypeSecondType:
        
            footView.frame = CGRectMake(0, 100, 320, 1);
                     
            [self.contentView addSubview:centerimageView];
            [self.contentView addSubview:footView];
            [self.contentView addSubview:self.bankImage];
            [self.contentView addSubview:self.bankName];
            [self.contentView addSubview:self.succeTime];
            
            break;
            
            
        default:
            break;
    }
    
}
-(UILabel *)creatLabelInCell:(CGRect)rect Text:(NSString *)text TextColor:(UIColor *)textColor  withFont:(UIFont *)textFont {
    UILabel *label1 = [[UILabel alloc]initWithFrame:rect];
    label1.textColor = textColor;
    label1.backgroundColor = [UIColor clearColor];
    label1.font = textFont;
    label1.text = text;
    [self addSubview:label1];
    return label1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
