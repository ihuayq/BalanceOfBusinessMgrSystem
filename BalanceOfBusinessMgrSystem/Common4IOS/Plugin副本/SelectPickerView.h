//
//  SelectPickerView.h
//  ipaycard
//
//  Created by han on 13-1-4.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionPickerDelegate.h"

@interface SelectPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIPickerView *pickView;
    NSArray *pickList;
}
@property (nonatomic,retain) id<ActionPickerDelegate> apDelegate;

- (id)initWithFrame:(CGRect)frame pickerList:(NSArray*) list;
@end
