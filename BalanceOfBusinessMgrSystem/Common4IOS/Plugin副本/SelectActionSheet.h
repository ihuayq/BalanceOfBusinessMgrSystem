//
//  SelectActionSheet.h
//  ipaycard
//
//  Created by han on 13-1-4.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetDelegate.h"
#import "SelectPickerView.h"

@interface SelectActionSheet : UIActionSheet<ActionPickerDelegate>{
    UIToolbar* toolBar;
    SelectPickerView *picker;
  
    int pickSelectedIndex;
}

@property (nonatomic,strong) NSMutableArray *pickList;

@property (nonatomic,retain) id<ActionSheetDelegate> asDelegate;

-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title pickList:(NSArray *) list;

@end
