//
//  DJYBankTransferData.m
//  ipaycard
//
//  Created by Davidsph on 4/17/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYBankTransferData.h"

@implementation DJYBankTransferData


static DJYBankTransferData *single =nil;


+ (DJYBankTransferData *) newInstance{
 
    if (single==nil) {
        
        single =[[DJYBankTransferData alloc] init];
        
    }
  
    return single;
}


@end
