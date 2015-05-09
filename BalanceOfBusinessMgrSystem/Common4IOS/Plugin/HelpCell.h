//
//  CommentsCell.h
//  糗百
//
//  Created by Apple on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    BaseCellTypeFirstType  = 0,
    BaseCellTypeSecondType = 1,
    
}BaseCellTypeType;
@interface HelpCell : UITableViewCell
{
    //银行图片
    UIImageView *bankImage;
    //银行名字
    UILabel *bankName;
    //到账日期
    UILabel *succeTime;
    
    UIImageView *centerimageView;
    //底部的画笔
    UIImageView *footView;
    
    UILabel  *userLab;
    UILabel *authUserLab;
    UILabel *noLab;
    UILabel  *noAuthLab;
    UILabel *dayLimit;
    UILabel  *dayLiMitTwo;
    UIImageView  *iconImage;
}
@property (nonatomic,assign) BaseCellTypeType cellType;
@property(nonatomic,retain) UIImageView *bankImage;
@property(nonatomic, retain) UILabel *bankName;
@property(nonatomic,retain)  UILabel *succeTime;
@property (nonatomic, retain) UIImageView *footView;
@property (nonatomic, retain) UIImageView *centerimageView;

@property (nonatomic, retain) UILabel  *userLab,*authUserLab,*noLab,*noAuthLab;
-(void)setCellType:(BaseCellTypeType)cellType;
@end
