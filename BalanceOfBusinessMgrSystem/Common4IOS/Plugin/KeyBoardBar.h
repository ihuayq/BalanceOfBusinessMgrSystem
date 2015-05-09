//
//  KeyBoardBar.h
//  QucikPayment
//
//  Created by han bing on 12-9-11.
//
//

#import <UIKit/UIKit.h>

@interface KeyBoardBar : NSObject{
    UIToolbar       *view;                       //工具条
    NSArray         *textFields;                 //输入框数组
    UIBarButtonItem *prevButtonItem;             //上一项按钮
    UIBarButtonItem *nextButtonItem;             //下一项按钮
    UIBarButtonItem *spaceButtonItem;            //空白按钮
    UIBarButtonItem *hiddenButtonItem;           //隐藏按钮
    UITextField     *currentTextField;           //当前输入框
    
    NSString *inputMode;        //键盘输入类型
}

@property (nonatomic, retain) NSArray *textFields;
@property (nonatomic, retain) NSString *inputMode;
@property(nonatomic,retain) UIToolbar *view;
@property(nonatomic,retain) UITextField *currentTextField;

-(void)showBar:(UITextField *)textField;
-(void)hiddenKeyBoard;
@end
