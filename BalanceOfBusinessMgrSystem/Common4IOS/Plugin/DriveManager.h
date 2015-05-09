//
//  DriveManager.h
//  ipaycard
//
//  Created by RenLongfei on 14-4-10.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJYCardInfoSingle.h"
#import "DJYBaseNetworkHelp.h"

typedef enum{
    DeviceZFT = 0,
    DeviceHezi,
}DeviceName;

@protocol DeviceManagerDelegate


/*
 更改界面
 */

- (void)deviceManagerDelegateWithInfotype:(NSString *)type;


@end

@interface DriveManager : NSObject

@property (nonatomic, weak) id<DeviceManagerDelegate> delegate;

- (id)initWithType:(DeviceName)deviceName;

- (void) driveInit;

- (void) waitForDevicePlugin;

- (void) getDeviceInfo;

- (void) makeRegister;

- (void) questSwipeCard;

- (void) gotoPayWithPsw:(NSString *)psw andBlock:(void(^)(bool finish)) block;
@end
