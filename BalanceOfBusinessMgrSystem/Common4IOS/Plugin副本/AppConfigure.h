//
//  AppConfigure.h
//  ipaycard
//
//  Created by Davidsph on 4/6/13.
//  Copyright (c) 2013 han bing. All rights reserved.
//

#ifndef ipaycard_AppConfigure_h
#define ipaycard_AppConfigure_h

#import "PublicConfigure.h"

#import "TipConfigure.h"

#import "NSString+Utf8Encoding.h"
#import "UIQuickHelp.h"
#import "DJYDebugSettingConfigure.h"

#import "BusinessAppConfigure.h"


#define Default_IsUserRegister  [[NSUserDefaults standardUserDefaults] boolForKey:KEY_IsUserRegister]
#define isIOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))

#define APP_ScreenHeight [[UIScreen mainScreen] bounds].size.height  //屏幕高度
#define APP_ScreenWidth [[UIScreen mainScreen] bounds].size.width //屏幕宽度

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

#define APP_URL @"http://itunes.apple.com/lookup?id=421101897"


/*******
 
 业务逻辑接口地址
 
 ********/


#if 0

#define BASE_URL_Business @"http://192.168.0.127/hk-frt-sys-web/"

#define BASE_Domain_Name @"http://192.168.0.62:8080/icardpay_zhangxb_127/icardpay-app/gateway.rest"

#define DefaultSecretKeyValue_Business @"T2S14r9t"

#endif

#if 0

#define BASE_URL_Business @"http://192.168.0.143/hk-frt-sys-web/"

#define DefaultSecretKeyValue_Business @"T2S14r9t"

#endif


#if 0
//UAT 环境

#define BASE_Domain_Name @"http://192.168.0.62:8080/icardpay_zhangxb/icardpay-app/gateway.rest"

#define BASE_URL_Business @"http://59.151.121.232/hk-frt-sys-web/"

#define DefaultSecretKeyValue_Business @"7VI3eVTv"

#endif

#if 0
//生产前环境

#define BASE_URL_Business @"http://192.168.0.148/hk-frt-sys-web/"//211.157.159.11

#define BASE_Domain_Name @"http://192.168.0.62:8080/icardpay_zhangxb/icardpay-app/gateway.rest"

#define DefaultSecretKeyValue_Business @"T2S14r9t"

#endif

#if 1

//生产环境
#define BASE_URL_Business  @"http://user.icardpay.com/hk-frt-sys-web/"

#define BASE_Domain_Name @"http://bao.icardpay.com/icardpay-app/gateway.rest"

#define DefaultSecretKeyValue_Business @"FsA203a3"

#endif

#define BASE_Info_Name @"http://bao.icardpay.com/mr_pos/gateway.rest"

#define GET_RIGHT_URL_WITH_Index(url) [NSString stringWithFormat:@"%@%@",BASE_URL_Business,url]

#define kUploadImageUrl @"http://bao.icardpay.com/icardpay-app/upLoad.do"

#define kJXTLoginTestUrl @"http://192.168.0.62:8080/icardpay_zhangxb_2.0/icardpay-app/gateway.rest"

#define kjxttesturl @"http://192.168.0.62:8080/icardpay_zhangxb/icardpay-app/gateway.rest"


//#define BASE_DOMAIN_URL @"http://hnaway.51you.com"
//http://192.168.0.62:8080/mr_pos_ticket/gateway.rest
//http://192.168.0.102/icardpay-app/gateway.rest  服务器
//http://bao.icardpay.com/zhangxb

#define KEY_IsUserRegister @"isRegister"

#define kJXTApp_key @"app_key"
#define kJXTVersion_key @"version"
#define kJXTService_type @"service_type"
#define kJXTSub_type @"sub_type"

#define kJXTMobile @"mobile"
#define kJXTCardNo @"card_no"
#define kJXTStart_rows @"start_rows"
#define kJXTOffset @"offset"
#define kJXTTrx_status @"trx_status"
#define kJXTCard_magnet @"card_magnet"
#define kJXT_machine_code @"machine_code"
#define kJXT_check_code @"check_code"
#define kJXT_req_id @"req_id"
#define kJXT_mer_id @"mer_id"
#define kJXT_trans_code @"trans_code"


#define kJXT_card_pwd @"card_pwd"
#define kJXT_TermTypeCode @"termTypeCode"
#define kJXT_term_type @"term_type"
#define kJXT_card_type @"card_type"

#define kJXTCardName @"card_name"
#define kJXTBankCode  @"bank_code"
#define kJXTSubBranch  @"sub_branch"
#define kJXTSettlePwd  @"settle_pwd"

#define kJXTProvince @"province"
#define kJXTCity @"city"

#define kJXT_callback_code @"callback_code"
#define kJXT_card_no @"card_no"
#define kJXT_terminal_id @"terminal_id"

#define kJXT_real_name @"real_name"

#define kJXT_termid_key  @"termid"
#define kJXT_fromstation_name  @"from_station_name"
#define kJXT_tostation_name  @"to_station_name"
#define kJXT_date  @"date"
#define kJXT_imei  @"imei"
#define kJXT_phone_info  @"phone_info"
#define kJXT_gps  @"gps"
#define kJXT_query_id  @"query_id"
#define kJXT_train_id  @"train_id"
#define kJXT_rec_list  @"rec_list"
#define kJXT_train_no  @"train_no"
#define kJXT_buyer_mobile  @"buyer_mobile"

#define kJXT_trx_amount  @"trx_amount"
#define kJXT_merchant_id  @"merchant_id"
//实时转账
#define kJXT_trans_in_card  @"trans_in_card"
#define kJXT_trans_amount  @"trans_amount"
#define kJXT_trans_in_name  @"trans_in_name"
#define kJXT_trans_fee  @"trans_fee"
#define kJXT_trans_in_mobile  @"trans_in_mobile"
#define kJXT_desc  @"desc"
#define kJXT_ord_id @"ord_id"
#define kJXT_trans_in_bank_name @"trans_in_bank_name"
//账户
#define kJXT_receiver_no @"receiver_no"
#define kJXT_receiver_name @"receiver_name"
#define kJXT_receiver_amt @"receiver_amt"
#define kJXT_pay_pwd @"pay_pwd"

#define kJXT_search_type @"search_type"
#define kJXT_mobilenum_type @"mobile_num"
#define kJXT_prodid_type @"prod_id" 

//value
#define kJXT_appkey_value @"1001001"
#define kJXT_testappkey_value @"1001001" //1001002  1001496
#define kJXT_newver_value @"2.0" 
#define kJXT_consume_sercert_key @"9864DcyyKL967c3308iuytCB"//PSCQtU2egwedbhYXTU9IrZ0O 1001496   9864DcyyKL967c3308iuytCB 
#define kJXT_testmobile @"18210227099" //13168864462  18210227099  13621331342 18911788496

//serviceType
#define kJXT_CheckOrders_service_type @"icardpay.app.jxt.order.qry"
#define kJXT_card_balance_service_type @"icardpay.app.jxt.card.balance.qry"
#define kJXT_orderPay_service_type @"icardpay.app.jxt.card.pay"
#define kJXT_sign_service_type @"icardpay.app.checkin"  //icardpay.app.checkin
#define kJXT_query_train_type @"icardpay.app.train.number.query"  
#define kJXT_query_train_price_type @"icardpay.app.train.price.query"
#define kJXT_query_train_create_order_type @"icardpay.app.train.buy.ticket"
#define kJXT_query_train_ticket_pay_type @"icardpay.app.train.pay.ticket"
#define kJXT_query_train_order_detail_type @"icardpay.app.train.order.detail"
#define kJXT_log_upload_type @"icardpay.mr.pos.log.upload"

#define kJXT_transferfee_type @"icardpay.app.transfer.fee.qry"//实时转账手续费
#define kJXT_transferord_type @"icardpay.app.transfer.ord.crt"//实时转账下单
#define kJXT_transferqry_type @"icardpay.app.transfer.ord.qry"//实时转账查询

#define kJXT_unifypay_type @"icardpay.app.unify.pay"//新支付接口

//我的账户
#define kJXT_accountcheck_type @"icardpay.app.account.check"//账号转账检测
#define kJXT_accbalance_type @"icardpay.app.account.balance.qry"//账号转账余额
#define kJXT_acctraorder_type @"icardpay.app.account.transfer.order"//账号转账下单
#define kJXT_acctrapay_type @"icardpay.app.account.transfer.pay"//账号转账支付
#define kJXT_rechergeOrder_service_type  @"icardpay.app.charge.order.create"
#define kJXT_rechergePay_service_type @"icardpay.app.charge.pay"
#define kZFT_balance_pay_type @"icardpay.app.account.pay"//虚拟账户支付
#define kJXT_cardbind_type @"icardpay.app.card.bind"
#define kJXT_cardunbind_type @"icardpay.app.card.unbind"

#define kJXT_cardbindinfo_type @"icardpay.app.cardbind.info.qry"


#define kJXT_withDraw_service_type @"icardpay.app.account.settle"

#define kJXT_mobileqry_type @"icardpay.app.mobile.new.qry"
#define kJXT_mobileord_type @"icardpay.app.mobile.new.ord.crt"

#define kJXT_activityImage_type @"icardpay.app.activity.img"


#ifdef DEBUG
//#define DEBUG 0
//#if 1

#define CCLog(format,...) NSLog(format,##__VA_ARGS__)
#define MMRelease(object) [object release]

#else

#define CCLog(format,...) NSLog(format,##__VA_ARGS__)
#define MMRelease(object) [object release],object=nil

#endif

#endif
