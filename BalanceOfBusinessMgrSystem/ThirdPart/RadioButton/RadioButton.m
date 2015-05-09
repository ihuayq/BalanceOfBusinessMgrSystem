    //
//  RadioButton.m
//  MovieInfo
//
//  Created by sunlg on 10-12-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioButton.h"


@implementation RadioButton

@synthesize isChecked;

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame typeCheck:(BOOL)type_check{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
		//self.frame =frame;
		self.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
		self.isChecked =type_check;
		if (type_check) {
			[self setImage:[UIImage imageNamed:@"RadioButton_check.png"] forState:UIControlStateNormal];
		}else {
			[self setImage:[UIImage imageNamed:@"RadioButton_Not_check.png"] forState:UIControlStateNormal];
		}

		
		[self addTarget:self action:@selector(checkBoxClicked) forControlEvents:UIControlEventTouchUpInside];
	}
    return self;
}

-(IBAction) checkBoxClicked{
	if(self.isChecked ==NO){
		self.isChecked =YES;
		[self setImage:[UIImage imageNamed:@"RadioButton_check.png"] forState:UIControlStateNormal];
		
	}else{
		self.isChecked =NO;
		[self setImage:[UIImage imageNamed:@"RadioButton_Not_check.png"] forState:UIControlStateNormal];
		
	}
	[self resultReponse:isChecked buttonTag:self.tag];
	
}
- (void)resultReponse:(BOOL)boolchange buttonTag:(NSInteger)BTag{
	if (delegate) {
		[delegate radioButtonChange:self didSelect:boolchange didSelectButtonTag:BTag];
	}
	
}


@end
