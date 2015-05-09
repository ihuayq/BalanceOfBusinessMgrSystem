//
//  RTTransNetworkhelp.h
//  ipaycard
//
//  Created by RenLongfei on 14-2-17.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJYBaseNetworkHelp.h"

#import "DJYBankTransferData.h"

@interface RTTransNetworkhelp : DJYBaseNetworkHelp

+ (void)caculateRTTransFeeWithData: (DJYBankTransferData *)rtTransFeeData andDelegate: (id <ServiceDelegate>)delegate;

+ (void)commitRTTransWithData:(DJYBankTransferData *)rtTransConfirmData andDelegate:(id<ServiceDelegate>)delegate;


@end
