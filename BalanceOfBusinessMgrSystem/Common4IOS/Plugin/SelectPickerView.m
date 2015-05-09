//
//  SelectPickerView.m
//  ipaycard
//
//  Created by han on 13-1-4.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "SelectPickerView.h"

@implementation SelectPickerView

- (id)initWithFrame:(CGRect)frame pickerList:(NSArray*) list
{
    self = [super initWithFrame:frame];
    if (self) {

        pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 30.0f, 320.0f, iOS7?frame.size.height-30:216.0f)];
        pickView.delegate = self;
        [pickView setShowsSelectionIndicator:YES];
        
        pickList = list;
        [self addSubview:pickView];
    }

    return self;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(UIView * )pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 17.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickList count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickList objectAtIndex:row];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [_apDelegate getSelectIndex:row];
}

@end
