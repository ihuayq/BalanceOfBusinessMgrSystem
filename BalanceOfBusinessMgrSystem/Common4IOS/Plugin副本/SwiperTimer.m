//
//  SwiperTimer.m
//  ipaycard
//
//  Created by 孙朋贞 on 13-8-28.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "SwiperTimer.h"

@implementation SwiperTimer

-(id)initWithThread{
    self  = [super init];
    if (self) {
        
    }
    return self;
}


-(void)startTimer{
    
    NSDate *nowDate = [NSDate date];
    
    NSTimer *timer = [[NSTimer alloc]initWithFireDate:nowDate interval:5.0f target:self selector:@selector(compareValue) userInfo:nil repeats:NO];
    [timer fire];
}

-(void)compareValue:(NSTimer *)nstimer{
    NSString *swiperStr = [[nstimer userInfo] objectForKey:@"swiperTimer"];
    id delegate = [[nstimer userInfo] objectForKey:@"timeDelegate"];
    if ( ![swiperStr isEqualToString:@""]||swiperStr !=nil) {
        [nstimer invalidate];
        CCLog(@"销毁定时器");
        if ([delegate respondsToSelector:@selector(dealWithInfo:)]) {
            [delegate dealWithInfo:nil];
        }
    }else{
        CCLog(@"销毁定时器");
        [nstimer invalidate];
    }
}

+(void)dealSwiperTimer:(NSString *)temStr andDelegate:(id<TimerDelegate>)delegate{
    NSTimeInterval timeInterval = 5.0;
    NSMutableDictionary *temDic = [[NSMutableDictionary alloc]init];
    [temDic setObject:temStr forKey:@"swiperTimer"];
    [temDic setObject:delegate forKey:@"timeDelegate"];
    NSTimer *swipeTimer= [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(compareValue:) userInfo:temDic repeats:NO];
    NSLog(@"SwiperTimer=%@",swipeTimer);
}

@end
