//
//  DjyBaseView.m
//  动画测试
//
//  Created by Davidsph on 5/29/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "DjyBaseView.h"

@implementation DjyBaseView

@synthesize animationType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    return self;
    
}



-(void)beginAnimation{
    
  CCLog(@"%s,%d",__FUNCTION__,__LINE__);
    

}



-(void)changeFrameToZore{
    
    
    
}

- (void)stopAnimation{
    
}

- (id) initWithFrame:(CGRect)frame animationtype:(NSInteger ) animatType{
    
    return self;
    
}

- (id) initWithFrame:(CGRect)frame animationtype:(NSInteger ) animatType andBusType:(NSInteger) busType{
    
      
    return self;
    
}

-(void)changeBackImage:(NSInteger )businessType{
    
}


@end
