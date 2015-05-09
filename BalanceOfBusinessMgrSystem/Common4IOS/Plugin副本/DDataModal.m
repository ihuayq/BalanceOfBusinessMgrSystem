//
//  DDataModal.m
//  ipaycard
//
//  Created by RenLongfei on 14-3-10.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "DDataModal.h"

@implementation DDataModal
static DDataModal *instance;

+(DDataModal *) newInstance{
    @synchronized(self){
        if (instance == nil) {
            NSLog(@"aa");
            instance = [[DDataModal alloc]init];
        }
    }
    return instance;
}

+(id) allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

-(id) copyWithZone:(NSZone *)zone{
    return self;
}



@end
