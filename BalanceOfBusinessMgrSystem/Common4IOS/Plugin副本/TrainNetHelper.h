//
//  TrainNetHelper.h
//  ipaycard
//
//  Created by RenLongfei on 14-1-2.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJYBaseNetworkHelp.h"

#import "NewPayNetworkData.h"

#import "TrainData.h"

@interface TrainNetHelper : DJYBaseNetworkHelp

+ (void)commitTicketWithData:(TrainData *)trainConfirmData andDelegate:(id<ServiceDelegate>)delegate;

+ (void) payTrainTicketWithData:(NewPayNetworkData *)payNetworkData andDelegate:(id<ServiceDelegate>) delegate;

@end
