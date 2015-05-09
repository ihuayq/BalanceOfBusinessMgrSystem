//
//  UIQuickHelp.h
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

//这是一个工具类 可以快速设置特定UI
@interface UIQuickHelp : NSObject


//以指定半径 为一个view设置圆角效果
+ (void)setRoundCornerForView:(UIView*)view
                   withRadius:(CGFloat)radius;
//填充view的边框颜色
+ (void)setBorderForView:(UIView*)view
               withWidth:(CGFloat)width
               withColor:(UIColor*)color;

+(void) showAlertViewWithTitle:(NSString *) title message:(NSString *) message delegate:(id) delgate  cancelButtonTitle:(NSString *) cancel otherButtonTitles:(NSString *) ok;




+ (void) showAlertViewWithMessage:(NSString *) message;


//+ (UIButton *)buttonWithType:(NSUInteger)type
//					   title:(NSString *)title
//					   frame:(CGRect)frame
//				   imageName:(NSString *)imageName
//			 tappedImageName:(NSString *)tappedImageName
//					  target:(id)target
//					  action:(SEL)selector
//						 tag:(NSInteger)tag;





+ (void) setTableViewCellBackGroundColorAndHighLighted:(UITableViewCell *) cell;

+ (void) setTableViewCellBackGroundColorAndHighLighted:(UITableViewCell *)cell type:(int ) type;

//验证手机号 
+ (BOOL) isRightMobile:(NSString *) mobile;


+ (NSString *) get9BytesRandNum;


+ (NSString *) get16BytesStringWithPhoneId:(NSString *) phoneId ;


//获取银行卡密码待加密的信息
+ (NSString *) getEncryptBankCardPassWord:(NSString *)passStr;


//pwd 为明文密码 封装后 返回的是待加密的密码
+ (NSString *) getPassWdTmp:(NSString *) passStr;


/*******
 
 请求参数
 
 cardSd 银行卡磁道信息
 
 passwd 已加密过的银行卡密码
 
 返回值  拼接之后的待加密的字符串
 
 
 
 ********/


+ (NSString *) getcheckCodeNumWithCardSd:(NSString *)cardSd encryptedPwd:(NSString *) passwd;



@end
