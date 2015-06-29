//
//  AppDelegate.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/5.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "AppDelegate.h"
#import "BMCommercialTenantMainViewController.h"
#import "BMNaturalManMainViewController.h"
#import "SettingLoginPassWordViewController.h"
#import "settingNaturalManInfoViewController.h"
#import "BMWithDrawsCashSuccessViewController.h"
#import "GuidViewController.h"
#import "SRWebSocket.h"
#import "NSString+JSON.h"
#import "BMInvestmentConfirmViewController.h"
#import "BMHomePageViewController.h"

@interface AppDelegate ()<SRWebSocketDelegate>{
    NSTimer * loginCheckTimer;
    SRWebSocket *_webSocket;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:LOGIN_STATUS];
//#define TEST
#ifndef TEST
    NSString* keystring=[NSString stringWithFormat:@"%@_GuidePage_%ld",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],(long)GLOBE_GUIDE];
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:keystring] isEqualToString:keystring])
    {
        GuidViewController * guideVc=[[GuidViewController alloc]init];
        guideVc.type = GLOBE_GUIDE;
        self.window.rootViewController = guideVc;
    }
    else
    {
        [self initWindowRootViewController];
    }
    
//    NSString* keystring=[NSString stringWithFormat:@"%@_WelcomePage",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:keystring]isEqualToString:keystring])
//    {
//        [self initWelcomePage];
//    }
//    else
//    {
//        [self initWindowRootViewController];
//    }
#else
    BMInvestmentConfirmViewController* Vc=[[BMInvestmentConfirmViewController alloc]init];
    self.window.rootViewController = Vc;
#endif
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginInitMainwidow:) name:@"LoginInitMainwidow" object:nil];
    
    return YES;
}

//初始化一个定时器,用于检验是否有相同的账号登陆情况
-(void)initTimer
{
    //时间间隔
    NSTimeInterval timeInterval = 3.0 ;
    //定时器
    loginCheckTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                           target:self
                                                         selector:@selector(handleCheckTimer:)
                                                         userInfo:nil
                                                            repeats:YES];
}

-(void)cancelLoginCheckTimer
{
    //定时器
    [loginCheckTimer invalidate];
}

//触发事件
-(void)handleCheckTimer:(NSTimer *)theTimer
{
    NSString *strLoginName = @"";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_TYPE] isEqualToString:@"0"]) {
        strLoginName = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME];
    }
    else{
        strLoginName = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_SUPPLYER_NAME];
    }
   
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:strLoginName forKey:@"loginName"];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];

    NSString *url =[NSString stringWithFormat:@"%@%@",IP,LoginCheckUrl];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    NSLog(@"connDictionary:%@",connDictionary);
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         if([ret isEqualToString:@"100"])
         {
//           responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary]; 
         }
         else
         {
             [self cancelLoginCheckTimer];
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error,NSString *msg) {
         NSLog(@"error:%@",error.debugDescription);
         if (![request isCancelled])
         {
             [request cancel];
         }
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}

// 显示简单的alertView
-(void)showSimpleAlertViewWithTitle:(NSString *)title alertMessage:(NSString *)msg cancelButtonTitle:(NSString *) cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles,nil];
    [alertView show];
}

- (void)LoginInitMainwidow:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"login"]);
    NSLog(@"－－－－－接收到通知------");
    
    //是否商户1 还是自然人0 登录 logintype
    if( [text.userInfo[@"login"] isEqualToString:@"1"]){
        //判断商户引导页是否显示过
        NSString* keystring=[NSString stringWithFormat:@"%@_GuidePage_%ld",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],(long)SUPPLYER_GUIDE];
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:keystring] isEqualToString:keystring])
        {
            GuidViewController * guideVc=[[GuidViewController alloc]init];
            guideVc.type = SUPPLYER_GUIDE;
            self.window.rootViewController = guideVc;
            return;
        }
        
        BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
        self.window.rootViewController = mainview;
    }
    //自然人登录
    else if([text.userInfo[@"login"] isEqualToString:@"0"])
    {
        //[self initTimer];
        //判断自然人引导页是否显示过
        NSString* keystring=[NSString stringWithFormat:@"%@_GuidePage_%ld",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],(long)NATUREMAN_GUIDE];
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:keystring] isEqualToString:keystring])
        {
            GuidViewController * guideVc=[[GuidViewController alloc]init];
            guideVc.type = NATUREMAN_GUIDE;
            self.window.rootViewController = guideVc;
            return;
        }
        
        
        if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"naturalMark"] isEqualToString:@"0"]) {
            SettingLoginPassWordViewController * settingVc=[[SettingLoginPassWordViewController alloc]init];
            self.window.rootViewController = settingVc;
        }else{
            BMNaturalManMainViewController* Vc=[[BMNaturalManMainViewController alloc]init];
            self.window.rootViewController = Vc;
        }
    }
    //登陆界面
    else if([text.userInfo[@"login"] isEqualToString:@"2"])
    {
        //[self cancelLoginCheckTimer];
        LoginViewController *login = [[LoginViewController alloc] init];
        if (text.userInfo[@"isSupplyer"]) {
            login.isSupplerSelected = [text.userInfo[@"isSupplyer"] boolValue];
        }
        self.window.rootViewController = login;
    }
}

-(void)initWindowRootViewController
{
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginStatus"];//0未登录、1的登录
    NSString* versionString=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"keystring %@",versionString);
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:versionString] == NULL)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:versionString];
        loginStatus = @"0";
    }
    
    NSLog(@"loginStatus:%@",loginStatus);
    login = [[LoginViewController alloc] init];
    if ( [loginStatus intValue] == 0 )
    {
        nc =[[UINavigationController alloc]initWithRootViewController:login];
        [nc.navigationBar setHidden:YES];
        self.window.rootViewController = nc;
    }
//    else if([loginStatus intValue]==1)
//    {
//        n/Users/huayq/BalanceOfBusinessMgrSystem/BalanceOfBusinessMgrSystem/ThirdPart/MJRefreshc = [[UINavigationController alloc]initWithRootViewController:login];
//        [nc.navigationBar setHidden:YES];
//        self.window.rootViewController = nc;
//        
//        MainViewController * mainViewController = [[MainViewController alloc] init];
//        [nc pushViewController:mainViewController animated:NO];
//    }
}

//-(void)checkAPPUpdate
//{
//    if (![HP_NetWorkUtils isNetWorkEnable])
//    {
//        return;
//    }
//    
//    
//    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
//    
//    NSString* string3des=@"众信";
//    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
//    [connDictionary setObject:encodedValue forKey:@"mark"];
//    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
//    [connDictionary setObject:@"众信" forKey:@"mark"];
//    NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,getversionURL];
//    NSLog(@"connDictionary:%@",connDictionary);
//    
//    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
//     {
//         NSLog(@"检查更新ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
//         
//         if ([ret isEqualToString:@"100"])
//         {
//             NSString* newVersion=[responseJSONDictionary objectForKey:@"version"];
//             NSArray* newVersionArray=[[responseJSONDictionary objectForKey:@"version"] componentsSeparatedByString:@"."];
//             
//             NSArray *currentVersionArray = [NNString splitString: [HP_NSBundleUtils getMainBundleAPPVersion] withStr:@"."];
//             
//             NSLog(@"newVersionArray=%@ currentVersionArray=%@",newVersionArray,currentVersionArray);
//             
//             BOOL isHaveNewVervion = NO;
//             for (int i=0; i<[newVersionArray count]; i++)
//             {
//                 if ([[newVersionArray objectAtIndex:i] intValue]>[[currentVersionArray objectAtIndex:i] intValue])
//                 {
//                     NSLog(@"有新版");
//                     isHaveNewVervion = YES;
//                     break;
//                 }
//                 if ([[newVersionArray objectAtIndex:i] intValue]<[[currentVersionArray objectAtIndex:i] intValue])
//                 {
//                     NSLog(@"线上是旧版");
//                     break;
//                 }
//             }
//             if (isHaveNewVervion)
//             {
//                 NSLog(@"\n\n\n真的有新版本啦\n\n\n");
//                 
//                 NSString* keyAndVAlueString=[NSString stringWithFormat:@"%@_%@",CurVervionString,HaveNewVervion_ShowRedPoint];
//                 if (![[[NSUserDefaults standardUserDefaults] objectForKey:keyAndVAlueString]isEqualToString:keyAndVAlueString])
//                 {
//                     [[NSUserDefaults standardUserDefaults] setObject:keyAndVAlueString forKey:keyAndVAlueString];
//                     
//                     [[NSUserDefaults standardUserDefaults] setObject:keyAndVAlueString forKey:[NSString stringWithFormat:@"%@%@",keyAndVAlueString,keyAndVAlueString]];
//                     //有新版本通知
//                     [[NSNotificationCenter defaultCenter]postNotificationName:HaveNewVervion_ShowRedPoint object:self userInfo:nil];
//                 }
//                 
//                 if ([[responseJSONDictionary objectForKey:@"renewal"]isEqualToString:@"compel"])//强制更新
//                 {
//                     UIAlertView * alert =[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"发现新版本:v%@",newVersion] message:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"content"]] delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
//                     alert.tag = 111;
//                     [alert show];
//                 }
//                 else
//                 {
//                     NSLog(@"\n\n\n非强制更新？？\n\n\n");
//                     NSDate *nowDate=[NSDate dateWithTimeIntervalSinceNow:0];
//                     //
//                     if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"LastShowHaveNewVervionDate"] length])
//                     {
//                         NSDate *lastDate=[NSDate dateWithTimeIntervalSince1970:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LastShowHaveNewVervionDate"] integerValue]+24*60*60];
//                         //NSLog(@"lastDate :%@ \n nowDate :%@",lastDate,nowDate);
//                         if ([nowDate compare:lastDate]==NSOrderedAscending)
//                         {
//                             NSLog(@"\n\n\n不更新 时间不够\n\n\n");
//                             return;
//                         }
//                         
//                         NSLog(@"\n\n\n更新 时间够\n\n\n");
//                         UIAlertView * alert =[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"发现新版本:v%@",newVersion] message:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"content"]] delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
//                         alert.tag = 101;
//                         [alert show];
//                         
//                         
//                     }
//                     
//                     [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[nowDate timeIntervalSince1970]] forKey:@"LastShowHaveNewVervionDate"];
//                     
//                     
//                 }
//             }
//             
//         }
//         else
//         {
//             
//         }
//     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error ,NSString * msg)
//     {
//         if (![request isCancelled])
//         {
//             [request cancel];
//         }
//         
//     }];
//    
//    
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
