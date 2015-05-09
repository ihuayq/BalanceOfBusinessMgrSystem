//
//  ErrorLogUpload.h
//  ipaycard
//
//  Created by RenLongfei on 13-12-31.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJYBaseNetworkHelp.h"

@interface ErrorLogUpload : DJYBaseNetworkHelp

+ (void) uploadErrorLogWithLog:(NSString *)logErrorStr andDelegate:(id<ServiceDelegate>) delegate;
@end
