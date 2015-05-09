//
//  MobileRechargeOrder.m
//  ipaycard
//
//  Created by han on 13-1-4.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "MobileRechargeOrder.h"

@implementation MobileRechargeOrder
static MobileRechargeOrder *instence;

@synthesize prodectDict;
@synthesize confirmDict;
@synthesize detailDict;
@synthesize phoneNum;
+(MobileRechargeOrder *) newInstence{
  @synchronized(self){
    if (instence == nil) {
      instence = [[MobileRechargeOrder alloc] init];
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

- (void)initMobileData{
    
    _provid = @"";
    _operid = @"";
    _phonetypeid = @"";
    _facestring = @"";
    _valueStr = @"";
    _productID = @"";
    _reqId = @"";
    _provname = @"";
    _opertype = @"";
    
}


@end
