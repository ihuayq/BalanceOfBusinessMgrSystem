//
//  CreditDB.h
//  ipaycard
//
//  Created by fei on 13-5-17.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJYCreditCardData.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@interface CreditDB : NSObject



+(FMDatabase *) openDatabase;
+(NSMutableArray *) findAllData;
+(void)deleteDataByID:(NSString *)ID;
+ (void) insertTransData:(DJYCreditCardData *) aData;


@end
