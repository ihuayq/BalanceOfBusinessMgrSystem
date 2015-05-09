//
//  HP_JSONUtils.h
//  common4ios
//
//  Created by Yi Xu on 12-11-13.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_JSONUtils : NSObject
{
    
}
//NSMutableDictionary 类型转换为 NSData类型
-(NSData *)getJSONDataFromDictionary:(NSMutableDictionary *) dictionary;

//NSString 类型转换为 NSData类型
-(NSData *)getJSONDataFromString:(NSString *) string encoding:(NSStringEncoding)encoding;

//NSMutableDictionary 类型转换为 NSString类型
-(NSString *)getJSONStringFromDictionary:(NSMutableDictionary *) dictionary encoding:(NSStringEncoding)encoding;

//NSData 类型转换为 NSDictionary类型
-(NSDictionary *) getDictionaryFromJSONData:(NSData *) JSONData;

//NSString 类型转换为 NSDictionary类型
-(NSDictionary *) getDictionaryFromJSONString:(NSString *) JSONString encoding:(NSStringEncoding)encoding;

//NSData 类型转换为 NSArray类型
-(NSArray *) getArrayFromJSONData:(NSData *) JSONData;

//NSString 类型转换为 NSArray类型
-(NSArray *) getArrayFromJSONString:(NSString *) JSONString encoding:(NSStringEncoding)encoding;

@end

