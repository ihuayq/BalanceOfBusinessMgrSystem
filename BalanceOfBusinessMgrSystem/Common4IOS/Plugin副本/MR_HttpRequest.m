//
//  MR_HttpRequest.m
//  TestRequest
//
//  Created by 孙朋贞 on 13-8-27.
//  Copyright (c) 2013年 www.icardpay.com. All rights reserved.
//

#import "MR_HttpRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+Utf8Encoding.h"

#define kSDKSecretValue @"9964DYByKL967c3308imytCB"//1001002  加密密钥


@implementation MR_HttpRequest
@synthesize request = _request;
@synthesize baseUrl = _baseUrl;
@synthesize delegate = _delegate;
@synthesize action = _action;
@synthesize statusCode = _statusCode;
@synthesize hasError = _hasError;
@synthesize errorMessage = _errorMessage;
@synthesize errorDetail = _errorDetail;
@synthesize HUD = _HUD;
@synthesize tag;

- (void)dealloc
{
    [_request release],_request = nil;
    [_request clearDelegatesAndCancel];
    [_baseUrl release],_baseUrl = nil;
    [_errorMessage release],_errorMessage = nil;
    [_errorDetail release],_errorDetail = nil;
    [self removeHUdFromView];
    [super dealloc];
}

#pragma mark -
#pragma mark 提示框

/**设置统一的转圈圈,只在需要的时候为其开辟空间**/
- (void)showHud:(NSString *)msg inView:(UIView *)view
{
    _HUD = [[MRLoadingView alloc] initWithFrame:view.frame];
    [_HUD showInView:view withMessage:msg];
    
}

- (void)removeHUdFromView
{
    if(_HUD)
    {
        [_HUD removeSelfFromSuperView:nil];
        self.HUD = nil;
    }
}

#pragma mark -
#pragma mark MR_HttpRquest methods

+ (NSString *)getRightString_BysortArray_dic:(NSDictionary *)dic
{
    NSMutableString *rightString =[NSMutableString stringWithString:@""];
    
    NSArray *_sortedArray= [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
    for (NSString *key in _sortedArray) {
        
        [rightString appendFormat:@"%@",[dic objectForKey:key]];
        
    }
    return [rightString stringByAppendingFormat:@"%@",kJXT_consume_sercert_key];
    
}
//MD5加密
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result);
    //%02X X 表示以十六进制形式输出  02 表示不足两位，前面补0输出；出过两位，不影响
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}

- (id)initWithAction:(SEL)action
         withBaseUrl:(NSString *)baseUrl
        withDelegate:(id<MR_HttpRequestDelegate>)delegate
{
    if (self = [super init]) {
        self.action = action;
        self.baseUrl = baseUrl;
        self.delegate = delegate;
        self.statusCode = 0;
    }
    return self;
}

- (void)requestPost:(NSString *)relativeUrl
        withBaseUrl:(NSString *)baseUrl
         withValues:(NSMutableDictionary *)params
{
    NSString * url = relativeUrl ?[NSString stringWithFormat:@"%@%@",baseUrl,relativeUrl]:baseUrl;
    NSLog(@"url = %@",url);
    NSString *signTemp = [MR_HttpRequest getRightString_BysortArray_dic:params];
    NSLog(@"签名加密前===%@",signTemp);
    NSString *signature = [MR_HttpRequest md5:signTemp];
    NSLog(@"签名加密后===%@",signature);
    [params setObject:signature forKey:@"sign"];//签名
    NSLog(@"params==%@  url=%@",params, [MR_URLHelper getURL:url queryParameters:params]);
    [self cancelRequest];
    _request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
    //[NSURL URLWithString:BASE_Domain_Name] [MR_URLHelper getURL:url queryParameters:params]
    //[_request addRequestHeader:@"content-type" value:@"application/mrpos-form-rulencoded"];
    _request.requestMethod = @"POST";
    _request.delegate = self;
    _request.timeOutSeconds = 60.0f;
    [_request setShouldAttemptPersistentConnection:NO];
    for (NSString *key in [params allKeys]) {
        [(ASIFormDataRequest * )_request setPostValue:[params objectForKey:key] forKey:key];
    }
    [_request setDidFailSelector:@selector(requestFailed:)];
    [_request setDidFinishSelector:@selector(requestFinished:)];
    [_request setDidStartSelector:@selector(requestStarted:)];
    [_request startAsynchronous];
}

- (void)requestPost:(NSString *)relativeUrl
         withValues:(NSMutableDictionary *)params
{
    return [self requestPost:relativeUrl withBaseUrl:self.baseUrl withValues:params];
}

- (void)cancelRequest{
    if (_request) {
        if ([_request isExecuting]) {
            [_request clearDelegatesAndCancel];
            id object = (id) self.delegate;
            if ([object respondsToSelector:@selector(requestCanceled:)] && self.delegate ) {
                [self.delegate requestCanceled:self];
            }
        }
        [_request clearDelegatesAndCancel];
        [_request release];
        _request = nil;
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate method

- (void)requestStarted:(ASIHTTPRequest *)request
{
    id object = (id) self.delegate;
    if ([object respondsToSelector:@selector(requestStarted:)] && self.delegate && request == self.request) {
        [self.delegate requestStarted:self];
    }
}
- (void)requestMyFailed:(NSString *)errorCode
{
    NSLog(@"errCode = %@",errorCode);
    id object = (id) self.delegate;
    if (self.delegate && [object respondsToSelector:@selector(requestFailed:withError:)]) {
        [self.delegate requestFailed:self withError:errorCode];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
    
	_statusCode = [request responseStatusCode];
	_hasError = true;
    
    if (error.code ==  NSURLErrorUserCancelledAuthentication) {
        _statusCode = 401;
    }else if(error.code == NSURLErrorTimedOut){
        NSLog(@"errCode = 网络请求超时");
    }else {
        self.errorMessage = @"网络出现异常，请检查网络设备或重试";
        [Util showMsg:@"网络出现异常，请检查网络设备或重试"];
        self.errorDetail  = [error localizedDescription];
        NSLog(@"%@",self.errorMessage);
        
        id object = (id) self.delegate;
        if ([object respondsToSelector:@selector(requestFailed:withError:)] && self.delegate && request == self.request) {
            [self.delegate requestFailed:self withError:self.errorMessage];
        }
    }
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{    
    NSData *responseData = [request responseData];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    NSString *code = [dic valueForKey:@"rsp_code"];
    NSLog(@"code = %@",code);
    NSLog(@"rsp_msg = %@  %@",[dic objectForKey:@"rsp_msg"],[dic objectForKey:@"state"]);
    if (_delegate) {
        id object = (id)_delegate;
        if (object) {
            [object performSelector:_action withObject:self withObject:dic];
        }
    }
	
}

@end



















