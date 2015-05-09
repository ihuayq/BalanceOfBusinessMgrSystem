//
//  NSObject+HP_UIImageUtils.m
//  common4ios
//
//  Created by Yi Xu on 12-11-18.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import "HP_UIImageUtils.h"

@implementation HP_UIImageUtils


+(NSData *) getJPEGDataFromImage:(UIImage*) image{
    return UIImageJPEGRepresentation(image, 1.0);
}

+(NSData *) getJPEGDataFromImage:(UIImage*) image withCompressionQuality:(CGFloat) compressionQuality {
    return UIImageJPEGRepresentation(image, compressionQuality);
}

+(NSData *) getPNGDataFromImage:(UIImage*) image{
    return UIImagePNGRepresentation(image);
}

+(UIImage *) getResizeImage:(UIImage *)image toSize:(CGSize) size;
{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+(UIImage *) getRoundCornerImage:(UIImage*) image withPixels:(int) pixels
{
    int w = image.size.width;
    int h = image.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    addRoundedRectToPath(context, rect, pixels, pixels);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *roundCornerImage  = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    return roundCornerImage;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect),
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


+(UIImage *)addToOldImage:(UIImage *)oldImage newImage:(UIImage *)newImage point:(CGPoint)point
{
    //get image width and height
    int w = oldImage.size.width;
    int h = oldImage.size.height;
    int newImageWidth = newImage.size.width;
    int newImageHeight = newImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), oldImage.CGImage);
    CGContextDrawImage(context, CGRectMake(point.x, point.y, newImageWidth, newImageHeight), [newImage CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *waterImage  = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    return waterImage;
    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}


+(UIImage *)getImageFromText:(NSString *)text withFont:(UIFont *)font{
    
    CGSize size  = [text sizeWithFont:font];
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // optional: add a shadow
    // optional: also, to avoid clipping you should make the context size bigger
    //    CGContextSetShadowWithColor(ctx, CGSizeMake(2.0, -2.0), 5.0, [color CGColor]);
    
    CGContextSetRGBFillColor(ctx, 255, 255, 255, 1);
    // draw in context
    
    CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
    [text drawAtPoint:CGPointMake(0.0, 0.0) withFont:font];
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)getImageFromText:(NSString *)text withFont:(UIFont *)font withColor:(UIColor *)color{
    CGSize size  = [text sizeWithFont:font];
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGColorRef colorRef = [color CGColor];
    int numComponents = CGColorGetNumberOfComponents(colorRef);
    if (numComponents >= 3){
        const CGFloat *rgbComponents = CGColorGetComponents(colorRef);
        CGContextSetRGBFillColor(ctx, rgbComponents[0], rgbComponents[1], rgbComponents[2], rgbComponents[3]);
    }
    
    CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
    [text drawAtPoint:CGPointMake(0.0, 0.0) withFont:font];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)getImageFromText:(NSString*)text inRect:(CGRect)rect withFont:(UIFont *)font
{
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
    CGContextSetRGBFillColor(ctx, 255, 255, 255, 1);
    [text drawInRect:rect withFont:font];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)getImageFromText:(NSString *)text inRect:(CGRect)rect withFont:(UIFont *)font withColor:(UIColor *)color{
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
    
    CGColorRef colorRef = [color CGColor];
    int numComponents = CGColorGetNumberOfComponents(colorRef);
    if (numComponents >= 3){
        const CGFloat *rgbComponents = CGColorGetComponents(colorRef);
        CGContextSetRGBFillColor(ctx, rgbComponents[0], rgbComponents[1], rgbComponents[2], rgbComponents[3]);
    }
    
    [text drawInRect:rect withFont:font];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
