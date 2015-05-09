//
//  MR_CommonDefines.h
//  MRCollectList
//
//  Created by 孙朋贞 on 13-8-28.
//  Copyright (c) 2013年 www.icardpay.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMR_app_key @"1001004"//接入方编号  1001002(102测试环境appkey)    1001004
#define XianHua_app_key @"1001290" //先花接入appkey

#define kMR_consume_secret_key @"8964DYByKL858c3308imytQZ" //接入方 签名密钥 正式8964DYByKL858c3308imytQZ  3des加密密钥  测试9964DYByKL967c3308imytCB 
#define XianHua_secret_key @"MvBY8MpTVCBb1tQ4cKQszrYK" //先花接入签名密钥

#define kMR_version_key @"1.0"
#define kMR_checkMobile_service_type @"icardpay.mr.pos.user.qry"//手机号查询用户信息
#define kMR_sendVerifyCode_service_type @"icardpay.mr.pos.user.verifycode.dis"//发送短信验证码
#define kMR_Register_service_type @"icardpay.mr.pos.user.reg"//用户注册
#define kMR_OrderList_service_type @"icardpay.mr.pos.order.qry"  //订单记录批量查询
#define kMR_Login_service_type @"icardpay.mr.pos.user.login"//用户登录
#define kMR_Order_service_type @"icardpay.mr.pos.order.create"//刷卡器下单
#define kMR_Qrywithdraw_money_service_type @"icardpay.mr.pos.balance.qry"//提现金额查询
#define kMR_QryWithdraw_list_service_type @"icardpay.mr.pos.settle.qry"//提现记录
#define kMR_Withdraw_service_type @"icardpay.mr.pos.settle"//用户提现
#define kMR_MdyPwd_service_type @"icardpay.mr.pos.user.mdy.pwd"//修改密码



#define kAppKey @"app_key"
#define kVersion @"version"
#define kServiceType @"service_type"
#define kMobile @"mobile"
#define kLogin_pwd @"login_pwd"
#define kSettle_pwd @"settle_pwd"
#define kReal_name @"real_name"
#define kIdcard_no @"idcard_no"
#define kCred_img_a @"cred_img_a"
#define kCred_img_b @"cred_img_b"
#define kCred_img_c @"cred_img_c"
#define kBank_id @"bank_id"
#define kCard_no @"card_no"
#define kTerminal_id @"terminal_id"
#define kLogin_pwd  @"login_pwd"
#define kOrd_amt @"ord_amt"
#define kDesc_key @"desc"
#define kRet_url @"ret_url"
#define kCallback_url @"callback_url"
#define kGps_key   @"gps"
#define kGoods_name @"goods_name"
#define kOrder_category @"order_category"
#define kReq_id @"req_id"
#define kStart_rows @"start_rows"
#define kOffset @"offset"
#define kSettle_amt @"settle_amt"  
//#define kSettle_amt @"settle_amount"
#define kPwd_type @"pwd_type"
#define kOld_pwd @"old_pwd"
#define kNew_pwd @"new_pwd"






