//
//  WebUrl.h
//  ipaycard
//
//  Created by han bing on 13-1-6.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#ifndef ipaycard_WebUrl_h
#define ipaycard_WebUrl_h

#define REQUESTTIMEOUT 15
#define REQUESTSUCESS @"00"

#define BASEURL @"http://192.168.0.127/hk-frt-sys-web/"
//#define BASEURL @"http://user.icardpay.com/hk-frt-sys-web/"
//#define BASEURL @"http://192.168.0.102/icardpay-app/gateway.rest?"

//手机是否注册
#define ISREGISTER @"F10001.front?"
//登陆接口
#define USERLOGINURL @"F10005.front?"
//token 提交接口
#define USERTOKEN @"F10051.front?"
//手机充值
#define MOBILERECHARGESEARCH @"F10010.front?"
#define MOBILERECHARGECOMMIT @"F10011.front?"
//支付宝订单支付
#define ALIPAYPAYSEARCH @"F10015.front?"
#define ALIPAYPAYCOMMIT @"F10016.front?"
//支付宝充值
#define ALIPAYRECHARGESEARCH @"F10012.front?"
#define ALIPAYRECHARGECOMMIT @"F10013.front?"
//刷卡支付提交
#define PAYFORTRADE @"F10014.front?"
//刷卡器签到
#define CARDBOXREGISTER @"F10017.front?"
//交易历史查询
#define TRADESEARCH @"F10055.front?"
//交易详情--手机充值
#define TRADEDETAILMOBILE @"F10065.front?"
//交易详情--支付宝充值，订单支付
#define TRADEDETAILALIPAY @"F10066.front?"

//推送信息
#define PUSHMSG @"F10066.front?"

//手机充值详情
#define TRADEMOBILEDETAIL @"F10065.front?"
#endif
