//
//  SwiperTimer.h
//  ipaycard
//
//  Created by 孙朋贞 on 13-8-28.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimerDelegate <NSObject>

@optional

-(void)dealWithInfo:(NSDictionary *)info;

@end


@interface SwiperTimer : NSObject
{

}


+(void)dealSwiperTimer:(NSString *)temStr andDelegate:(id<TimerDelegate>)delegate;
@end
