//
//  HP_NSDateUtils.m
//  common4ios
//
//  Created by Yi Xu on 12-11-19.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import "HP_NSDateUtils.h"

@implementation HP_NSDateUtils

+(BOOL)compareDate:(NSDate *)date1 isEarlierDate:(NSDate *) date2{
    BOOL isEarlier = NO;
    
    if ([date1 isEqualToDate:[date1 earlierDate:date2]]) {
        isEarlier = YES;
    };
    
    return isEarlier;
}

+(BOOL)compareTime:(NSTimeInterval)time1 isEarlierTime:(NSTimeInterval) time2{
    BOOL isEarlier = NO;
    NSDate *date1 = [self getDateFromTimeInterval:time1];
    NSDate *date2 = [self getDateFromTimeInterval:time2];
    
    if ([date1 isEqualToDate:[date1 earlierDate:date2]]) {
        isEarlier = YES;
    };
    
    return isEarlier;
}

+(BOOL)isLongerThen24Hours:(NSTimeInterval)time {
    
    BOOL isLonger = NO;
    if(time>24*60*60){
        isLonger = YES;
    }
    return isLonger;
}


+(NSDate *) getDateFromTimeInterval:(NSTimeInterval) interval{
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

+(NSTimeInterval) getTimeIntervalFromDate:(NSDate *)date{
    
    return [date timeIntervalSince1970];
    
}

//获取当前时间
+ (NSString *)getCurrentTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"MMddhhmmss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];

    return date;
}
@end
