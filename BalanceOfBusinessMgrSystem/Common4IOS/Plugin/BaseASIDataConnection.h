//
//  BaseASIDataConnection.h
//  jxtuan
//
//  Created by 融通互动 on 13-9-25.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ControllerConfig.h"
#import "HP_Common4IOS.h"

typedef void (^RequestSuccessBlock)(ASIFormDataRequest * request,NSString * ret,NSString * msg,NSMutableDictionary * responseJSONDictionary);

typedef void (^RequestFailureBlock)(ASIFormDataRequest * request, NSError * error ,NSString * msg);

typedef void (^RequestBytesSentBlock)(unsigned long long size, unsigned long long total);


@interface BaseASIDataConnection : NSObject


//传dictionary的网络请求
+(ASIFormDataRequest*)PostDictionaryConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock;


//传单张图片的网络请求
+(void)PostDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary ConnData:(NSData *)data DataForKey:(NSString *)dataKey RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock;

//传3张图片的网络请求
+(void)PostDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary ConnImageData1:(NSData *)imageData1 forKey1:(NSString *)key1 ConnImageData2:(NSData *)imageData2 forKey2:(NSString *)key2 ConnImageData3:(NSData *)imageData3 forKey3:(NSString *)key3 RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock;

//传多张图片的网络请求
+(void)PostDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary ConnImageDataDictionary:(NSMutableDictionary *)ImageDatadictionary RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock;



//传3张图片的网络请求(get--data  post--image)
+(void)GetDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary PostConnImageData1:(NSData *)imageData1 forKey1:(NSString *)key1 ConnImageData2:(NSData *)imageData2 forKey2:(NSString *)key2 ConnImageData3:(NSData *)imageData3 forKey3:(NSString *)key3 RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock;

//传多张图片的网络请求(get--data  post--image)
+(void)GetDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary PostConnImageDataDictionary:(NSMutableDictionary *)ImageDatadictionary RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock;

//连接到MR服务器后台的网络请求
+(void)PostMRServerDictionaryConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock;

+(NSString *)getErrorStringWithErrorCode:(int)code;

@end
