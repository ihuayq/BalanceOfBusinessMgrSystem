//
//  UserInformationManagementViewController.m
//  AllBelieve
//
//  Created by myMac on 14-8-31.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import "UserInformationManagementViewController.h"

@interface UserInformationManagementViewController ()

@end


@implementation UserInformationManagementViewController


static UserInformationManagementViewController* userInformationManagement;
+(UserInformationManagementViewController*)shareUserInformationManagement
{
    if (!userInformationManagement) {
        userInformationManagement=[[UserInformationManagementViewController alloc]init];
    }
    return userInformationManagement;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(BOOL)isUserRealNameAuthentication
{
    if (([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:AUTHSTATUS]isEqualToString:AUTHED]||[[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:AUTHSTATUS]isEqualToString:PREAUTH]||[[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:AUTHSTATUS]isEqualToString:UPLOAD]))
    {
        return YES;
    }
    
    return NO;
    
}
-(BOOL)isUserBindtheBankCard
{
    if ([[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:BANKBINDSTAUS]isEqualToString:BINDED]||[[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:BANKBINDSTAUS]isEqualToString:UPLOAD])
    {
        return YES;
    }
    
    return NO;
}
-(BOOL)isUserRealNameAuthenticationAndBindtheBankCard
{
    if ([self isUserRealNameAuthentication]&&[self isUserBindtheBankCard])
    {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
