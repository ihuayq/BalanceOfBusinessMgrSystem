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
#import "CLLockVC.h"
#import "CLLockNavVC.h"
#import "MBProgressHUD.h"

@interface AppDelegate ()<UIAlertViewDelegate>{
    //NSTimer * loginCheckTimer;
    SRWebSocket *_webSocket;
    MBProgressHUD *HUD;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginInitMainwidow:) name:@"LoginInitMainwidow" object:nil];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //[[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:LOGIN_STATUS];
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
    
#else
    BMInvestmentConfirmViewController* Vc=[[BMInvestmentConfirmViewController alloc]init];
    self.window.rootViewController = Vc;
#endif
    
    return YES;
}



- (void)LoginInitMainwidow:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"login"]);
    NSLog(@"－－－－－接收到通知------");
    
//    //是否商户1 还是自然人0 登录 logintype
//    if( [text.userInfo[@"login"] isEqualToString:@"1"]){
//        //判断商户引导页是否显示过
//        NSString* keystring=[NSString stringWithFormat:@"%@_GuidePage_%ld",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],(long)SUPPLYER_GUIDE];
//        if (![[[NSUserDefaults standardUserDefaults] objectForKey:keystring] isEqualToString:keystring])
//        {
//            GuidViewController * guideVc=[[GuidViewController alloc]init];
//            guideVc.type = SUPPLYER_GUIDE;
//            self.window.rootViewController = guideVc;
//            return;
//        }
//        
//        BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
//        self.window.rootViewController = mainview;
//    }
//    //自然人登录
//    else
    if([text.userInfo[@"login"] isEqualToString:@"0"] || [text.userInfo[@"login"] isEqualToString:@"1"])
    {
//        //判断自然人引导页是否显示过
//        NSString* keystring=[NSString stringWithFormat:@"%@_GuidePage_%ld",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],(long)NATUREMAN_GUIDE];
//        if (![[[NSUserDefaults standardUserDefaults] objectForKey:keystring] isEqualToString:keystring])
//        {
//            GuidViewController * guideVc=[[GuidViewController alloc]init];
//            guideVc.type = NATUREMAN_GUIDE;
//            self.window.rootViewController = guideVc;
//            return;
//        }


        BMNaturalManMainViewController* Vc=[[BMNaturalManMainViewController alloc] init];
        self.window.rootViewController = Vc;
        
    }
    //登陆界面,手势登陆或者密码登陆两种情况
    else if([text.userInfo[@"login"] isEqualToString:@"2"])
    {
//        LoginViewController *login = [[LoginViewController alloc] init];
//        if (text.userInfo[@"isSupplyer"]) {
//            login.isSupplerSelected = [text.userInfo[@"isSupplyer"] boolValue];
//        }
//        self.window.rootViewController = login;
        [self initWindowRootViewController];
    }
    //设置手势密码界面
    else if([text.userInfo[@"login"] isEqualToString:@"3"])
    {
        [self setLockPwd];
    }
    else if([text.userInfo[@"login"] isEqualToString:@"4"])
    {
        login = [[LoginViewController alloc] init];
        nc =[[UINavigationController alloc]initWithRootViewController:login];
        [nc.navigationBar setHidden:YES];
        self.window.rootViewController = nc;
    }
}

-(void)setLockPwd{
    CLLockVC  *lockVC = [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
        NSLog(@"密码设置成功");
        //设置过标记
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"IsLoginGesturePwdSet"];
        //下次直接使用手势登陆进入主界面
        //使用登陆类型，0密码登陆，1手势登陆
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"IsUsingGesturePwdLogin"];
        
        [lockVC dataRequestSearch];
        
//        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
//        NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
    CLLockNavVC *navVC = [[CLLockNavVC alloc] initWithRootViewController:lockVC];
    self.window.rootViewController = navVC;
}

-(void)initWindowRootViewController
{
    //查看是否已经登陆，
    NSString *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_STATUS];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_STATUS] isEqualToString:@"1"]) {
        //登陆查看下手势密码设置了没有
        NSString *isLoginGestureSet = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsLoginGesturePwdSet"] ;
        //手势密码是否设置 0，nil,无；1，设置过
        if ([isLoginGestureSet intValue] == 0 || isLoginGestureSet == nil) {
            [self setLockPwd];
            return;
        }
    }
    
    //若设置了手势密码
    NSString *isLoginType = [[NSUserDefaults standardUserDefaults] objectForKey:@"IsUsingGesturePwdLogin"];//使用登陆类型，0密码登陆，1手势登陆
    if ( isLoginType == nil  || [isLoginType intValue] == 0 )
    {
        login = [[LoginViewController alloc] init];
        nc =[[UINavigationController alloc]initWithRootViewController:login];
        [nc.navigationBar setHidden:YES];
        self.window.rootViewController = nc;
    }
    else if ( [isLoginType intValue] == 1 ){
        //验证手势密码
        CLLockVC  *lockVC = [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
            // 点击忘记按钮，处理block
            NSLog(@"忘记密码");
            //重置标记，使用普通登陆，并需要重置手势密码
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:LOGIN_STATUS];//0未登录、1的登录
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"IsUsingGesturePwdLogin"];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"IsLoginGesturePwdSet"];
            //进入登陆主界面
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"login", nil];
            NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码正确");
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"IsUsingGesturePwdLogin"];
            //进入主界面
//            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
//            NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [lockVC dataRequestSearch];
        }];
        
        CLLockNavVC *navVC = [[CLLockNavVC alloc] initWithRootViewController:lockVC];
        self.window.rootViewController = navVC;
    }
}

-(void)checkAPPUpdate
{
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        return;
    }
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];

    [connDictionary setObject:@"IOS" forKey:@"osType"];
    [connDictionary setObject:[HP_NSBundleUtils getMainBundleAPPVersion] forKey:@"currentVersion"];
    
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,AppVersionURL];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary] stringByAppendingString:ORIGINAL_KEY]] forKey:@"signature"];
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    NSLog(@"connDictionary:%@",connDictionary);
    
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"检查更新ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         
         if ([ret isEqualToString:@"100"])
         {
             NSString* newVersion=[responseJSONDictionary objectForKey:@"version"];
             NSArray* newVersionArray=[[responseJSONDictionary objectForKey:@"version"] componentsSeparatedByString:@"."];
             
             NSArray *currentVersionArray = [NNString splitString: [HP_NSBundleUtils getMainBundleAPPVersion] withStr:@"."];
             
             NSLog(@"newVersionArray=%@ currentVersionArray=%@",newVersionArray,currentVersionArray);
             
             BOOL isHaveNewVervion = NO;
             for (int i=0; i<[newVersionArray count]; i++)
             {
                 if ([[newVersionArray objectAtIndex:i] intValue]>[[currentVersionArray objectAtIndex:i] intValue])
                 {
                     NSLog(@"有新版");
                     isHaveNewVervion = YES;
                     break;
                 }
                 if ([[newVersionArray objectAtIndex:i] intValue]<[[currentVersionArray objectAtIndex:i] intValue])
                 {
                     NSLog(@"线上是旧版");
                     break;
                 }
             }
             
             if (isHaveNewVervion)
             {
                 NSLog(@"\n\n\n真的有新版本啦\n\n\n");
                 
                 NSString* keyAndVAlueString=[NSString stringWithFormat:@"%@_%@",CurVervionString,HaveNewVervion_ShowRedPoint];
                 if (![[[NSUserDefaults standardUserDefaults] objectForKey:keyAndVAlueString]isEqualToString:keyAndVAlueString])
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:keyAndVAlueString forKey:keyAndVAlueString];
                     
                     [[NSUserDefaults standardUserDefaults] setObject:keyAndVAlueString forKey:[NSString stringWithFormat:@"%@%@",keyAndVAlueString,keyAndVAlueString]];
                     //有新版本通知
                     [[NSNotificationCenter defaultCenter] postNotificationName:HaveNewVervion_ShowRedPoint object:self userInfo:nil];
                 }
                 
                 if ([[responseJSONDictionary objectForKey:@"renewal"]isEqualToString:@"1"])//强制更新
                 {
//                     UIAlertView * alert =[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"发现新版本:v%@",newVersion] message:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"content"]] delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
//                     alert.tag = 111;
//                     [alert show];
                     
                     UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"发现新版本:v%@",newVersion] delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                     alert.tag = 111;
                     [alert show];
                 }
                 else
                 {
                     NSLog(@"\n\n\n非强制更新？？\n\n\n");
                     NSDate *nowDate=[NSDate dateWithTimeIntervalSinceNow:0];
                     //
                     if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"LastShowHaveNewVervionDate"] length])
                     {
                         NSDate *lastDate=[NSDate dateWithTimeIntervalSince1970:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LastShowHaveNewVervionDate"] integerValue]+24*60*60];
                         //NSLog(@"lastDate :%@ \n nowDate :%@",lastDate,nowDate);
                         if ([nowDate compare:lastDate]==NSOrderedAscending)
                         {
                             NSLog(@"\n\n\n不更新 时间不够\n\n\n");
                             return;
                         }
                         
                         NSLog(@"\n\n\n更新 时间够\n\n\n");
                         UIAlertView * alert =[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"发现新版本:v%@",newVersion] message:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"content"]] delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
                         alert.tag = 101;
                         [alert show];
                     }
                     
                     [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[nowDate timeIntervalSince1970]] forKey:@"LastShowHaveNewVervionDate"];
                 }
             }
             
         }

     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error ,NSString * msg)
     {
         if (![request isCancelled])
         {
             [request cancel];
         }
         
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/chao-e-bao/id1006544360?mt=8"];
        //NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
        [[UIApplication sharedApplication]openURL:url];
    }
}


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
    
    [self checkAPPUpdate];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
