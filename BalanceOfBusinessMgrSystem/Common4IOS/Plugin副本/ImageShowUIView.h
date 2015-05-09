//
//  ImageShowUIView.h
//  ipaycard
//
//  Created by han bing on 13-1-6.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Scale.h"

@interface ImageShowUIView : UIView{
    UIImageView *curImageV;
    
    CGFloat animationTime;
    int imageIndex;
}


@end
