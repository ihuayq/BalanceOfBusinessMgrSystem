//
//  PlaySound.h
//  ipaycard
//
//  Created by fei on 13-6-29.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PlaySound : NSObject{
    SystemSoundID soundId;
    
    CFURLRef        soundFileURLRef ;
    
    SystemSoundID   soundFileObject;
}

-(id)initForPlayingVibrate;
/**
 *  @brief  为播放系统音效初始化(无需提供音频文件)
 *
 *  @param resourceName 系统音效名称
 *  @param type 系统音效类型
 *
 *  @return self
 */
-(void)play;

-(void)playWav;

@end
