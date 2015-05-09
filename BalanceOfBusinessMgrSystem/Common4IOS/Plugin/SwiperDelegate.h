//
//  SwiperDelegate.h
//  ZFTSwiper
//
//  Created by JinzhuLin on 13-4-16.
//  Copyright (c) 2013年 zft. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SwiperDelegate <NSObject>

@required
- (void)onPlugin;
- (void)onPlugout;
- (void)onError:(NSInteger)errCode;

- (void)onCardNum:(NSString *)accNo;

- (void)onCardData:(NSString *)encTrack;

@end


@protocol ISwiperInterface <NSObject>
@required
- (BOOL)isPluged;

- (BOOL)open;

- (BOOL)close;

- (void)interrupt;

- (NSInteger)getDeviceInfo:(NSInteger*)Adc andDevType:(NSString**)devType anddevId:(NSString**)devId anddevtag:(NSString**)devTag;

- (NSInteger)requestSwipeCard:(NSString*)factor andADC:(NSInteger*)ADC;

- (NSInteger)SwiperCardCancel;

- (NSString*)encryptDigest:(NSString *)keyIndex andDigest:(NSString *)digest andfactor:(NSString*)factor andADC:(NSInteger*) Adc andErrorCode:(NSInteger*) errCode;

- (NSInteger)setListener:(id<SwiperDelegate> )swipeListener;

- (NSInteger)getSignInfo:(NSString*)random andADC:(NSInteger*)Adc andDevType:(NSString**) devType andDevid:(NSString**)devId andCheckcode:(NSString**)chkcode;

//- (int) getICCardStatus;

/* S 版本刷卡器 购电接口*/
/*- (NSString*) SG_GetCardType;
- (NSString*) SG_getCardSN;
- (NSString*) SG_GetUserId;
- (NSString*) SG_GetRandom;
- (NSString*) SG_GetAuthOutRandom;
- (NSString*) SG_GetAuthInRandom;
- (NSString*) SG_GetTerminalID;
- (NSString*) SG_GetCardGD;
- (NSString*) SG_GetCardFX;
- (NSInteger) SG_DoAuthOut:(NSInteger) key AuthContex:(NSString*) strAth;
- (NSString*) SG_DoAuthIn;
- (NSInteger) SG_UpdateBinary:(NSInteger)tries andData:(NSString*) data;
- (NSInteger) SG_ClearFX:(NSString*) mac;*/

/*S 版本智能卡特有购电接口*/
/*- (NSString*) SG_GetG01ClientNo;
- (NSString*) SG_GetG01CardMark;
- (NSString*) SG_GetReadG01EF:(NSInteger) index;
- (NSInteger) SG_WriteG01EF:(NSInteger) index andContex:(NSString*) Contex;
- (NSInteger) SG_G01ExternAuth:(NSInteger) key AuthData:(NSString*)data;
*/
/*S版本刷卡器 ETC 相关业务接口*/
/*
-(NSString*) Etc_GetCardNoType:(NSString*) strTermId;
-(NSInteger) Etc_VerifyPass:(NSString*)strPass;
-(NSString*) Etc_GetCardInfo;
-(NSString*) Etc_ValueCardQuery;
-(NSString*) Etc_ValueCardInitializeLoad:(NSInteger) nVal;
-(NSString*) Etc_ValueCardLoad:(NSString*)strSvrMac TimeStampTag:(NSString*) Timestamp TermTransSnTag:(NSString*)TermTransSn;
*/

/*S版本刷卡器金融IC卡业务接口*/
//金融IC卡，业务接口
/*
 V1.0.0.13修改接口
 获取金融IC卡55数据域
 gram：amount 交易金额 （以分为单位）
 transdate 交易日期（3个字节YYMMDD）
 transTime 交易时（3个字节HHMMSS）
 type
 a). P2=0x00时，圈存发卡行脚本
 b). P2=0x01时，联机查余额发卡行脚本
 c). P2=0x02时，消费交易发卡行脚本
 d).保留
 return ：交易结果  95（TVR终端验证结果） 9A（交易日期） 9F37 （随机数）82（AIP）9f36（ATC应用交易序号）9f27（CID密文信息类型）9f26（AC应用密文）  8e(CVM持卡人认证方法)  9f09（终端应用版本号）84（DF AID专用文件名称）9f41(TSC交易序列计数器) 9f10（发卡行应用数据）9f02(授权金额)
 错误时返回nil 错误信息回调onError
 */
//-(NSString *) getIcCard55DataWithAmount:(NSString *)amount Transdate :(NSString *)transdate  Type:(NSString *)type   TransTime:(NSString *)time ;
/*
 V1.0.0.13修改接口
 获取IC卡非55数据域内容，须先调用55域接口。返回数据包括2磁道信息，PAN应用主账户，应用主账号序列号
 gram：
 factor 分散因子

 return：5a(PAN)   5f34(PAN序列号)   57（2磁道信息）
 错误时返回nil 错误信息回调onError
 */
//-(NSString*) getIcCardNo55Data:(NSString *)factor;
/*-(NSInteger) doIcCardScript:(NSString*)script
 执行IC卡脚本
 gram：
 type
 a). P2=0x00时，圈存发卡行脚本
 b). P2=0x01时，联机查余额发卡行脚本
 c). P2=0x02时，消费交易发卡行脚本
 d).保留
 scripte 脚本内容
 recdata 返回内容
 return : 0 成功
          1 失败 错误信息回调onError
 
          
 */
//-(NSInteger) doIcCardScript:(NSString*)script Type:(NSString *)type RecData:(NSString **)recdata;
/* -(NSString *) getBankIcCardAmount
 获取金融IC卡得最大圈存限额
 gram： null
 
 return : 6字节数
         错误时返回nil 错误信息回调onError
 */
//-(NSString *) getBankIcCardAmount;
/*-(NSString *) getBankIcCardBalance
 获取金融IC卡电子现余额
 gram：null
 return : 6字节数
        错误时返回nil 错误信息回调onError
 */

//-(NSString *) getBankIcCardBalance;
/*-(NSString*) getBankIcCardReversalInfo
 读金融IC卡冲正信息
 gram：null
 return : 冲正信息
        错误时返回nil 错误信息回调onError
 */
//-(NSString*) getBankIcCardReversalInfo;
/*-(NSString*) clearBankIcCardReversalInfo
 清楚金融IC卡冲正信息
 gram：null
 return : 0 成功
          1 失败 错误信息回调onError
 */
//-(NSInteger) clearBankIcCardReversalInfo;

/* 检测IC是否插入
 return: 5002未插入  5003插入
 */
//-(NSInteger) SCardGetStatus;



//-(NSInteger) SCardTransmitSendbuf:(NSString *) sendbuf Recvbuf:(NSString **) recvbuf;
/*复位
 return : 复位信息
        错误时返回nil 错误信息回调onError
 */
//-(NSString *) ScardReset;
/* //V 1.0.0.11 新增接口
 切换到升级模式
 return: 0 成功
         1 失败 错误信息回调到onError
 */
//-(NSInteger ) ChangeUpgradeMode;





@end


