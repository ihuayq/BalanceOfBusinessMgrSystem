//
//  AutherInfo.m
//  ipaycard
//
//  Created by han on 13-1-4.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "AutherInfo.h"

@implementation AutherInfo
static AutherInfo *instence;

@synthesize USERID;
@synthesize LOGINID, LOGINNAME;
@synthesize nextStepInt;

+(AutherInfo *) newInstence{
  @synchronized(self){
    if (instence == nil) {
      instence = [[AutherInfo alloc] init];
    }
  }
  return instence;
}

+(id) allocWithZone:(NSZone *)zone{
  @synchronized(self){
    if (instence == nil) {
      instence = [super allocWithZone:zone];
      return instence;
    }
  }
  return nil;
}

-(id) copyWithZone:(NSZone *)zone{
  return self;
}

@end