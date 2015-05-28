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

@interface AppDelegate (){
    NSTimer * loginCheckTimer;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:LOGIN_STATUS];
    
    
    NSString* keystring=[NSString stringWithFormat:@"%@_WelcomePage",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:keystring]isEqualToString:keystring])
    {
        [self initWelcomePage];
    }
    else
    {
        [self initWindowRootViewController];
    }
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginInitMainwidow:) name:@"LoginInitMainwidow" object:nil];
    
    return YES;
}

//初始化一个定时器,用于检验是否有相同的账号登陆情况
-(void)initTimer
{
    //时间间隔
    NSTimeInterval timeInterval =1.0 ;
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
//    NSDateFormatter dateFormator = [[NSDateFormatter alloc] init];
//    dateFormator.dateFormat = @"yyyy-MM-dd  HH:mm:ss";
//    NSString *date = [dateformater stringFromDate:[NSDate date]];
//    if([date isEqualToString:@"2011-11-09 23:59:59"])
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:TITLE_NAME
//                                                        message:@"现在马上就有新的一天了！"
//                                                       delegate:self
//                                               ancelButtonTitle:nil
//                                              otherButtonTitles:CONFIRM_TITLE, nil];
//        [alert show];
//        [alert release];
//    }
}


- (void)LoginInitMainwidow:(NSNotification *)text{
    NSLog(@"%@",text.userInfo[@"login"]);
    NSLog(@"－－－－－接收到通知------");
    
    //是否商户1 还是自然人0 登录 logintype
    if( [text.userInfo[@"login"] isEqualToString:@"1"]){
        BMCommercialTenantMainViewController * mainview=[[BMCommercialTenantMainViewController alloc]init];
        self.window.rootViewController = mainview;
        //[self.navigationController pushViewController:mainview animated:NO];
    }
    //自然人登录
    else if([text.userInfo[@"login"] isEqualToString:@"0"])
    {
        if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"naturalMark"] isEqualToString:@"0"]) {
            SettingLoginPassWordViewController * settingVc=[[SettingLoginPassWordViewController alloc]init];
            self.window.rootViewController = settingVc;
            // [self.window.rootViewController presentViewController:settingVc animated:YES completion:NULL];
            //[self.navigationController pushViewController:settingVc animated:NO];
        }else{
            BMNaturalManMainViewController* Vc=[[BMNaturalManMainViewController alloc]init];
            self.window.rootViewController = Vc;
            //[self.navigationController pushViewController:Vc animated:NO];
        }
    }
    //自然人登录
    else if([text.userInfo[@"login"] isEqualToString:@"2"])
    {
        LoginViewController *login = [[LoginViewController alloc] init];
        self.window.rootViewController = login;
    }
}

#pragma mark
-(void)initWelcomePage
{
    topScrollView=[[UIScrollView alloc]init];
    [topScrollView setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    topScrollView.backgroundColor=[UIColor clearColor];
    [topScrollView setUserInteractionEnabled:YES];
    topScrollView.delegate=self;
    [self.window addSubview:topScrollView];
    
    NSLog(@"--------------------\n\n\n-----------\n\n----------");
    
    for (int i=0; i<5; i++)
    {
        bigSquareImageView=[[HP_UIImageView alloc]initWithFrame:CGRectMake(MainWidth*i,0,MainWidth,MainHeight)];
        bigSquareImageView.tag=2000+i;
        [bigSquareImageView setUserInteractionEnabled:YES];
        if (MainHeight>500)
        {
            [bigSquareImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"5come%d",i]]];
        }
        else
        {
            [bigSquareImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"4come%d",i]]];
        }
        //        bigSquareImageView.layer.cornerRadius=6;
        //        bigSquareImageView.layer.masksToBounds=YES;
        bigSquareImageView.backgroundColor=[UIColor clearColor];
        
        
        if (i==4)
        {
            HP_UIButton* moreThingButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
            if (MainHeight>500)
            {
                moreThingButton.frame = CGRectMake((MainWidth-150)/2, MainHeight-110, 150, 40);
            }
            else
            {
                moreThingButton.frame = CGRectMake((MainWidth-150)/2, MainHeight-80, 150, 40);
            }
            
            [moreThingButton setBackgroundColor:[HP_UIColorUtils clearColor]];
            [moreThingButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [moreThingButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
            [moreThingButton addTarget:self action:@selector(changeCancleWelcomePage) forControlEvents:UIControlEventTouchUpInside];
            [bigSquareImageView addSubview:moreThingButton];
        }
        
        
        
        [topScrollView addSubview:bigSquareImageView];
        
    }
    
    [topScrollView setContentSize:CGSizeMake(MainWidth*5, MainHeight)];
    topScrollView.pagingEnabled=YES;
    topScrollView.showsHorizontalScrollIndicator=NO;
    
    
}
-(void)changeCancleWelcomePage
{
    NSString* keystring=[NSString stringWithFormat:@"%@_WelcomePage",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [[NSUserDefaults standardUserDefaults] setObject:keystring forKey:keystring];
    
    [topScrollView removeFromSuperview];
    
    [self initWindowRootViewController];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x>MainWidth*4+50)
    {
        
        [self changeCancleWelcomePage];
    }
    
    currentPage=(scrollView.contentOffset.x+MainWidth/2)/MainWidth;
    topPageControl.currentPage=currentPage;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    currentPage=scrollView.contentOffset.x/MainWidth;
    
    topPageControl.currentPage=currentPage;
    
    [UIView animateWithDuration:0.3 animations:^{
        [topScrollView setContentOffset:CGPointMake(MainWidth*currentPage, 0)];
    }];
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
    if ([loginStatus intValue]==0)
    {
        
        nc =[[UINavigationController alloc]initWithRootViewController:login];
        [nc.navigationBar setHidden:YES];
        self.window.rootViewController = nc;
    }
    else if([loginStatus intValue]==1)
    {
        nc = [[UINavigationController alloc]initWithRootViewController:login];
        [nc.navigationBar setHidden:YES];
        self.window.rootViewController = nc;
        
        MainViewController * mainViewController = [[MainViewController alloc] init];
        [nc pushViewController:mainViewController animated:NO];
    }
    
    
}

-(void)checkAPPUpdate
{
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        return;
    }
    
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    NSString* string3des=@"众信";
    NSString *encodedValue = [[ASIFormDataRequest requestWithURL:nil] encodeURL:string3des];//编码encode
    [connDictionary setObject:encodedValue forKey:@"mark"];
    
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
    
    [connDictionary setObject:@"众信" forKey:@"mark"];
    
    
    NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,getversionURL];
    
    NSLog(@"connDictionary:%@",connDictionary);
    
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"检查更新：ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         
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
                     [[NSNotificationCenter defaultCenter]postNotificationName:HaveNewVervion_ShowRedPoint object:self userInfo:nil];
                 }
                 
                 if ([[responseJSONDictionary objectForKey:@"renewal"]isEqualToString:@"compel"])//强制更新
                 {
                     UIAlertView * alert =[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"发现新版本:v%@",newVersion] message:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"content"]] delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
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
         else
         {
             
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error ,NSString * msg)
     {
         if (![request isCancelled])
         {
             [request cancel];
         }
         
     }];
    
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
