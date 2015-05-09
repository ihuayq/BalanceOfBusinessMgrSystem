//
//  Errcode.h
//  ZFTSwiper
//
//  Created by rjb on 13-6-17.
//  Copyright (c) 2013年 zft. All rights reserved.
//

#ifndef ZFTSwiper_Errcode_h
#define ZFTSwiper_Errcode_h

static const int SUCCESS=0;//执行成功
static const int SYSTEM_BUSY=10100;//硬件正在工作中
static const int GET_DEVICE_INFO_FAIL = 10101;// 获取设备信息失败
static const int CRC_SEND_ERROR = 10102;// CRC错误（SDK发送的数据硬件解析不匹配）
static const int CRC_RCV_ERROR =  10119;// CRC接收错误（SDK检查硬件发的消息CRC错误）
static const int COMMAND_NOT_IMPLEMENTED = 10103;// 命令未执行
static const int SECRET_KEY_IS = 10104;// 密钥已经存在
static const int PARAMETER_IS_ERROR = 10105;// 参数错误
static const int SECRET_KEY_NO = 10106;// 密钥不存在
static const int ENCRYPT_FAIL = 10107;// 加密失败
static const int NOT_SWIPE_CARD = 10108;// 未刷卡
static const int SWIPE_CARD_FAIL = 10109;// 刷卡失败
static const int NOT_OPEN_DEVICE = 10110;// 没有调用打开刷卡接口
static const int UNKNOW_ERROR = 10111;// 未知错误
static const int DEVICE_IS_OPEN = 10112;// 刷卡器已打开(已经调用03命令不可以再次调用，终端不会执行这条指令)
static const int NOT_SWIPER_LISTENER=10113;//未启动刷卡监听
static const int PARAM_ERROR_NOT_ENOUGH_LENGTH = 10114;//参数长度不够
static const int RECV_DATA_NOT_ENOUGH = 10115;  //接受数据长度不够
static const int RECV_DATA_ERROR = 10116;//将接受数据错误
static const int ERR_DEVICE_UNKOWN   = 10117; //设备没初始化
static const int ERROR_TERMINAL_TYPE_NOT_SUPPORT = 10118; //中断不支持此接口
static const int ENCRYPT_BUSY = 10119;//正在加密
static const int CARD_FAULT = 10120;//IC卡没有插好
static const int SWIPING_TIME_OUT = 10121 ;//刷卡超时
static const int UNKNOWN_DEVICE = 10122 ;//不支持设备
static const int TIME_OUT = 10123 ;//超时
static const int ANALYSIS_WRONG = 10124;//解析失败
static const int READATA_NULL = 10125;//接收到的设备数据为nil
static const int CHANGE_AUDIO = 10126;// 老音频，未收到数据，开始切换
static const int SEND_MSG_ERR    =  10130; //发送失败

#endif

