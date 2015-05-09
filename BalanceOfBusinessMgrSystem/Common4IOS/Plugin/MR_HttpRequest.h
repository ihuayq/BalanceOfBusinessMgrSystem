//
//  MR_HttpRequest.h
//  TestRequest
//
//  Created by 孙朋贞 on 13-8-27.
//  Copyright (c) 2013年 www.icardpay.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MR_URLHelper.h"
#import "MRLoadingView.h"

@protocol MR_HttpRequestDelegate;

@interface MR_HttpRequest : NSObject<ASIHTTPRequestDelegate>
{
    ASIHTTPRequest *_request;
    NSString *_baseUrl;
    id<MR_HttpRequestDelegate> _delegate;
    SEL _action;
    int _statusCode;
    
    BOOL _hasError;
    NSString * _errorMessage;
    NSString * _errorDetail;
    
    MRLoadingView * _HUD;  //统一的转圈圈
}

@property (nonatomic,assign) ASIHTTPRequest * request;
@property (nonatomic,retain) NSString * baseUrl;
@property (nonatomic,assign) id <MR_HttpRequestDelegate> delegate;
@property (nonatomic,assign) SEL action;
@property (nonatomic,assign) int statusCode;
@property (nonatomic,assign) BOOL hasError;
@property (nonatomic,retain) NSString * errorMessage;
@property (nonatomic,retain) NSString * errorDetail;
@property (nonatomic,retain) MRLoadingView * HUD;
@property (nonatomic,assign) NSUInteger tag;

/** 初始化 **/
- (id)initWithAction:(SEL)action
         withBaseUrl:(NSString *)baseUrl
        withDelegate:(id<MR_HttpRequestDelegate>)delegate;
/**Post 请求这是传过相应的baseURL**/
- (void)requestPost:(NSString *)relativeUrl
        withBaseUrl:(NSString *)baseUrl
         withValues:(NSMutableDictionary *)params;

/**Post 请求不传相应的baseURL 利用已知的baseURL**/
- (void)requestPost:(NSString *)relativeUrl
         withValues:(NSMutableDictionary *)params;

- (void)cancelRequest;

/**设置统一的转圈圈,只在需要的时候为其开辟空间**/
- (void)showHud:(NSString *)msg inView:(UIView *)view;

- (void)removeHUdFromView;

+ (NSString *)getRightString_BysortArray_dic:(NSDictionary *)dic;
+ (NSString *)md5:(NSString *)str;

@end


@protocol MR_HttpRequestDelegate

- (void)requestStarted:(MR_HttpRequest *)request;

- (void)requestFailed:(MR_HttpRequest *)request withError:(NSString *)error;

- (void)requestCanceled:(MR_HttpRequest *)request;

@end
