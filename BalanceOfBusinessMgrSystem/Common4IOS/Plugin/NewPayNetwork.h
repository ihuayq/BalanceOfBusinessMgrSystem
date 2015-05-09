//
//  NewPayNetwork.h
//  ipaycard
//
//  Created by fei on 13-4-24.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ServiceDelegate.h"

#import "ASIFormDataRequest.h"
#import "JSONKit.h"

#import "DJYUilityHelper.h"

#import "NewPayNetworkData.h"

@interface NewPayNetwork : NSObject


+ (void) payWithData:(NewPayNetworkData *)payData withDelegate:(id<ServiceDelegate>)delegate;

+(void)createPostURL:(NSMutableDictionary *)params request:(ASIFormDataRequest *) request;

+ (void) newPayWithData:(NewPayNetworkData *)payData withDelegate:(id<ServiceDelegate>)delegate;

@end
