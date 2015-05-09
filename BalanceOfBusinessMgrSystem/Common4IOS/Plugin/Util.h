//
//  Util.h
//  ipaycard
//
//  Created by han bing on 13-1-3.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "WebUrl.h"

#import "MobClick.h"
#import "JSONKit.h"

#import "NSString+HexToData.h"

@interface Util : NSObject

typedef enum{
    COMCM,//中国移动
    COMCU,//中国联通
    COMCT,//中国电信
    OTHENCOM//其他
} comType;

typedef enum{
    CMHO,//招商银行 招行
    BOBJ,//北京银行 北京
    CCB, //建设银行 建设
    BCM, //交通银行 交通
    BOC, //中国银行 中国1
    ABC, //农业银行 农业
    CEB, //光大银行 光大
    SPDB,//浦发银行 浦发
    CGB, //广发银行 广发
    CTIB,//中信银行 中信
    CMBC,//民生银行 民生
    SDB, //深圳发展银行 深发
    PGBC,//平安银行 平安
    HXB, //华夏银行 华夏
    IBCN,//兴业银行 兴业
    BKSH,//上海银行 上海
    NBCB,//宁波银行 宁波
    NJCB,//南京银行 南京
    JSBK,//江苏银行 江苏
    DLCB,//大连银行 大连
    DEAT,//东亚银行 东亚
    TZB, //台州市商业银行 台州
    BSB, //内蒙古包商银行 包商
    TLCB,//浙江泰隆银行 泰隆
    ICBC,//工商银行 工行
    OTHERBANK//其他
    
} bankType;

+ (int)getType : (NSString *)mobile;

+ (NSString *)getLocalToken;

+ (void)updateLocalToken:(NSString *)token;

+(NSString *) getDcoumentPath;

+(NSString *) getCachePath;

+(NSString *) transformDictToString:(NSMutableDictionary *) dataDict;

+(NSString *) joinParameterToUrl:(NSString *) businessUrl tradePara:(NSMutableDictionary *) tradeParam;

+ (NSString *)encodeMD5_32:(NSString *)sourceString;

+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

+(NSString *) stringToSha1:(NSString *) oriStr;

+(void) showMsg:(NSString *)Msg;

+(void) showTitle:(NSString *)title Msg:(NSString *)message;

+(NSString*) getDayString;

+(BOOL) isMoblieNumber:(NSString *) mobileNo;

+(BOOL) isMoney:(NSString *)money;

/*
 身份证完全校验 */
+ (BOOL)validateIDCardNumber:(NSString *)value;

+(BOOL) isIdNum:(NSString *)idNum;

+(BOOL) isChinese:(NSString *)str;
//火车票的开车时间加空格处理
+ (NSString *)transformTrainStartTime:(NSString *)startTime;
//把本地填写的金额乘以100，转换为分为单位
+(NSString*) transfromSendMoney:(NSString*) money;

//把接口下载的金额除以100，转换为元为单位
+(NSString*) transfromReceiveMoney:(NSString*) money;

//读取本地show。plist文件中内容
+(NSString *) getValueFromPlist:(NSString *) key;

+(NSString *) getValueFromHomePlist:(NSString *) key;

//写入本地show.plist文件内容
+(void) writeValueToPlist:(NSString *)key value:(NSString *) value;

+(NSString *) intToHex:(int) intVal;

+(NSString *) intToHexSmall:(int)intVal;

+(int) stringToInt:(NSString *) strVal;

+ (NSString *)stringFromHexString:(NSString *)hexString;

+(NSString*) getSoftVersion;

+ (UIImage *)mobileCom : (int )type;//更改手机运营图片

+ (UIImage *)bankCom : (NSString *)type; //更改银行图片

+ (NSString *)dotMoney:(NSString*) money;

+ (NSString *)appendYuan:(NSString *)string;

+ (NSString *)transDataWithPi:(NSString *)string;

+ (NSString *)transDataWithOri:(NSString *)string;

+ (NSString *)transDataWithNone:(NSString *)string;

//MMddHHmmss转化为类似2013-07-20 22:06:39
+ (NSString *)transDataToSepicalLongDate:(NSString *)oriStr;

+ (NSString *)transData:(NSString *)string;

+ (NSString *)transDataLong:(NSString *)string;

+ (NSString *)transDataShort:(NSString *)string;
+ (NSString *)transShortDateToSepicalDate:(NSString *)string;
+ (NSString *)transLengthEightToShort:(NSString *)string;
+ (NSString *)transLengthEightToYYYYMMddDate:(NSString *)string;

+ (NSString *)transShortDateToYYMMDatestr:(NSString *)string;

/*
 *将2013-12-24 14:26:46日期转换成交易详情中指定格式2013.12.24 14:26
 */
+ (NSString *)transLongDateToDetailFormat:(NSString *)string;
/*
 *将2013-12-24日期转换成交易详情中指定格式2013.12.24
 */
+ (NSString *)transShortDateToDetailFormat:(NSString *)string;


+ (NSString *)transDotShort:(NSString *)string;


+(NSString *)errorMsg:(NSString *)cpscod;

+(NSString *)chargeAmount:(int)dealCharge;

+(NSString *)changeToInt:(NSString *)num;//16转10进制

+(NSString *)changeToHet:(int)num;//10转16进制

+(void)alertHelp:(NSString *)temstr;


+(NSString *)getTLVwithTag:(NSString *)tag andStr:(NSString *)string andLengh:(NSInteger )temLen;
//获取tlv字符串

+(NSString *)getCardSd:(NSString *)temStr;
// 获取卡磁道号
//获取时间
+ (NSString *)getCurrentTime:(int)data;

+(NSString *)getLVwithTag:(NSString *)tag andStr:(NSString *)string andLengh:(NSInteger )temLen;

+(NSString *)getTLVfromByte:(NSString *)tlvString andTag:(NSString *)tag;
//是否升级固件
+ (BOOL)needUpgradeFirmware:(NSString *)type withDevice:(NSString *)deviceId;

+ (NSString *)getAlichargeCardno:(NSString *)cardMsgStr;

+ (NSString *)getBussString:(NSString *)busType; //获取业务名称

+ (NSString *)getBussType:(NSString *)busString;//获取图片名称

+ (NSString *)getTrainSeatType:(NSString *)trainTag;//获取火车票类型
/*
 获取火车票座位类型  二等座 */
+ (NSString *)getTrainTag:(NSString *)trainSeatType;
/*
 获取证件类型  证件类型Tag */
+ (NSString *)getCardTag:(NSString *)cardType;
/*
 获取火车票类型  成人 儿童 */
+ (NSString *)getTicketType:(NSString *)ticketTag;
/*
获取火车票类型Tag  成人 儿童 */
+ (NSString *)getTicketTag:(NSString *)ticketType;
/*
判断日期在范围内 */
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
/*
 yyyy-MM-dd NSDate转为NSString
 */
+ (NSString *)getStringFromDate:(NSDate *)temDate;
/*
yyyy-MM-dd NSString转为NSDate
 */
+ (NSDate *)getDateFromString:(NSString *)temStr;
/*
 获取前一天 后一天
 */
+ (NSDate *)getNextOrPreDateFromString:(NSString *)temStr andInt: (int)nextOrPre;
/*
 解析火车座位信息
 */
+ (NSArray *)getTrainSeatTypeArray:(NSString *)seatTypeStr;
/*
 根据rspcod返回错误信息
 */
+ (NSString *)getRspMsg:(NSString *)rspcod;
/*
 是否转义rspcod
 */
+ (BOOL )isTransRspCod:(NSString *)rspcod;


+ (NSString *)getVersionInteger;// 只传1.0 2.0 两种
+(UIImage*) getImageByString:(NSString *)string;//显示图片

/* 获取当前时间*/
+ (NSDate *)getNowDate;

+ (BOOL)getRspCode:(NSDictionary *)dict;

+ (NSDictionary *)dictionaryFromString:(NSString *)str;

@end
