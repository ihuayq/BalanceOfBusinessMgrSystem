//
//  RegisterViewController.h
//  jxtuan
//
//  Created by fengxiaoguang on 13-7-22.
//  Copyright (c) 2013年 aaa. All rights reserved.
//


//注册参数
#define TELENUMBER_REGISTER @"telenumber_zhuce"
#define MIMA_REGISTER @"zhuce_mima"
#define NAME_REGISTER @"zhuce_name"
#define SHENFENZHENGHAO_REGISTER @"shenfenzhenghao_zhuce"
#define MERCHANTNAME_REGISTER @"merchantname_zhuce"//商户名称

#define PROVINCE_REGISTER @"province_zhuce"
#define CITY_REGISTER @"city_zhuce"
#define AREA_REGISTER @"area_zhuce"
#define ADDRESS_DETAILED_REGISTER @"address_detailed_zhuce"
#define SHENFENZHENG_PIC1_REGISTER @"shenfenzhengtupian1_zhuce"
#define SHENFENZHENG_PIC2_REGISTER @"shenfenzhengtupian2_zhuce"
#define SHENFENZHENG_PIC3_REGISTER @"shenfenzhengtupian3_zhuce"
#define SHENFENZHENG_PIC1_ID_REGISTER @"1"
#define SHENFENZHENG_PIC2_ID_REGISTER @"2"
#define SHENFENZHENG_PIC3_ID_REGISTER @"3"

#define SHENFENZHENG_PIC1_URL_REGISTER @"shenfenzhengtupian1_url_zhuce"
#define SHENFENZHENG_PIC2_URL_REGISTER @"shenfenzhengtupian2_url_zhuce"
#define SHENFENZHENG_PIC3_URL_REGISTER @"shenfenzhengtupian3_url_zhuce"

#define BANK_NAME_ID_REGISTER @"bank_name_id_zhuce"
#define BANK_CARD_ID_REGISTER @"bank_card_id_zhuce"
#define BANK_CARD_MONEY_MIMA_REGISTER @"bank_card_money_mima_zhuce"
#define DEVICE_ID_SHUAKAQI_REGISTER @"device_id_shuakaqi_zhuce"


#import "HP_BaseViewController.h"
#import "HP_Common4IOS.h"
#import "ControllerConfig.h"


@interface RegisterViewController : HP_BaseViewController<UITextFieldDelegate>
{
    
    UIView *bgView;
    
    HP_UITextField * telTextField;
    HP_UITextField * passwordTextField;
    HP_UITextField * passCodeTextField;
    HP_UITextField * inviteCodeTextField;
    
    UIButton *sendCheckCodeButton;
    UILabel * sendCheckCodeLabel;
    int jishuqi;
    NSTimer* timer;
    NSString* returnCodeSTring;//服务器返回
    
    UIButton *selectButton;
    BOOL isSelectAgreement;
    
    BOOL isRegistering;
    
}
@end
