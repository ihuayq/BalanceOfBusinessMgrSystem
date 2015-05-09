//
//  UncaughtExceptionHandler.m
//  ipaycard
//
//  Created by RenLongfei on 13-10-12.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "UncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

//http://www.cocoachina.com/newbie/tutorial/2012/0829/4672.html
NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;
@implementation UncaughtExceptionHandler

+ (NSArray *)backtraceFun
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtraceArray = [NSMutableArray arrayWithCapacity:frames];
    for (i = UncaughtExceptionHandlerSkipAddressCount;i < UncaughtExceptionHandlerSkipAddressCount + UncaughtExceptionHandlerReportAddressCount;i++)
    {
        [backtraceArray addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtraceArray;
}

- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex
{
    if (anIndex == 0)
    {
        dismissed = YES;
    }else if (anIndex==1) {
        NSLog(@"ssssssss");
    }
}

- (void)validateAndSaveCriticalApplicationData
{
    NSLog(@"abc validate");
}
- (void)uploadErrorStr:(NSString *)errorStr {
    NSLog(@"errorStr =%@",errorStr);
    [ErrorLogUpload uploadErrorLogWithLog:errorStr andDelegate:self];
}

- (void)handleException:(NSException *)exception
{
    [self validateAndSaveCriticalApplicationData];
    //NSString *name = [exception name];
    NSString *reason = [exception reason];
    NSArray *arr = [exception callStackSymbols];
    
    NSString *errorStr = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@\nInfo=%@",UncaughtExceptionHandlerSignalExceptionName,reason,[arr componentsJoinedByString:@"\n"],[[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]];
    NSLog(@"errorStr=%@",errorStr);
    [self performSelectorInBackground:@selector(uploadErrorStr:) withObject:errorStr];

    [ErrorLogUpload uploadErrorLogWithLog:errorStr andDelegate:self];
    
    UIAlertView *alert =
    [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"抱歉，程序出现了异常", nil)
        message:[NSString stringWithFormat:NSLocalizedString(@"如果点击继续，程序有可能会出现其他的问题，建议您还是点击退出按钮并重新打开\n\n" @"异常原因如下:\n%@\n%@", nil),[exception reason],[[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]] delegate:self      cancelButtonTitle:NSLocalizedString(@"退出", nil)
        otherButtonTitles:NSLocalizedString(@"继续", nil), nil];
    [alert show];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!dismissed)
    {
        for (NSString *mode in (__bridge NSArray *)allModes)
        {
            CFRunLoopRunInMode((__bridge CFStringRef)mode, 0.001, false);
        }
    }
    
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    }
    else
    {
        [exception raise];
    }
}

@end

NSString* getAppInfo()
{
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\n",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion];
    NSLog(@"Crash!!!! %@", appInfo);
    return appInfo;
}


void SignalHandler(int signal)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    
    NSMutableDictionary *userInfo =
    [NSMutableDictionary  dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:UncaughtExceptionHandlerSignalKey];
    
    NSArray *callStack = [UncaughtExceptionHandler backtraceFun];
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    
    [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)withObject:
     [NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
      reason:[NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.\n"@"%@", nil),
       signal,getAppInfo()]
      userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:signal]forKey:UncaughtExceptionHandlerSignalKey]]
     waitUntilDone:YES];
}

void InstallUncaughtExceptionHandler(void)
{
    //NSSetUncaughtExceptionHandler(&HandleException);

    signal(SIGABRT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGFPE, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
    signal(SIGTRAP, SignalHandler);
    signal(SIGTERM, SignalHandler);
    signal(SIGKILL, SignalHandler);


}

#pragma mark - 崩溃处理
void HandleException(NSException *exception)
{
    
    //    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    //    if (exceptionCount > UncaughtExceptionMaximum)
    //    {
    //        return;
    //    }
    //    NSArray *callStack = [UncaughtExceptionHandler backtraceFun];
    //    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    //    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    //[NSException exceptionWithName:[exception name] reason:[exception reason]userInfo:userInfo]
    [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)withObject:exception waitUntilDone:YES];
}

static int s_fatal_signals[] = {
    SIGABRT,
    SIGBUS,
    SIGFPE,
    SIGILL,
    SIGSEGV,
    SIGTRAP,
    SIGTERM,
    SIGKILL,
};
/*
static const char* s_fatal_signal_names[] = {
    "SIGABRT",
    "SIGBUS",
    "SIGFPE",
    "SIGILL",
    "SIGSEGV",
    "SIGTRAP",
    "SIGTERM",
    "SIGKILL",
};
 */

static int s_fatal_signal_num = sizeof(s_fatal_signals) / sizeof(s_fatal_signals[0]);

void InitCrashReport()
{
    // 1     linux错误信号捕获
    NSLog(@"s_fatal_signal_num = %d",s_fatal_signal_num);
    for (int i = 0; i < s_fatal_signal_num; ++i) {
        signal(s_fatal_signals[i], SignalHandler);
    }
    
    // 2      objective-c未捕获异常的捕获
    //InstallUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler(&HandleException);

}
#define BUG_REPORT_ENABLE 1

static void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    
#if BUG_REPORT_ENABLE
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://china_uv@999.com?subject=Bug report&body=Thank you for your Email!<br><br><br>"
                        "Error information:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        name,reason,[arr componentsJoinedByString:@"<br>"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
#endif
}
 
