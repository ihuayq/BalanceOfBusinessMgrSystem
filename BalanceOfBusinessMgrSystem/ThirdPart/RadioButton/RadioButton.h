//
//  RadioButton.h
//  MovieInfo
//
//  Created by sunlg on 10-12-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol RadioButtonDelegate;



@interface RadioButton : UIButton {
	BOOL isChecked;
	// Delegate
	//id<RadioButtonDelegate> delegate;
}
@property (nonatomic,assign) BOOL isChecked;

@property (nonatomic,assign) id<RadioButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame typeCheck:(BOOL)type_check;
-(IBAction) checkBoxClicked;
- (void)resultReponse:(BOOL)boolchange buttonTag:(NSInteger)BTag;
@end


@protocol RadioButtonDelegate
- (void)radioButtonChange:(RadioButton *)radiobutton didSelect:(BOOL)boolchange didSelectButtonTag:(NSInteger )tagselect;
@end