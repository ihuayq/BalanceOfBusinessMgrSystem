//
//  DriveManager.m
//  ipaycard
//
//  Created by RenLongfei on 14-4-10.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "DriveManager.h"

@implementation DriveManager

- (id)initWithType:(DeviceName)deviceName{
    CCLog(@"01");
    
    return self;
    
}

- (void) driveInit{
    CCLog(@"driveInit");
}

- (void) waitForDevicePlugin{
    CCLog(@"waitForDevicePlugin");
}

- (void) getDeviceInfo{
    CCLog(@"getDeviceInfo");
}

- (void)makeRegister{
    CCLog(@"makeRegister");

}

- (void) questSwipeCard{
    CCLog(@"questSwipeCard");

}

- (void) gotoPayWithPsw:(NSString *)psw andBlock:(void(^)(bool finish)) block{
    CCLog(@"gotoPayWithBlock");
}

@end
