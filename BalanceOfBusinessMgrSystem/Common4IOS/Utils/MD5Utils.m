//
//  MD5Utils.m
//  jxtuan
//
//  Created by 融通互动 on 13-10-17.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "MD5Utils.h"
#import "CommonCrypto/CommonDigest.h"

@implementation MD5Utils

+ (NSString *)getRightString_BysortArray_dic:(NSDictionary *)dic
{
    NSMutableString *rightString =[NSMutableString stringWithString:@""];
    
    NSArray *_sortedArray= [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    NSLog(@"排序后:%@",_sortedArray);
    
    for (NSString *key in _sortedArray)
    {
        
        [rightString appendFormat:@"%@",[dic objectForKey:key]];
        
    }
    return rightString;
}



+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


@end
