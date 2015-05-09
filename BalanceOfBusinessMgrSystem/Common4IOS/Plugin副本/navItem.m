//
//  navItem.m
//  navigationbar
//
//  Created by han on 13-1-5.
//  Copyright (c) 2013年 wsyd. All rights reserved.
//

#import "navItem.h"

@implementation navItem
@synthesize statusImageV;

-(id) initWithTitle:(NSString *)title{
  
  CGFloat w = [title sizeWithFont:[UIFont fontWithName:@"Arial" size:22]].width;
  CGFloat h = [title sizeWithFont:[UIFont fontWithName:@"Arial" size:22]].height;
  
  self = [super initWithFrame:CGRectMake(0, 25, 30+w,h)];
  
  titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, w, 23)];
  titleLbl.text = title;
  titleLbl.textColor = [UIColor whiteColor];
  [titleLbl setFont:[UIFont fontWithName:@"Arial" size:22]];
  titleLbl.backgroundColor = [UIColor clearColor];
  [self addSubview:titleLbl];
  
    SysInfo *si = [SysInfo newInstence];
  statusImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
  [statusImageV setImage:[UIImage imageNamed:si.curNavImageName]];
  
  [self addSubview:statusImageV];
  
  return self;
}

@end
