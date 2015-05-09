//
//  DNWrapper.h
//  test接口
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface DNWrapper : NSObject

+ (NSString *)getMD5String:(NSString *)url;

+(NSString *)md5:(NSString *)str;

// 加密方法  3ds 加密 
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;


+ (NSString *) getRightString_BysortArray_dic:(NSDictionary *) dic;


+(void)createPostURL:(NSMutableDictionary *)params request:(ASIFormDataRequest *) request;

@end
