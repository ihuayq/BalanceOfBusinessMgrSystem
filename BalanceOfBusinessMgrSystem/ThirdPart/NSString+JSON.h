//
//  NSString+JSON.h
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/6/12.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//  NSString+JSON.h
//  WSPhnixPurfier
//
//  Created by Joy on 13-9-4.
//  Copyright (c) 2013年 Joy. All rights reserved.

@interface NSString (JSON)

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithObject:(id) object;

@end