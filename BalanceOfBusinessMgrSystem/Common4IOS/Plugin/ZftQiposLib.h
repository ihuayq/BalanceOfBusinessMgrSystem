//
//  ZftQiposLib.h
//  ZftQiposLib
//
//  Created by rjb on 13-8-1.
//  Copyright (c) 2013年 rjb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "Errcode.h"
//#import "CSwiperController.h"


//static const int SUCCESS=0;//执行成功
//static const int SYSTEM_BUSY=10100;//硬件正在工作中
//static const int GET_DEVICE_INFO_FAIL = 10101;// 获取设备信息失败
//static const int CRC_SEND_ERROR = 10102;// CRC错误（SDK发送的数据硬件解析不匹配）
//static const int CRC_RCV_ERROR =  10119;// CRC接收错误（SDK检查硬件发的消息CRC错误）
//static const int COMMAND_NOT_IMPLEMENTED = 10103;// 命令未执行
//static const int SECRET_KEY_IS = 10104;// 密钥已经存在
//static const int PARAMETER_IS_ERROR = 10105;// 参数错误
//static const int SECRET_KEY_NO = 10106;// 密钥不存在
//static const int ENCRYPT_FAIL = 10107;// 加密失败
//static const int NOT_SWIPE_CARD = 10108;// 未刷卡
//static const int SWIPE_CARD_FAIL = 10109;// 刷卡失败
//static const int NOT_OPEN_DEVICE = 10110;// 没有调用打开刷卡接口
//static const int UNKNOW_ERROR = 10111;// 未知错误
//static const int DEVICE_IS_OPEN = 10112;// 刷卡器已打开(已经调用03命令不可以再次调用，终端不会执行这条指令)
//static const int NOT_SWIPER_LISTENER=10113;//未启动刷卡监听
//static const int PARAM_ERROR_NOT_ENOUGH_LENGTH = 10114;//参数长度不够
//static const int RECV_DATA_NOT_ENOUGH = 10115;  //接受数据长度不够
//static const int RECV_DATA_ERROR = 10116;//将接受数据错误
//static const int ERR_DEVICE_UNKOWN   = 10117; //设备没初始化
//static const int ERROR_TERMINAL_TYPE_NOT_SUPPORT = 10118; //中断不支持此接口
//static const int ENCRYPT_BUSY = 10119;//正在加密
//static const int CARD_FAULT = 10120;//IC卡没有插好
//static const int SWIPING_TIME_OUT = 10121 ;//刷卡超时
@class CSwiperController;

@protocol SwiperDelegate <NSObject>

@required
- (void)onPlugin;
- (void)onPlugout;
- (void)onError:(NSInteger)errCode;
- (void)onCardNum:(NSString *)accNo;
- (void)onCardData:(NSString *)encTrack;
- (void)OnDeviceInfo:(NSInteger)Adc andDevType:(NSString*)devType anddevId:(NSString*)devId anddevtag:(NSString*)devTag;
- (void)onCheckKey:(NSInteger)code;
- (void)onChangeUpgradeMode:(NSInteger)code;
- (void)onGetPINBlock:(NSString*)PIN_Block;
- (void)onGetMAC:(NSString*)mac;
- (void)onDeviceAdc:(NSInteger)Adc;
- (void)OnSingInfo:(NSInteger)Adc andDevType:(NSString*)devType anddevId:(NSString*)devId andCheckCode:(NSString*)checkCode;
- (void)onGetEncryPWDAndAdc:(NSString *)pwd andAdc:(NSInteger)adc andEncryptDigest:(NSString *)type andErrorCode:(NSInteger)errorCode;
- (void)onGET55CARDDATA:(NSString *)data;
- (void)onGETNO55Message:(NSString *)cardNum andCRDSQN:(NSString *)sqn andencTrack:(NSString *)encTrack;
/**
 *  获得IC卡插入后的回调
 *
 *  @param status YES表示IC卡已插入设备
 */
- (void)onGetSCardStatus:(BOOL)status;

/**
 *  获得IC卡卡号的回调
 *
 *  @param cardNum IC卡卡号
 */
- (void)onICCard:(NSString *)ICcardNum;

@end


@class ZFTSwiper;
@interface ZftQiposLib : NSObject
+(ZftQiposLib *)getInstance;

/*检测是否插入刷卡器*/
-(BOOL)isPluged;

/*设置代理*/
-(NSInteger) setListener:(id<SwiperDelegate>)swipeListener;

- (int)getFlag;

- (BOOL)open;

- (BOOL)close;

- (void)interrupt;

- (NSInteger)getDeviceInfo;

- (NSInteger)getSignInfo:(NSString*)random;

- (NSString*)encryptDigest:(NSString *)keyIndex andDigest:(NSString *)digest andfactor:(NSString*)factor;

- (NSInteger)requestSwipeCard:(NSString*)factor;

- (NSInteger)SwiperCardCancel;

- (NSInteger)Change_Key:(NSString*)key;

- (NSInteger)GetPinBlock:(NSString*)pin;

- (NSInteger)GetMAC:(NSString*)mac;

+ (NSString *)getSDKVersion;

+ (NSString*)hexStringFromData:(NSData*)data;

+ (NSData *)dataFromHexString:(NSString*)hexString;

+ (NSString*)encryptDataString:(NSString*)indata withKey:(NSString*)key;

+ (NSString*)decryptDataString:(NSString*)indata withKey:(NSString*)key;
- (int) getICCardStatus;

/* S 版本刷卡器 购电接口*/
- (NSString*) SG_GetCardType;
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
- (NSInteger) SG_ClearFX:(NSString*) mac;

/*S 版本智能卡特有购电接口*/
- (NSString*) SG_GetG01ClientNo;
- (NSString*) SG_GetG01CardMark;
- (NSString*) SG_GetReadG01EF:(NSInteger) index;
- (NSInteger) SG_WriteG01EF:(NSInteger) index andContex:(NSString*) Contex;
- (NSInteger) SG_G01ExternAuth:(NSInteger) key AuthData:(NSString*)data;

/*S版本刷卡器 ETC 相关业务接口*/
-(NSString*) Etc_GetCardNoType:(NSString*) strTermId;
-(NSInteger) Etc_VerifyPass:(NSString*)strPass;
-(NSString*) Etc_GetCardInfo;
-(NSString*) Etc_ValueCardQuery;
-(NSString*) Etc_ValueCardInitializeLoad:(NSInteger) nVal;
-(NSString*) Etc_ValueCardLoad:(NSString*)strSvrMac TimeStampTag:(NSString*) Timestamp TermTransSnTag:(NSString*)TermTransSn;


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
-(NSString *) getIcCard55DataWithAmount:(NSString *)amount Transdate :(NSString *)transdate  Type:(NSString *)type   TransTime:(NSString *)time ;
/*
 V1.0.0.13修改接口
 获取IC卡非55数据域内容，须先调用55域接口。返回数据包括2磁道信息，PAN应用主账户，应用主账号序列号
 gram：
 factor 分散因子
 
 return：5a(PAN)   5f34(PAN序列号)   57（2磁道信息）
 错误时返回nil 错误信息回调onError
 */
-(NSString*) getIcCardNo55Data:(NSString *)factor;
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
-(NSInteger) doIcCardScript:(NSString*)script Type:(NSString *)type RecData:(NSString **)recdata;
/* -(NSString *) getBankIcCardAmount
 获取金融IC卡得最大圈存限额
 gram： null
 
 return : 6字节数
 错误时返回nil 错误信息回调onError
 */
-(NSString *) getBankIcCardAmount;
/*-(NSString *) getBankIcCardBalance
 获取金融IC卡电子现余额
 gram：null
 return : 6字节数
 错误时返回nil 错误信息回调onError
 */

-(NSString *) getBankIcCardBalance;
/*-(NSString*) getBankIcCardReversalInfo
 读金融IC卡冲正信息
 gram：null
 return : 冲正信息
 错误时返回nil 错误信息回调onError
 */
-(NSString*) getBankIcCardReversalInfo;
/*-(NSString*) clearBankIcCardReversalInfo
 清楚金融IC卡冲正信息
 gram：null
 return : 0 成功
 1 失败 错误信息回调onError
 */
-(NSInteger) clearBankIcCardReversalInfo;

/* 检测IC是否插入
 return: 5002未插入  5003插入
 */
-(NSInteger) SCardGetStatus;



-(NSInteger) SCardTransmitSendbuf:(NSString *) sendbuf Recvbuf:(NSString **) recvbuf;
/*复位
 return : 复位信息
 错误时返回nil 错误信息回调onError
 */
-(NSString *) ScardReset;
/* //V 1.0.0.11 新增接口
 切换到升级模式
 return: 0 成功
 1 失败 错误信息回调到onError
 */
-(NSInteger ) ChangeUpgradeMode;


@end
