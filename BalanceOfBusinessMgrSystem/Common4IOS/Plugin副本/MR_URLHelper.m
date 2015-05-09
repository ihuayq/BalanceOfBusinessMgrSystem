//
//  MR_URLHelper.m
//  TestRequest
//
//  Created by 孙朋贞 on 13-8-27.
//  Copyright (c) 2013年 www.icardpay.com. All rights reserved.
//

#import "MR_URLHelper.h"

@implementation MR_URLHelper

+ (NSString *)_encodeString : (NSString *)string{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL  , (CFStringRef)string, NULL, (CFStringRef)@";/?:@&=$+{}<>,", kCFStringEncodingUTF8); //NULL kCFAllocatorDefault
    return [result autorelease];
}

+ (NSString *)_queryStringWithBase:(NSString *)base
                        parameters:(NSDictionary *)params
                          prefixed:(BOOL)prefixed{
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    if (base) {
        [str appendString:base];
    }
    // Append each name-value pair.
    if (params) {
        int i;
        NSArray *names = [params allKeys];
        for (i = 0; i < [names count]; i++) {
            if (i == 0 && prefixed) {
                [str appendString:@"?"];
            } else if (i > 0) {
                [str appendString:@"&"];
            }
            NSString *name = [names objectAtIndex:i];

            [str appendString:[NSString stringWithFormat:@"%@=%@",
							   name, [self _encodeString:[params objectForKey:name]]]];
//            [str appendString:[NSString stringWithFormat:@"%@=%@",name,[params objectForKey:name]]];
        }
    }
    return str;
}

+ (NSString *)getURL:(NSString *)baseUrl
	 queryParameters:(NSMutableDictionary*)params {
    NSString* fullPath = [[baseUrl copy] autorelease];
	if (params) {
        fullPath = [self _queryStringWithBase:fullPath parameters:params prefixed:YES];
    }
    NSLog(@"fullPath=%@",fullPath);
	return fullPath;
}


@end
