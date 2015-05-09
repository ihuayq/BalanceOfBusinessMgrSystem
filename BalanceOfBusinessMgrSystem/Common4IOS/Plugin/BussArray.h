//
//  BussArray.h
//  ipaycard
//
//  Created by RenLongfei on 13-12-10.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BussArray : NSObject

@property (nonatomic, strong) NSMutableArray *bussMutArray;

@property (nonatomic, strong) NSArray *bussArray;

@property (nonatomic, strong) NSArray *lifeArray;

@property (nonatomic, strong) NSArray *finaceArray;

@property (nonatomic, strong) NSArray *entertainmentArray;

@property (nonatomic, strong) NSMutableArray *allArray;

@property (nonatomic, strong) NSUserDefaults *arrayUserInfo;
//火车历史记录
@property (nonatomic, strong) NSMutableArray *historyArray;

@property (nonatomic, strong) NSDate *beginTime;

@property (nonatomic, strong) NSDate *endTime;

+ (BussArray *)sharedInstance;

-(void)changeArraySort:(NSString *)bussTypeString;

-(void)addNewToHistory :(NSString *)stationInfo;

@end
