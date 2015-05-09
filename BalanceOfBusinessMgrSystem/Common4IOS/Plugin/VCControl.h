//
//  VCControl.h
//  ipaycard
//
//  Created by han bing on 13-1-28.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
        
    BegMobRech = 1001,  //手机充值
    BegAlpRech = 1002,  //支付宝卡购买 充值
    BegAlpPay = 1003,   //支付宝订单支付
    CreditPay = 1004,   //信用卡还款
    BankTransfer = 1005,    //银行卡转账
    OverSearth = 1006,  //余额查询
    WaterCharge = 1007,     //水费  
    ElecCharge = 1008,  // 网络电费 
    GasCharge = 1009, //燃气费
    HeatCharge = 1010, //取暖费  
    PhoneCharge = 1011,  //通讯费  
    IC = 1012,    //IC购电  
    MerIC = 1013,  //金融IC卡
    GIFT = 1014,  //礼品卡
    ETC = 1015,  //ETC
    GameCharge = 1016, //游戏点卡
    TrainTicket = 1017, //火车票
    AccCharge = 1018,//账户充值
    QRCode = 1019, //二维码
    
    TrdDetail = 1030,    //订单详细页  交易详情
    
    MobRechEnd = 1031,      //手机充值结束
    AlpRechEnd = 1032,      //支付包充值结束
    AlpPayEnd = 1033,        //支付宝订单支付结束
    CreditEnd = 1034,   //信用卡还款结束
    BankTransferEnd = 1035,    //银行卡转账结束
    OverEnd =   1036,   //余额查询结束
    WaterEnd = 1037, //水费结束
    ElecEnd = 1038, //电费结束
    GasEnd = 1039,  //燃气费结束
    HeatEnd = 1040, //热力费结束
    PhoneEnd = 1041,    //通讯费结束
    ICEnd = 1042,  //IC结束
    MerICEnd = 1043,  //金融IC结束
    GiftEnd =1044, //礼品卡结束
    ETCEnd =  1045, //ETC结束 CZ卡
    ETCEndJZ =  1048, //ETC结束 JZ卡
    GameEnd = 1046,  //游戏点卡结束
    WriteCard = 1047, //写卡
    MerLoadEnd = 1049,//金融IC圈存结束
    TicketEnd = 1050,//火车票结束
    AccChaEnd = 1051, //账户充值结束
    QRCodeEnd = 1052, //二维码结束
    
    TestView = 2001//Test


} viewEnum;

@interface VCControl : NSObject
+(UIViewController *) backViewController:(int) nextId;
+(UIViewController *) nextView;
@end
