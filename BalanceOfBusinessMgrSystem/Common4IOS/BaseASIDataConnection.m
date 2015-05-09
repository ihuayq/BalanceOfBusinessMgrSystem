//
//  BaseASIDataConnection.m
//  jxtuan
//
//  Created by 融通互动 on 13-9-25.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "BaseASIDataConnection.h"

@implementation BaseASIDataConnection

+(NSString* )getAllURLByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary
{
    NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
    for (NSString * key in dictionary)
    {
        [array addObject:[[key stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:key]]]];
    }
    
    NSString* allURLString=[[url stringByAppendingString:@"&"] stringByAppendingString:[array componentsJoinedByString:@"&"]];
    return allURLString;

}
//传dictionary的网络请求
+(ASIFormDataRequest*)PostDictionaryConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock
{
    if ([[dictionary allKeys] count])
    {
        NSLog(@"AllURL = %@",[self getAllURLByURL:url ConnDictionary:dictionary]);
    }
    else
    NSLog(@"AllURL = %@",url);
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    if (dictionary==nil) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    for (NSString *key in [dictionary allKeys]) {
        NSString * value= [dictionary objectForKey:key];
        [request addPostValue:value forKey:key];
    }
    __block ASIFormDataRequest * _request = request;
    [request setTimeOutSeconds:40];
    [request setCompletionBlock:^{
        
        HP_JSONUtils *jsonUtils = [[HP_JSONUtils alloc] init];
       // NSLog(@"-----%@",_request.responseString);
        NSDictionary *jsonDictionary = [jsonUtils getDictionaryFromJSONString:_request.responseString encoding:NSUTF8StringEncoding];
        jsonDictionary=[NNString delStringNullOfDictionary:jsonDictionary];
        if ([jsonDictionary isKindOfClass:[NSNull class]])
        {
            failedBlock(_request,_request.error,[self getErrorStringWithErrorCode:_request.error.code]);
            return ;
        }
        
        NSString *ret = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"ret"]];
        NSString *msg = [NNString delStringNull:[jsonDictionary objectForKey:@"msg"]];
        if (msg.length==0)
        {
            msg=@"网络错误,请重试";
        }
        NSMutableDictionary *responseJSONDictionary = [NSMutableDictionary dictionaryWithDictionary:jsonDictionary];
        successBlock(_request,ret,msg,responseJSONDictionary);
    }];
    [request setFailedBlock:^{
//      NSLog(@"%@",_request.error.debugDescription);
        failedBlock(_request,_request.error,[self getErrorStringWithErrorCode:_request.error.code]);
    }];
    [request startAsynchronous];
    return request;
}

//传单张图片的网络请求
+(void)PostDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary ConnData:(NSData *)data DataForKey:(NSString *)dataKey RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock
{
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    if (dictionary==nil) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [request addData:data withFileName:@"image.jpg" andContentType:@"image/jpeg" forKey:dataKey];
    for (NSString *key in [dictionary allKeys]) {
        NSString * value= [dictionary objectForKey:key];
        [request addPostValue:value forKey:key];
    }
    __block ASIFormDataRequest * _request = request;
    [request setTimeOutSeconds:60];
    [request setCompletionBlock:^{
        HP_JSONUtils *jsonUtils = [[HP_JSONUtils alloc] init];
        NSDictionary *jsonDictionary = [jsonUtils getDictionaryFromJSONString:_request.responseString encoding:NSUTF8StringEncoding];
        NSString *ret = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"ret"]];
        NSString *msg = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"msg"]];
        NSMutableDictionary *responseJSONDictionary = [NSMutableDictionary dictionaryWithDictionary:jsonDictionary];
        successBlock(_request,ret,msg,responseJSONDictionary);
    }];
    [request setFailedBlock:^{
//        NSLog(@"%@",_request.error.debugDescription);
        failedBlock(_request,_request.error,[self getErrorStringWithErrorCode:_request.error.code]);
    }];
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        bytesSentBlock(size,total);
    }];
    [request startAsynchronous];
}

//传3张图片的网络请求
+(void)PostDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary ConnImageData1:(NSData *)imageData1 forKey1:(NSString *)key1 ConnImageData2:(NSData *)imageData2 forKey2:(NSString *)key2 ConnImageData3:(NSData *)imageData3 forKey3:(NSString *)key3 RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock
{
    
    if ([[dictionary allKeys] count])
    {
        NSLog(@"AllURL = %@",[self getAllURLByURL:url ConnDictionary:dictionary]);
    }
    else
        NSLog(@"AllURL = %@",url);
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    if (dictionary==nil) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    if (!imageData1) {
        [request addPostValue:@"" forKey:key1];
    }else{
        [request addData:imageData1 withFileName:@"image.jpg" andContentType:@"image/jpeg" forKey:key1];
    }
    if (!imageData2) {
        [request addPostValue:@"" forKey:key2];
    }else{
        [request addData:imageData2 withFileName:@"image.jpg" andContentType:@"image/jpeg" forKey:key2];
    }
    if (!imageData3) {
        [request addPostValue:@"" forKey:key3];
    }else{
        [request addData:imageData3 withFileName:@"image.jpg" andContentType:@"image/jpeg" forKey:key3];
    }
    [request setTimeOutSeconds:90];
    for (NSString *key in [dictionary allKeys]) {
        NSString * value= [dictionary objectForKey:key];
        [request addPostValue:value forKey:key];
    }
    __block ASIFormDataRequest * _request = request;
    [request setCompletionBlock:^{
        HP_JSONUtils *jsonUtils = [[HP_JSONUtils alloc] init];
        NSDictionary *jsonDictionary = [jsonUtils getDictionaryFromJSONString:_request.responseString encoding:NSUTF8StringEncoding];
        NSString *ret = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"ret"]];
        NSString *msg = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"msg"]];
        NSMutableDictionary *responseJSONDictionary = [NSMutableDictionary dictionaryWithDictionary:jsonDictionary];
        successBlock(_request,ret,msg,responseJSONDictionary);
    }];
    [request setFailedBlock:^{
//        NSLog(@"%@",_request.error.debugDescription);
        failedBlock(_request,_request.error,[self getErrorStringWithErrorCode:_request.error.code]);
    }];
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        bytesSentBlock(size,total);
    }];
    [request startAsynchronous];
}

//传多张图片的网络请求
+(void)PostDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary ConnImageDataDictionary:(NSMutableDictionary *)ImageDatadictionary RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock
{
    
    if ([[dictionary allKeys] count])
    {
        NSLog(@"AllURL = %@",[self getAllURLByURL:url ConnDictionary:dictionary]);
    }
    else
        NSLog(@"AllURL = %@",url);
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    if (dictionary==nil)
    {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    
    for (NSString* key in ImageDatadictionary)
    {
        [request addData:[ImageDatadictionary objectForKey:key] withFileName:@"image.jpg" andContentType:@"image/jpeg" forKey:key];
    }
    
    [request setTimeOutSeconds:90];
    for (NSString *key in [dictionary allKeys]) {
        NSString * value= [dictionary objectForKey:key];
        [request addPostValue:value forKey:key];
    }
    __block ASIFormDataRequest * _request = request;
    [request setCompletionBlock:^{
        HP_JSONUtils *jsonUtils = [[HP_JSONUtils alloc] init];
        NSDictionary *jsonDictionary = [jsonUtils getDictionaryFromJSONString:_request.responseString encoding:NSUTF8StringEncoding];
        NSString *ret = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"ret"]];
        NSString *msg = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"msg"]];
        NSMutableDictionary *responseJSONDictionary = [NSMutableDictionary dictionaryWithDictionary:jsonDictionary];
        successBlock(_request,ret,msg,responseJSONDictionary);
    }];
    [request setFailedBlock:^{
        //        NSLog(@"%@",_request.error.debugDescription);
        failedBlock(_request,_request.error,[self getErrorStringWithErrorCode:_request.error.code]);
    }];
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        bytesSentBlock(size,total);
    }];
    [request startAsynchronous];
}


//传3张图片的网络请求(get--data  post--image)
+(void)GetDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary PostConnImageData1:(NSData *)imageData1 forKey1:(NSString *)key1 ConnImageData2:(NSData *)imageData2 forKey2:(NSString *)key2 ConnImageData3:(NSData *)imageData3 forKey3:(NSString *)key3 RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock
{
   
    if ([[dictionary allKeys] count])
    {
        NSLog(@"AllURL = %@",[self getAllURLByURL:url ConnDictionary:dictionary]);
        url=[self getAllURLByURL:url ConnDictionary:dictionary];
    }
    else
    {
        NSLog(@"AllURL = %@",url);
    }
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    
    if (!imageData1) {
        [request addPostValue:@"" forKey:key1];
    }else{
        [request addData:imageData1 withFileName:[NSString stringWithFormat:@"%@.jpg",key1] andContentType:@"image/jpeg" forKey:key1];
    }
    if (!imageData2) {
        [request addPostValue:@"" forKey:key2];
    }else{
        [request addData:imageData2 withFileName:[NSString stringWithFormat:@"%@.jpg",key2] andContentType:@"image/jpeg" forKey:key2];
    }
    if (!imageData3) {
        [request addPostValue:@"" forKey:key3];
    }else{
        [request addData:imageData3 withFileName:[NSString stringWithFormat:@"%@.jpg",key3] andContentType:@"image/jpeg" forKey:key3];
    }
    [request setTimeOutSeconds:90];
    
    __block ASIFormDataRequest * _request = request;
    [request setCompletionBlock:^{
        HP_JSONUtils *jsonUtils = [[HP_JSONUtils alloc] init];
        NSDictionary *jsonDictionary = [jsonUtils getDictionaryFromJSONString:_request.responseString encoding:NSUTF8StringEncoding];
        NSString *ret = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"ret"]];
        NSString *msg = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"msg"]];
        NSMutableDictionary *responseJSONDictionary = [NSMutableDictionary dictionaryWithDictionary:jsonDictionary];
        successBlock(_request,ret,msg,responseJSONDictionary);
    }];
    [request setFailedBlock:^{
        //        NSLog(@"%@",_request.error.debugDescription);
        failedBlock(_request,_request.error,[self getErrorStringWithErrorCode:_request.error.code]);
    }];
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        bytesSentBlock(size,total);
    }];
    [request startAsynchronous];
}

//传多张图片的网络请求(get--data  post--image)
+(void)GetDataConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary PostConnImageDataDictionary:(NSMutableDictionary *)ImageDatadictionary RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock RequestBytesSentBlock:(RequestBytesSentBlock)bytesSentBlock
{
    
    if ([[dictionary allKeys] count])
    {
        NSLog(@"AllURL = %@",[self getAllURLByURL:url ConnDictionary:dictionary]);
        url=[self getAllURLByURL:url ConnDictionary:dictionary];
    }
    else
        NSLog(@"AllURL = %@",url);
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    
    
    for (NSString* key in ImageDatadictionary)
    {
        [request addData:[ImageDatadictionary objectForKey:key] withFileName:[NSString stringWithFormat:@"%@.jpg",key] andContentType:@"image/jpeg" forKey:key];
    }
    
    [request setTimeOutSeconds:90];
    
    
    __block ASIFormDataRequest * _request = request;
    [request setCompletionBlock:^{
        HP_JSONUtils *jsonUtils = [[HP_JSONUtils alloc] init];
        NSDictionary *jsonDictionary = [jsonUtils getDictionaryFromJSONString:_request.responseString encoding:NSUTF8StringEncoding];
        NSString *ret = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"ret"]];
        NSString *msg = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"msg"]];
        NSMutableDictionary *responseJSONDictionary = [NSMutableDictionary dictionaryWithDictionary:jsonDictionary];
        successBlock(_request,ret,msg,responseJSONDictionary);
    }];
    [request setFailedBlock:^{
        //        NSLog(@"%@",_request.error.debugDescription);
        failedBlock(_request,_request.error,[self getErrorStringWithErrorCode:_request.error.code]);
    }];
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        bytesSentBlock(size,total);
    }];
    [request startAsynchronous];
}
//连接到MR服务器后台的网络请求
+(void)PostMRServerDictionaryConnectionByURL:(NSString *)url ConnDictionary:(NSMutableDictionary *)dictionary RequestSuccessBlock:(RequestSuccessBlock)successBlock RequestFailureBlock:(RequestFailureBlock)failedBlock
{
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    if (dictionary==nil) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    for (NSString *key in [dictionary allKeys]) {
        NSString * value= [dictionary objectForKey:key];
        [request addPostValue:value forKey:key];
    }
    __block ASIFormDataRequest * _request = request;
    [request setTimeOutSeconds:50];
    [request setCompletionBlock:^{
        HP_JSONUtils *jsonUtils = [[HP_JSONUtils alloc] init];
//        NSDictionary *jsonDictionary = [jsonUtils getDictionaryFromJSONString:_request.responseString encoding:NSUTF8StringEncoding];
        NSDictionary * jsonDictionary = [jsonUtils getDictionaryFromJSONData:_request.responseData];
        NSString *ret = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"rsp_code"]];
        NSString *msg = [NSString stringWithFormat:@"%@",[jsonDictionary objectForKey:@"rsp_msg"]];
        NSMutableDictionary *responseJSONDictionary = [NSMutableDictionary dictionaryWithDictionary:jsonDictionary];
        successBlock(_request,ret,msg,responseJSONDictionary);
    }];
    [request setFailedBlock:^{
//        NSLog(@"%@",_request.error.debugDescription);
        failedBlock(_request,_request.error,[self getErrorStringWithErrorCode:_request.error.code]);
    }];
    [request startAsynchronous];
}

+(NSString *)getErrorStringWithErrorCode:(int)code
{
    NSString * message;
    switch (code) {
        case ASIConnectionFailureErrorType:
            message = @"网络连接失败";
            break;
        case ASIRequestTimedOutErrorType:
            message = @"网络连接超时";
            break;
        case ASIAuthenticationErrorType:
            message = @"网络验证失败";
            break;
        case ASIRequestCancelledErrorType:
            message = @"取消网络请求失败";
            break;
        case ASIUnableToCreateRequestErrorType:
            message = @"不能创建网络连接";
            break;
        default:
            message = @"网络太不给力了";
            break;
    }
    return message;
}

@end
