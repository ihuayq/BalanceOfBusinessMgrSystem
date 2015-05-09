//
//  ExitAlert.m
//  ipaycard
//
//  Created by fei on 13-4-8.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "ExitAlert.h"

#import "LoginInNetworkHelper.h"

@implementation ExitAlert
@synthesize EADelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self != nil) {
        // 初始化自定义控件，注意摆放的位置，可以多试几次位置参数直到满意为止
        // createTextField函数用来初始化UITextField控件，在文件末尾附上
        self.firstPwd = [self createTextField:@"输入密码"
                                   withFrame:CGRectMake(32, 50, 210, 36)];
        self.firstPwd.borderStyle = UITextBorderStyleRoundedRect;
        self.firstPwd.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.firstPwd.tag = 0;
        [self addSubview:self.firstPwd];
        
        self.secondPwd = [self createTextField:@"再次输入"
                                   withFrame:CGRectMake(32, 95, 210, 36)];
        self.secondPwd.borderStyle = UITextBorderStyleRoundedRect;
        self.secondPwd.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.secondPwd.tag = 1;
        [self addSubview:self.secondPwd];

        self.temLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 138, 200, 15)];
        self.temLabel.text = @"";
        self.temLabel.font = [UIFont systemFontOfSize:15];
        self.temLabel.textColor = [UIColor whiteColor];
        self.temLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.temLabel];
        
        self.temBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.temBtn.frame = CGRectMake(155, 160, 80, 30);
        [self.temBtn setBackgroundColor:[UIColor clearColor]];
        [self.temBtn setTintColor:[UIColor brownColor]];
        [self.temBtn setTitle:@"确定" forState:UIControlStateNormal];
        self.temBtn.tag = 10;

        [self.temBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.temBtn];
        
        self.cacelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.cacelBtn.frame = CGRectMake(35, 160, 80, 30);
        [self.cacelBtn setBackgroundColor:[UIColor clearColor]];
        [self.cacelBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.cacelBtn.tag = 11;
        [self.cacelBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cacelBtn];
        
        [self.firstPwd becomeFirstResponder];
        self.firstPwd.delegate =self;
        self.secondPwd.delegate =self;
        self.delegate = self;
        userinfo  =[NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)buttonClicked : (UIButton *)sender{
    switch (sender.tag) {
        case 10:
        {
            if (self.firstPwd.text == nil||[self.firstPwd.text isEqualToString:@""]) {
                self.temLabel.text = @"请输入密码";
                return;
            }
            if (self.firstPwd.text.length<6) {
                self.temLabel.text = @"请输入6~15位密码";
                return;
            }
            if (self.secondPwd.text == nil||[self.secondPwd.text isEqualToString:@""]) {
                self.temLabel.text = @"请再次密码";
                return;
            }
            if (self.secondPwd.text.length<6) {
                self.temLabel.text = @"请再次输入6位密码";
                return;
            }
            if (![self.firstPwd.text isEqualToString:self.secondPwd.text]) {
                self.temLabel.text = @"密码不一致";
                return;
            }
            ///////////////////网络请求
            
            [LoginInNetworkHelper setPassWd:self.firstPwd.text andDelegate:self];
            
        }
            break;
        case 11:{
            [self dismissWithClickedButtonIndex:0 animated:YES];
        }
            break;
        default:
            break;
    }

    if (EADelegate) {
        if ([EADelegate respondsToSelector:@selector(alertV:clickedBtnAtIndex:)]) {
            [EADelegate alertV:self clickedBtnAtIndex:sender.tag];
        }
    }
}


- (void)cancel : (UIButton *)sender{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

// Override父类的layoutSubviews方法
- (void)layoutSubviews {
    [super layoutSubviews];     // 当override父类的方法时，要注意一下是否需要调用父类的该方法
    
    for (UIView* view in self.subviews) {
        // 搜索AlertView底部的按钮，然后将其位置下移
        // IOS5以前按钮类是UIButton, IOS5里该按钮类是UIThreePartButton
        if ([view isKindOfClass:[UIButton class]] ||
            [view isKindOfClass:NSClassFromString(@"UIThreePartButton")]) {
            CGRect btnBounds = view.frame;
            btnBounds.origin.y = self.firstPwd.frame.origin.y + self.secondPwd.frame.size.height + self.temLabel.frame.size.height+60;
            view.frame = btnBounds;
        }
    }
    // 定义AlertView的大小
    CGRect bounds = self.frame;
    bounds.size.height = 240;
    self.frame = bounds;
}


- (UITextField*)createTextField:(NSString*)placeholder withFrame:(CGRect)frame {
    UITextField* field = [[UITextField alloc] initWithFrame:frame];
    field.placeholder = placeholder;
    field.secureTextEntry = YES;
    field.backgroundColor = [UIColor whiteColor];
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return field;
}

#pragma mark textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#define NUMBERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (temp.length > 15) {
        textField.text = [temp substringToIndex:15];
        return NO;
    }
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [string isEqualToString:filtered];
    
    return canChange;
}

#pragma mark - netWork
- (void) requestDidFailed:(NSDictionary *) info{
    
}

- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    BOOL isSet = [[info objectForKey:KEY_message]isEqualToString:@"成功"];
    
    CCLog(@"isAlertSet =%@  %@",[userinfo objectForKey:KEY_Default_IsUserLogin],[info objectForKey:KEY_message]);
    if (isSet) {
        [userinfo setBool:!isSet forKey:KEY_Default_IsUserLogin];
        CCLog(@"isAlertLogin= %@",[userinfo objectForKey:KEY_Default_IsUserLogin]);
        [userinfo synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"exit" object:nil];
        [self dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    
}

-(void)exitToLogin:(NSDictionary *)info{
    CCLog(@"delegate exitToLogin");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"exit" object:nil];
}
@end

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


/*#pragma mark - alertviewDelegate
 
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
 {
 
 }
 
 - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
 {
    ///时间花费长的任务
 }
 
 */

