//
//  navItem.h
//  navigationbar
//
//  Created by han on 13-1-5.
//  Copyright (c) 2013年 wsyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SysInfo.h"

@interface navItem : UIView{
  UIImageView *statusImageV;
  UILabel *titleLbl;
}

@property (nonatomic,retain) UIImageView *statusImageV;

-(id) initWithTitle:(NSString *)title;

@end
