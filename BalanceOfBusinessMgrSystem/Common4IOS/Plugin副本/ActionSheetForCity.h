//
//  ActionSheetForCity.h
//  ipaycard
//
//  Created by WangJian on 13-4-19.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionSheetForCity;

@protocol ActionSheetForCityDelegate <NSObject>

-(void) didSelectedProvicenAndCity:(NSString *)province city:(NSString *) city;

@end


@interface ActionSheetForCity : UIActionSheet<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,assign) id<ActionSheetForCityDelegate> cityDelegate;
@property (nonatomic,strong) UIPickerView *pickerView;

-(void)backToOrignal;
@end
