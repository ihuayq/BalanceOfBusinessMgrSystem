//
//  TrainData.m
//  ipaycard
//
//  Created by RenLongfei on 13-12-24.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "TrainData.h"

@implementation TrainData

@synthesize train_queryid;
@synthesize train_id;
@synthesize train_no;
@synthesize order_id;

@synthesize train_array;
@synthesize seat_array;

@synthesize fromStation, toStation;
@synthesize from_info, to_Info,spendtime;
@synthesize dateStr;
@synthesize startTime;
@synthesize paytime;

@synthesize unitPrice, poundage;
@synthesize trainPrice;

@synthesize passengerArr;
@synthesize totalAmountString, jsonString, receiveNumString;
@synthesize num;

@synthesize billTitle, billInfo, detailAddress;

@synthesize withBill;

@synthesize phoneInfo;

static TrainData *single =nil;

+ (TrainData *) newInstance{
    
    if (single==nil) {
        
        single =[[TrainData alloc] init];
    }
    
    return single;
}

- (void)reset{
    train_queryid = @"";
    
}

@end
