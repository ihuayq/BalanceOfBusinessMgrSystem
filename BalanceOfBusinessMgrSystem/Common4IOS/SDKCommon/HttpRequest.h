//
//  HttpRequest.h
//  test91
//
//  Created by locojoy on 14-10-9.
//  Copyright (c) 2014年 locojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpRequestCompletionHandler)(BOOL bSuccess, NSData *data);

@interface HttpRequest : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableData *_buf;
    NSString *_url;
    NSString *_name;
    HttpRequestCompletionHandler _handler;
}

@property (nonatomic, copy) HttpRequestCompletionHandler handler;

-(id)initWithUrl:(NSString *)url andName:(NSString *)name;
-(void)dealloc;
-(void)startRequestWithCompletionHandler;

@end
