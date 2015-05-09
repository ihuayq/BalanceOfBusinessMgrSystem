//
//  HP_NSDateUtils.h
//  common4ios
//
//  Created by Yi Xu on 12-11-19.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_NSDateUtils : NSObject
{
    
}

//比较date1是否在date2之前
+(BOOL)compareDate:(NSDate *)date1 isEarlierDate:(NSDate *) date2;

//比较time1是否在time2之前
+(BOOL)compareTime:(NSTimeInterval)time1 isEarlierTime:(NSTimeInterval) time2;

//比较time是否大雨24小时
+(BOOL)isLongerThen24Hours:(NSTimeInterval)time ;

//NSTimeInterval 类型转换为 NSDate类型
+(NSDate *) getDateFromTimeInterval:(NSTimeInterval) interval;

//NSDate 类型转换为 NSTimeInterval类型
+(NSTimeInterval) getTimeIntervalFromDate:(NSDate *)date;

//获取当前时间
+ (NSString *)getCurrentTime;

@end
