//
//  cardSwipeAlertView.h
//  navigationbar
//
//  Created by han on 13-1-5.
//  Copyright (c) 2013年 wsyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardSwipeDelegate.h"

@interface cardSwipeAlertView : UIAlertView{
  UIImageView *movingImage;
    id<CardSwipeDelegate> csd;
}
@property (nonatomic, retain) id<CardSwipeDelegate> csd;
@end
