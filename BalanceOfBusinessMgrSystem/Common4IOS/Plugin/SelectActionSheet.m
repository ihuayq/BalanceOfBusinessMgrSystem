//
//  SelectActionSheet.m
//  ipaycard
//
//  Created by han on 13-1-4.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "SelectActionSheet.h"

@implementation SelectActionSheet

@synthesize pickList;

-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title pickList:(NSArray *) list;
{
    self = [super init];
    if (self) {
      int theight = height - 40;
      int btnnum = theight/50;
      for(int i=0; i<btnnum; i++)
      {
        [self addButtonWithTitle:@" "];
      }
      toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
      toolBar.barStyle = UIBarStyleBlackOpaque;
      
      NSDictionary* textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor],UITextAttributeTextColor,
                                        nil];
      UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:title style: UIBarButtonItemStylePlain target: nil action: nil];
      [titleButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
      UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style: UIBarButtonItemStyleDone target: self action: @selector(done)];

      UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: UIBarButtonItemStyleBordered target: self action: @selector(docancel)];
      UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
      NSArray *array = [[NSArray alloc] initWithObjects: leftButton,fixedButton, titleButton,fixedButton, rightButton, nil];
      [toolBar setItems: array];
      
      picker = [[SelectPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, height) pickerList:list];
      picker.apDelegate = self;
      picker.backgroundColor = [UIColor groupTableViewBackgroundColor];
      [self addSubview:picker];
      
      [self addSubview:toolBar];
    }
    return self;
}

-(void)done
{
    [_asDelegate backSelectInt:pickSelectedIndex];
	[self dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)docancel
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void) getSelectIndex:(int)selectedIndex{
    pickSelectedIndex = selectedIndex;

}

@end
