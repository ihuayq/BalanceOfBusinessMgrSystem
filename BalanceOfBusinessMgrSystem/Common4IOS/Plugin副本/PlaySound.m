//
//  PlaySound.m
//  ipaycard
//
//  Created by fei on 13-6-29.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "PlaySound.h"

@implementation PlaySound

-(id)initForPlayingVibrate{
    self = [super init];
    if (self) {
        soundId = kSystemSoundID_Vibrate;
    }
    return self;
}

-(void)play{
    AudioServicesPlaySystemSound(soundId);
}
-(void)playWav{
    
    NSString *soundFile=[[NSBundle mainBundle] pathForResource:@"ANIMAL" ofType:@"WAV"];
    
    NSURL *tapSound   =  [NSURL fileURLWithPath:soundFile];
    
    soundFileURLRef = (__bridge CFURLRef) tapSound;
    
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundFileObject);
    
    AudioServicesPlaySystemSound (soundFileObject);

}
-(void)dealloc{
    AudioServicesDisposeSystemSoundID(soundId);
}
@end
