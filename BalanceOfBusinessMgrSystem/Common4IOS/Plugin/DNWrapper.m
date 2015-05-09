//
//  DNWrapper.m
//  test接口
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DNWrapper.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "ASIFormDataRequest.h"

#import "GTMBase64.h"

#define gkey @"9864DcyyKL967c3308iuytCB"  // 3664DcyyIC967c3308iuytCn

#define gIv  @"01234567"

@implementation DNWrapper

+ (NSString *) getRightString_BysortArray_dic:(NSDictionary *) dic{
    
    NSMutableString *rightString =[NSMutableString stringWithString:@""];
    
    NSArray *_sortedArray= [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSString *key in _sortedArray) {
        
        [rightString appendFormat:@"%@",[dic objectForKey:key]];
        
    }
    
    return [rightString stringByAppendingFormat:@"%@",gkey];
    
}

+(void)createPostURL:(NSMutableDictionary *)params request:(ASIFormDataRequest *) request{
    
    NSString *postString=@"";
    
    NSString *signTmp = [self getRightString_BysortArray_dic:params];
    
    CCLog(@"拼接后的参数为%@",signTmp);
    
    [params setObject:GET_SIGN(signTmp) forKey:KEY_sign];
    
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
        
        [request setPostValue:value forKey:key];
    }
}


+ (NSString *)getMD5String:(NSString *)url
{
	NSDate *date = [NSDate date];
	NSTimeInterval timeInterval = [date timeIntervalSince1970];
	NSString *paramT = [NSString stringWithFormat:@"%f", timeInterval];
	
	NSString *md5src = [NSString stringWithFormat:@"%fA42F7167-6DB0-4A54-84D4-789E591C31DA", timeInterval];
	NSString *md5Result = [DNWrapper md5:md5src];
    
	NSString *result = nil;
	if (NSNotFound == [url rangeOfString:@"?"].location) {
		result = [NSString stringWithFormat:@"?t=%@&e=%@&f=p&d=%@", paramT, md5Result,md5src];
	}else {
		result = [NSString stringWithFormat:@"&t=%@&e=%@&f=p&d=%@", paramT, md5Result,md5src];
	}
	
    url=[NSString stringWithFormat:@"%@%@",url,result];
    
    CCLog(@"url=%@",url);
	return url;
}

//大写MD5

+(NSString *)md5UpCassString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}

//小写MD5
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    
    CCLog(@"md5 =%@",[[NSString stringWithFormat:
                       @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                       result[0], result[1], result[2], result[3],
                       result[4], result[5], result[6], result[7],
                       result[8], result[9], result[10], result[11],
                       result[12], result[13], result[14], result[15]
                       ] lowercaseString]);
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}

#pragma mark -
#pragma mark sdes 加密

// 加密方法

+ (NSString*)encrypt:(NSString*)plainText {
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    int32_t ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr =(uint8_t *) malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    //const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
    
}

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText {
    
    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr =(uint8_t *) malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    return result;
}

@end
