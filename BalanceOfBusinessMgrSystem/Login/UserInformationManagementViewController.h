//
//  UserInformationManagementViewController.h
//  AllBelieve
//
//  Created by myMac on 14-8-31.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import "HP_BaseViewController.h"

@interface UserInformationManagementViewController : HP_BaseViewController



+(UserInformationManagementViewController*)shareUserInformationManagement;
-(BOOL)isUserRealNameAuthentication;
-(BOOL)isUserBindtheBankCard;
-(BOOL)isUserRealNameAuthenticationAndBindtheBankCard;
@end
