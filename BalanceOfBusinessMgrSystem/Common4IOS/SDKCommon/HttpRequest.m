//
//  HttpRequest.m
//  test91
//
//  Created by locojoy on 14-10-9.
//  Copyright (c) 2014年 locojoy. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

@synthesize handler = _handler;

-(id)initWithUrl:(NSString *)url andName:(NSString *)name
{
    self = [super init];
    
    _url = url;
    _name = name;
    _buf = [[NSMutableData alloc] initWithLength:0];
    
    return self;
}

-(void)dealloc
{
    [_buf release];
    [_url release];
    [_name release];
    self.handler = nil;
    [super dealloc];
}

-(void)startRequestWithCompletionHandler
{
    NSLog(@"Start request, name = %@, url = %@", _name, _url);
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connect = [NSURLConnection connectionWithRequest:request delegate:self];
    [connect start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    
    if (res) {
        int code = [res statusCode];
        NSLog(@"Receive response, code = %d, name = %@, url = %@", code, _name, _url);
        if (code != 200) {
            if (_handler) {
                _handler(NO, nil);
                _handler = nil;
            }
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_buf appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"Request success, name = %@, url = %@", _name, _url);
    if (_handler) {
        _handler(YES, _buf);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Request failed, name = %@, url = %@", _name, _url);
    if (_handler) {
        _handler(NO, nil);
    }
}

@end
