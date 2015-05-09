//
//  CityDataBase_David.h
//  MyFlight2.0
//
//  Created by Davidsph on 1/12/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDataBase_David : NSObject

//初始化数据库
+(void) initDataBase;


//查找全国省份 key为 省份名字 
+ (NSMutableDictionary *) findAllCitiesSortedInKeys;


+ (NSMutableArray *) findAllCities;

//所有的直辖市 key 为直辖市
+ (NSMutableDictionary *) findAllDerectCities;


//搜索

+(NSMutableArray *)findCityBySiftBy:(NSString *)condition;

@end
