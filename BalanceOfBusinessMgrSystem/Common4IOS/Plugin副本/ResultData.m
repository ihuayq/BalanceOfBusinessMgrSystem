//
//  ResultData.m
//  ipaycard
//
//  Created by fei on 13-5-22.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "ResultData.h"

@implementation ResultData

static ResultData *single =nil;


+ (ResultData *) newInstance{
    
    if (single==nil) {
        
        single =[[ResultData alloc] init];
        
    }
    
    return single;
}


@end
