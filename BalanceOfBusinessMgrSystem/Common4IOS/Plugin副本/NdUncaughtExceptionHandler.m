//
//  NdUncaughtExceptionHandler.m
//  
//
//  Created by sunjing on 13-10-12.
//
//

#import "NdUncaughtExceptionHandler.h"

void UcaughtExceptionHandler(NSException *exception);

@implementation NdUncaughtExceptionHandler

- (NSString *)getInfo
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
-(NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler (&UcaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler

{
    return NSGetUncaughtExceptionHandler();
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

- (void)uploadErrorStr:(NSString *)errorStr {
    [ErrorLogUpload uploadErrorLogWithLog:errorStr andDelegate:self];
}

- (void)handleExc:(NSException *)exception
{
    NSString *name = [exception name];
    NSString *reason = [exception reason];
    NSArray *arr = [exception callStackSymbols];
    
    NSString *errorStr = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@\nInfo=%@",name,reason,[arr componentsJoinedByString:@"\n"],[self getInfo]];
    [self performSelectorInBackground:@selector(uploadErrorStr:) withObject:errorStr];
    NSLog(@"NderrorStr=%@",errorStr);

    UIAlertView *alert =
    [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"抱歉，程序出现了异常", nil)
                              message:[NSString stringWithFormat:NSLocalizedString(@"如果点击继续，程序有可能会出现其他的问题，建议您还是点击退出按钮并重新打开\n\n" @"异常原因如下:\n%@\n%@", nil),[exception reason],[exception name]]
                             delegate:self  cancelButtonTitle:NSLocalizedString(@"退出", nil)
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
    
    if ([exception name])
    {
        exit(0);
    }
    else
    {
        [exception raise];
    }
}
@end

NSString *applicationDocumentsDirectory() {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return path;
    
}

void UcaughtExceptionHandler(NSException *exception) {

    //NSThread *excThr = [[NSThread alloc]init];
    [[[NdUncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleExc:)withObject:exception waitUntilDone:YES];
    //[[[NdUncaughtExceptionHandler alloc] init] performSelector:@selector(handleExc:) onThread:excThr withObject:exception waitUntilDone:YES];
    //NSString *path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"CashLog.txt"];
    //[errorStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    //NSString *urlStr = [NSString stringWithFormat:@"mailto://kobecn@gmail.com?subject=bug报告&body=感谢您的配合!<br><br><br>" "错误详情：<br>%@<br>---------<br>%@<br>------<br>%@",name,reason,[arr componentsJoinedByString:@"<br>"]];
    //NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //[[UIApplication shareApplication] openURL:url];
    
    
}


