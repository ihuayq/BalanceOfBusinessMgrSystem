//
//  NdUncaughtExceptionHandler.h
//  
//
//  Created by sunjing on 13-10-12.
//
//
#import <Foundation/Foundation.h>

#import "ErrorLogUpload.h"

@interface NdUncaughtExceptionHandler : NSObject<UIAlertViewDelegate, ServiceDelegate>{
    BOOL dismissed;
}

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler*)getHandler;

@end
