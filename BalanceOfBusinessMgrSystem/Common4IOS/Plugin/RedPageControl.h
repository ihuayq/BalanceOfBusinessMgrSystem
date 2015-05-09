//
//  RedPageControl.h
//  ipaycard
//
//  Created by RenLongfei on 13-12-16.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedPageControl : UIPageControl{
    UIImage *_activeImage;
    UIImage *_inactiveImage;
    NSArray *_usedToRetainOriginalSubview;
}
@property (nonatomic, strong)   UIImage *activeImage;
@property (nonatomic, strong)   UIImage *inactiveImage;


- (id)initWithFrame:(CGRect)frame currentImageName:(NSString *)current commonImageName:(NSString *)common;

@end
