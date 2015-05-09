//
//  HP_JSONUtils.m
//  common4ios
//
//  Created by Yi Xu on 12-11-13.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import "HP_JSONUtils.h"

@implementation HP_JSONUtils

-(NSData *)getJSONDataFromDictionary:(NSMutableDictionary *) dictionary{
    NSError *error = nil;
    return [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
}

-(NSData *)getJSONDataFromString:(NSString *) string encoding:(NSStringEncoding)encoding{
    //NSUTF32BigEndianStringEncoding
    return [string dataUsingEncoding:encoding];
}

-(NSString *)getJSONStringFromDictionary:(NSMutableDictionary *) dictionary encoding:(NSStringEncoding)encoding{
    //NSUTF8StringEncoding
    NSData *JSONData = [self getJSONDataFromDictionary:dictionary];
    return[[NSString alloc] initWithData:JSONData encoding:encoding];
}

-(NSDictionary *) getDictionaryFromJSONData:(NSData *) JSONData{
    return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
}

-(NSDictionary *) getDictionaryFromJSONString:(NSString *) JSONString encoding:(NSStringEncoding)encoding{
    //NSUTF8StringEncoding
    NSData *JSONData = [self getJSONDataFromString:JSONString encoding:encoding];
    return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
}

-(NSArray *) getArrayFromJSONData:(NSData *) JSONData{
    return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
}

-(NSArray *) getArrayFromJSONString:(NSString *) JSONString encoding:(NSStringEncoding)encoding{
    //NSUTF8StringEncoding
    NSData *JSONData = [self getJSONDataFromString:JSONString encoding:encoding];
    return [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
}


@end
