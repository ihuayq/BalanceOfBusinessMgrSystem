//
//  NSData+Addition.h
//  MRCollectList
//
//  Created by 孙朋贞 on 13-9-4.
//  Copyright (c) 2013年 sunjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Addition)

//- (NSData *)md5;
- (NSString *)tobase64;
- (NSData *)decodeBase64;


- (NSData *)Encode3DESWithKey:(NSString *)key;
- (NSData *)Decode3DESWithKey:(NSString *)key;

- (NSString *)encrypyConnectDes:(NSString *)connect;

- (NSString *)decipherConnectDes:(NSString *)connect;

- (NSString *)RegisterEncrypyConnectDes:(NSString *)connect;

- (NSString *)RegisterDecipherConnectDes:(NSString *)connect;


@end
