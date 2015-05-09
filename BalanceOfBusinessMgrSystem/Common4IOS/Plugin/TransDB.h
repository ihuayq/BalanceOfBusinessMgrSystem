//
//  TransDB.h
//  ipaycard
//
//  Created by fei on 13-5-17.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJYBankTransferData.h"

#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@interface TransDB : NSObject{
    
}


+(FMDatabase *) openDatabase;
+(NSArray *) findAllData;
+(void)deleteDataByID:(NSString *)ID;
+ (void) insertTransData:(DJYBankTransferData *) aData;


@end
