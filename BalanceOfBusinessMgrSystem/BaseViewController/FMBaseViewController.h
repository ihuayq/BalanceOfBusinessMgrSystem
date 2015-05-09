//
//  BaseViewController.h
//  Canada
//
//  Created by zhaojianguo on 13-10-9.
//  Copyright (c) 2013年 zhaojianguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZNavigationView.h"
//#import "UIView+Additions.h"
//#import "FMSongListModel.h"
//#import "FMSingerModel.h"
//#import "UIImageView+WebCache.h"
//#import "MCDataEngine.h"
//#import "Globle.h"
//#import "ProgressHUD.h"
//#import "ICSDrawerController.h"


@interface FMBaseViewController : UIViewController<ZZNavigationViewDelegate>
{
    //Globle * globle;
}
@property (nonatomic,strong) ZZNavigationView * navigation;

@end
