//
//  BankTranCell.h
//  ipaycard
//
//  Created by apple on 13-4-7.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankTranCell : UITableViewCell{
    
    UILabel *nameLabel;
    UIImageView *temImage;
    UILabel *cardNum;
    
}
@property (nonatomic,retain)     UILabel *nameLabel;
@property (nonatomic,retain)     UIImageView *temImage;
@property (nonatomic,retain)     UIImageView *littleImage;

@property (nonatomic,retain)     UILabel *cardNum;

@end
