//
//  DJYUilityHelper.h
//  ipaycard
//
//  Created by Davidsph on 4/9/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJYUilityHelper : NSObject

/*******
 
 根据格式返回正确的时间  
 
 MMDDHHMMSS
 
 ********/


+ (NSString *) getCurrentTimeWithSpecialFormat;


+ (NSString *)getCurrentTimeWithSpecialFormatYY;


+ (NSString *)getCurrentTimeWithDateFormat;



@end
