//
//  DJYCreditCardData.m
//  ipaycard
//
//  Created by Davidsph on 4/19/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYCreditCardData.h"

@implementation DJYCreditCardData


static DJYCreditCardData *single =nil;




+ (DJYCreditCardData *) newInstance{
    
    if (single==nil) {
        
        single =[[DJYCreditCardData alloc] init];
        
    }
    
    return single;
}




@end
