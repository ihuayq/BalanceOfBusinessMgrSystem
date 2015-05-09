//
//  DAccData.m
//  ipaycard
//
//  Created by RenLongfei on 14-3-10.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "DAccData.h"

@implementation DAccData

static DAccData *instance;

+(DDataModal *)newInstance{
    @synchronized(self){
        if (instance == nil) {
            NSLog(@"bb");

            instance = [[DAccData alloc] init];
        }
    }
    return instance;
}
- (void)initData{
    
    _accNum = @"";
    _accName = @"";
    _accBalance =@"";
    _accTransValue = @"";
    _accTransReqId =@"";
    _desc = @"";
    _accTNMobile = @"";
    _accChargeValue =@"";
    _ordNum =@"";
    _bankCode = @"";
    _branchName = @"";
    _trxAmount = @"";
    _settlePwd = @"";
    
    _bankCredType = @"";
    _casOrdId = @"";
    _ordStatus = @"";
    _bankNet = @"";
    _dealtime = @"";
    _provinceStr =@"";
    _cityStr = @"";

}


@end
