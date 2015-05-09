//
//  UncaughtExceptionHandler.h
//  ipaycard
//
//  Created by RenLongfei on 13-10-12.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorLogUpload.h"

@interface UncaughtExceptionHandler : NSObject<ServiceDelegate>{
    BOOL dismissed;
}

void InitCrashReport();

void InstallUncaughtExceptionHandler(void);


void HandleException(NSException *exception);
void SignalHandler(int signal);
@end
