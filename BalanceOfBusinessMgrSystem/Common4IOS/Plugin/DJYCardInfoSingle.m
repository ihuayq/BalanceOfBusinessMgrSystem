//
//  DJYCardInfoSingle.m
//  ipaycard
//
//  Created by Davidsph on 5/13/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYCardInfoSingle.h"

@implementation DJYCardInfoSingle

- (id) init{
    
    if (self =[ super init]) {
        
    }
    return self;
}

static DJYCardInfoSingle *single =nil;

+ (DJYCardInfoSingle *) newCardInfoInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[DJYCardInfoSingle alloc] init];
        
    });
    return single;
}

- (void) initCardInfoSingle{
    
    self.yu_23=@"";
    self.cardType = @"";
    self.inAuth= @"";
    self.outAuth= @"";
    
    self.purAr = @"";
    self.backAr = @"";
    self.userNo =@"";
    
    self.cardNum = @"";
    self.cardPwd = @"";
    self.cardSd = @"";
    self.fenSanYinZi = @"";
    
    self.randrom = @"";
    self.inRandrom = @"";
    self.outRandrom =@"";
    self.signRandrom = @"";
    
    self.deviceId =@"";
    self.deviceType =@"";
    
    self.checkCodeForPay = @"";
    self.checkCodeForRegister = @"";
    
    self.leftAmt = @""; //电子钱包余额
    self.limitAmt=@""; //最大圈存限额
    self.bankType = @"";
    self.bankName = @"";
    self.icData = @"";
    self.psw = @"";
    
    self.isPlugin = NO;

}

@end
