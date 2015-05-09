//
//  NSData+Addition.m
//  MRCollectList
//
//  Created by 孙朋贞 on 13-9-4.
//  Copyright (c) 2013年 sunjing. All rights reserved.
//

#import "NSData+Addition.h"
#import <Security/Security.h>
#import "ControllerConfig.h"

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"
#import "MR_CommonDefines.h"



@implementation NSData (Addition)
//    加密步骤
//    1.把key base64.decode
//    2.把需要加密的内容 getBytes
//    3.把加密后的内容 base64.encode 后转 string

- (NSString *)encrypyConnectDes:(NSString *)connect
{
    
    NSData *plain = [connect dataUsingEncoding:NSUTF8StringEncoding];
    //NSData *data = [plain EncodeAES128WithKey:ENCRYPT_KEY];
   // NSData *data = [plain Encode3DESWithKey:[[NSUserDefaults standardUserDefaults] objectForKey:DAILI_KEY]];
    NSData *data = [plain Encode3DESWithKey:ORIGINAL_KEY];
    NSString *result = [data tobase64];
   // NSLog(@"3des加密后+++%@+++,%@",result,[[NSUserDefaults standardUserDefaults] objectForKey:DAILI_KEY]);
    return result;
}

- (NSString *)RegisterEncrypyConnectDes:(NSString *)connect{
    //注册是用的加密，密钥不同
    NSData *plain = [connect dataUsingEncoding:NSUTF8StringEncoding];
    //    NSData *data = [plain EncodeAES128WithKey:ENCRYPT_KEY];
    NSData *data = [plain Encode3DESWithKey:ORIGINAL_KEY];
    NSString *result = [data tobase64];
    NSLog(@"3des加密后+++%@+++",result);
    return result;
}

//    解密步骤与上述相反
//    1. 把加密的内容 base64.decode
//    2. 把key base64.decode
//    3. 把解密后的 转 string
- (NSString *)decipherConnectDes:(NSString *)connect{
    NSData *miPlain = [connect dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decodeData = [miPlain decodeBase64];
    NSData *miData = [decodeData Decode3DESWithKey:[[NSUserDefaults standardUserDefaults] objectForKey:DAILI_KEY]];
    NSString *result = [[[NSString alloc] initWithData:miData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"3des解密后++++%@++++",result);
    return result;
}

- (NSString *)RegisterDecipherConnectDes:(NSString *)connect{
    //注册是用的解密，密钥不同
    NSData *miPlain = [connect dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decodeData = [miPlain decodeBase64];
    NSData *miData = [decodeData Decode3DESWithKey:ORIGINAL_KEY];
    NSString *result = [[[NSString alloc] initWithData:miData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"Register  3des解密后++++%@++++",result);
    return result;
}

//- (NSData*)md5
//{
//    const char* str = self.bytes;
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(str, strlen(str), result);
//
//    NSData *data = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
//
//    return data;
//
//}


- (NSString *)tobase64
{
    if ([self length] > 0) {
        return [GTMBase64 stringByEncodingData:self];
    }
    
    return nil;
}


- (NSData *)decodeBase64
{
    if ([self length] > 0) {
        return [GTMBase64 decodeData:self];
    }
    
    return nil;
}



- (NSData *)Encode3DESWithKey:(NSString *)key {
    
	char keyPtr[kCCKeySize3DES+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [self length];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSize3DES;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
    
    
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr, kCCKeySize3DES,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		
        return [NSData dataWithBytes:(const void *)buffer length:(NSUInteger)numBytesDecrypted];
        
	}
	
	free(buffer); //free the buffer;
	return nil;
}




- (NSData *)Decode3DESWithKey:(NSString *)key {
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySize3DES+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [self length];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSize3DES;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
    
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr, kCCKeySize3DES,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	}
	
	free(buffer); //free the buffer;
	return nil;
}



@end
