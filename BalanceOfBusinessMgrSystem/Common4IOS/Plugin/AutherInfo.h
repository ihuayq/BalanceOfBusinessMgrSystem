//
//  AutherInfo.h
//  ipaycard
//
//  Created by han on 13-1-4.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutherInfo : NSObject{
    NSString *USERID;
    NSString *LOGINID;
    NSString *LOGINNAME;
    int nextStepInt;
}

@property (nonatomic,retain) NSString *USERID;
@property (nonatomic, retain) NSString *LOGINID;
@property (nonatomic, retain) NSString *LOGINNAME;
@property (nonatomic, assign) int nextStepInt;

+(AutherInfo *) newInstence;

@end
