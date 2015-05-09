//
//  AccChargeNetworkHelp.h
//  ipaycard
//
//  Created by RenLongfei on 14-3-11.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "DJYBaseNetworkHelp.h"
#import "PayView.h"
#import "NewPayNetworkData.h"
#import "DAccData.h"

@interface AccChargeNetworkHelp : DJYBaseNetworkHelp


+ (void)payAccChargeWithData : (NewPayNetworkData *)newPayData andDelegate : (id<ServiceDelegate>)delegate;

/*
 绑定银行卡
 */
+ (void)bindingCardWithData:(DAccData *)accData andDelegate:(id <ServiceDelegate>)delegate;


+ (void)unbindingCardWithData:(DAccData *)accUBData andDelegate :(id <ServiceDelegate>)delegate;

@end
