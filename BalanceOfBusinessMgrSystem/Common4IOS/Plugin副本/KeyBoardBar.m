//
//  KeyBoardBar.m
//  QucikPayment
//
//  Created by han bing on 12-9-11.
//
//

#import "KeyBoardBar.h"
#define KEYBOARD_HEIGHT 216
#define KEYBOARD__IOS5_HEIGHT 252   //chinese input mode under ios5

@implementation KeyBoardBar
@synthesize currentTextField;
@synthesize textFields;
@synthesize inputMode;
@synthesize view;

- (id)init
{
    if((self = [super init]))
    {
        prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleBordered target:self action:@selector(showPrevious)];
        nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleBordered target:self action:@selector(showNext)];
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(hiddenKeyBoard)];
        spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,480,MainWidth,36)];
        view.barStyle = UIBarStyleBlackTranslucent;
        view.items = [NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil];

    }
    return self;
}

//显示上一项
-(void)showPrevious{
    if (textFields==nil) {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[textFields count]; i++) {
        if ([textFields objectAtIndex:i]==currentTextField) {
            num = i;
            break;
        }
    }
    if (num>0){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num-1 ] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num-1]];
    }
}

//显示下一项
-(void)showNext{
    if (textFields==nil) {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[textFields count]; i++) {
        if ([textFields objectAtIndex:i]==currentTextField) {
            num = i;
            break;
        }
    }
    if (num<[textFields count]-1){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num+1] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num+1]];
    }
}

//隐藏键盘和工具条
-(void)hiddenKeyBoard{
    if (currentTextField!=nil) {
        [currentTextField  resignFirstResponder];
    }
}

//显示工具条
-(void)showBar:(UITextField *)textField{
    currentTextField = textField;

    if (textFields==nil) {
        prevButtonItem.enabled = NO;
        nextButtonItem.enabled = NO;
    }
    else {
        NSInteger num = -1;
        for (NSInteger i=0; i<[textFields count]; i++) {
            if ([textFields objectAtIndex:i]==currentTextField) {
                num = i;
                break;
            }
        }
        if (num>0) {
            prevButtonItem.enabled = YES;
        }
        else {
            prevButtonItem.enabled = NO;
        }
        if (num<[textFields count]-1) {
            nextButtonItem.enabled = YES;
        }
        else {
            nextButtonItem.enabled = NO;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
