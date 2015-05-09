//
//  NSString+HexToData.m
//  Time
//
//  Created by RenLongfei on 13-10-17.
//  Copyright (c) 2013年 RenLongfei. All rights reserved.
//

#import "NSString+HexToData.h"

@implementation NSString (HexToData)

-(NSData *) HexToData {
    
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    NSLog(@"data= %@",data);
    
    return data;
}
@end
