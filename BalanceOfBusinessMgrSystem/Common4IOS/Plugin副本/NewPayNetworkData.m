//
//  NewPayNetworkData.m
//  ipaycard
//
//  Created by fei on 13-4-24.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "NewPayNetworkData.h"

@implementation NewPayNetworkData

static NewPayNetworkData *single =nil;

+ (NewPayNetworkData *)newInstance{
    
    if (single==nil) {
        single =[[NewPayNetworkData alloc] init];
    }
    return single;
    
}
@end
