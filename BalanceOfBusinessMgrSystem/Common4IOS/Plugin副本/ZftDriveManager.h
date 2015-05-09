//
//  ZftDriveManager.h
//  ipaycard
//
//  Created by RenLongfei on 14-4-10.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "DriveManager.h"


#import "ZftQiposLib.h"
#import "ZFTInstance.h"

@interface ZftDriveManager : DriveManager <SwiperDelegate, ServiceDelegate>
{
    ZFTInstance *zftIns;
    ZftQiposLib *zft;
}

@property (nonatomic) DJYCardInfoSingle *cardData;


@end
