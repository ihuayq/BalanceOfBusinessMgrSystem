//
//  UIImage+Common4IOS.h
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common4IOS)

//??
- (UIImage *)compressedImage;

//获得UIImage的compressionQuality
- (CGFloat) compressionQuality;

//获得UIImage的NSData数据
- (NSData *)compressedData;

//获得UIImage的NSData数据,根据compressionQuality
- (NSData *)compressedDataWithCompressionQuality:(CGFloat)compressionQuality;

@end
