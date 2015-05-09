//
//  NSObject+HP_UIImageUtils.h
//  common4ios
//
//  Created by Yi Xu on 12-11-18.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_UIImageUtils:NSObject

//获得JPEG类型的图片的NSData类型对象
+(NSData *) getJPEGDataFromImage:(UIImage*) image;

//获得JPEG类型的图片的NSData类型对象，传入compressionQuality
+(NSData *) getJPEGDataFromImage:(UIImage*) image withCompressionQuality:(CGFloat) compressionQuality;

//获得PNG类型的图片的NSData类型对象
+(NSData *) getPNGDataFromImage:(UIImage*) image;

//根据CGSize获得相应大小的图片
+(UIImage *) getResizeImage:(UIImage *)image toSize:(CGSize) size;

//根据pixcels获得相应大小圆角的图片
+(UIImage *) getRoundCornerImage: (UIImage*) image withPixels: (int) pixels;

//添加图片水印
+(UIImage *)addToOldImage:(UIImage *)oldImage newImage:(UIImage *)newImage point:(CGPoint)point;

//根据文字获得图片
+(UIImage *)getImageFromText:(NSString *)text withFont:(UIFont *)font;

+(UIImage *)getImageFromText:(NSString *)text withFont:(UIFont *)font withColor:(UIColor *)color;

//根据文字获得图片-自动折行
+(UIImage *)getImageFromText:(NSString *)text inRect:(CGRect)rect withFont:(UIFont *)font;

+(UIImage *)getImageFromText:(NSString *)text inRect:(CGRect)rect withFont:(UIFont *)font withColor:(UIColor *)color;

@end
