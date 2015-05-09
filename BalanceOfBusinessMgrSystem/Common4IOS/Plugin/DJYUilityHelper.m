//
//  DJYUilityHelper.m
//  ipaycard
//
//  Created by Davidsph on 4/9/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYUilityHelper.h"

@implementation DJYUilityHelper


+ (NSString *) getCurrentTimeWithSpecialFormat{
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MMddHHmmss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //CCLog(@"时间为:%@",currentDateStr);
    return  currentDateStr;
}

+ (NSString *)getCurrentTimeWithSpecialFormatYY
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"时间为:%@",currentDateStr);
    
    return  currentDateStr;
}

+ (NSString *)getCurrentTimeWithDateFormat
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"时间为:%@",currentDateStr);
    
    return  currentDateStr;
}
@end
