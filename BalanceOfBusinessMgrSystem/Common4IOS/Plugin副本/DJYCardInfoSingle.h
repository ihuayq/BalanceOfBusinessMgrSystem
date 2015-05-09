//
//  DJYCardInfoSingle.h
//  ipaycard
//
//  Created by Davidsph on 5/13/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJYCardInfoSingle : NSObject

@property(nonatomic,retain)NSString *yu_23;  //卡序列号

@property(nonatomic,retain)NSString *cardType; //磁卡类型

@property(nonatomic,retain)NSString *inAuth; //内部认证

@property(nonatomic,retain)NSString *outAuth; //外部认证

@property(nonatomic,retain)NSString *purAr; //购电区

@property(nonatomic,retain)NSString *backAr; //反写区

@property(nonatomic,retain)NSString *userNo;//IC卡用户编号

@property(nonatomic,retain)NSString *cardNum; //银行卡号

@property(nonatomic,retain)NSString *cardPwd; //银行密码

@property(nonatomic,retain)NSString *cardSd; //银行卡2，3磁道号信息  已加密

@property(nonatomic,retain)NSString *randrom; //随机数

@property(nonatomic,retain)NSString *inRandrom; //随机数

@property(nonatomic,retain)NSString *outRandrom; //随机数

@property(nonatomic,retain)NSString *signRandrom; //签到随机数

@property(nonatomic,retain)NSString *fenSanYinZi; //分散因子 签到成功后服务器返回

@property(nonatomic,retain)NSString *deviceId; //设备Id

@property(nonatomic,retain)NSString *elecSignData; //电子标志符

@property(nonatomic,retain)NSString *deviceType; //设备类型

@property(nonatomic,retain)NSString *checkCodeForRegister; //签到用的checkCode

@property(nonatomic,retain)NSString *checkCodeForPay; //支付用 摘要的密文

//PBOC
@property(nonatomic,retain)NSDictionary *temDic; //圈存传信息

@property(nonatomic,retain)NSString *leftAmt; //电子钱包余额

@property(nonatomic,retain)NSString *limitAmt; //最大圈存限额

@property(nonatomic,retain)NSString *bankType; //最大圈存限额

@property(nonatomic,retain)NSString *bankName; //最大圈存限额

@property(nonatomic,retain)NSString *icData; //上行数据域

@property(nonatomic,retain)NSString *psw; 

@property(nonatomic,retain)NSString *queryAmt; //圈存金额

/*******
 
刷卡器的一些状态 
 
 ********/

@property(nonatomic,assign)BOOL isPlugin; //设备是否插入

@property(nonatomic,assign)BOOL isRegistered; //设备是否签到

+ (DJYCardInfoSingle *) newCardInfoInstance;

- (void) initCardInfoSingle;

@end
