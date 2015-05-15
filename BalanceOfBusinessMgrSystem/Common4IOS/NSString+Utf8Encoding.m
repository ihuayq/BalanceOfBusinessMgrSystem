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
    
    
//    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                                             (CFStringRef)self,
//                                                                                             NULL,
//                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
//                                                                                             kCFStringEncodingUTF8));
//    //    [result autorelease];
//    return result;
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString*)URLDecodedString{
    
    
//    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
//                                                                                                             (CFStringRef)self,
//                                                                                                             CFSTR(""),
//                                                                                                             kCFStringEncodingUTF8));
//    //    [result autorelease];
//    return result;
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    
}
//- (NSString*) urlEncodedString {
//    
//    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                          (__bridge CFStringRef) self,
//                                                                          nil,
//                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
//                                                                          kCFStringEncodingUTF8);
//    
//    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
//    
//    if(!encodedString)
//        encodedString = @"";
//    
//    return encodedString;
//}
//
//- (NSString*) urlDecodedString {
//    
//    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
//                                                                                          (__bridge CFStringRef) self,
//                                                                                          CFSTR(""),
//                                                                                          kCFStringEncodingUTF8);
//    
//    // We need to replace "+" with " " because the CF method above doesn't do it
//    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
//    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
//}



@end
