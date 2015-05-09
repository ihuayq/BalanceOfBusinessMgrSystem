//
//  AgreementViewController.h
//  jxtuanuser
//
//  Created by fengxiaoguang on 13-11-15.
//  Copyright (c) 2013年 fengxiaoguang. All rights reserved.
//

#import "HP_BaseViewController.h"
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"

@interface AgreementViewController : HP_BaseViewController
{
    NSMutableDictionary* transferDict;
    int type;
    
    UIWebView *webView;

}

@property(nonatomic,retain)NSMutableDictionary* transferDict;
@property(nonatomic)int type;
@end
