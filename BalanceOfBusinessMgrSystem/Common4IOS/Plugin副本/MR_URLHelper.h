//
//  MR_URLHelper.h
//  TestRequest
//
//  Created by 孙朋贞 on 13-8-27.
//  Copyright (c) 2013年 www.icardpay.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MR_URLHelper : NSObject

+ (NSString *)_encodeString : (NSString *)string;

+ (NSString *)_queryStringWithBase:(NSString *)base
                        parameters:(NSDictionary *)params
                          prefixed:(BOOL)prefixed;

+ (NSString *)getURL:(NSString *)baseUrl
     queryParameters:(NSMutableDictionary *)params;

@end
