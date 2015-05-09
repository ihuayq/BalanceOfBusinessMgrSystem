//
//  NSString+Utf8Encoding.m
//  ipaycard
//
//  Created by Davidsph on 4/6/13.
//  Copyright (c) 2013 han bing. All rights reserved.
//

#import "NSString+Utf8Encoding.h"

@implementation NSString (Utf8Encoding)

- (NSString *)URLEncodedString{
    
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    //    [result autorelease];
    return result;
}

- (NSString*)URLDecodedString{
    
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    //    [result autorelease];
    return result;
}



@end
