//
//  APIConfig.h
//  jxtuan
//
//  Created by 融通互动 on 13-8-19.
//  Copyright (c) 2013年 aaa. All rights reserved.
//



#ifdef ZHENGSHI

#define HostURL @"http://app.imzhongxin.com/interfaces.php?app=ios&v=103&op=" //正式服务器
#define ShareURL_ZX @"http://app.imzhongxin.com/trust/projectintro.php?"//分享
#define HelpCenterURL_ZX @"http://app.imzhongxin.com/trust/apphelp.php?action="//帮助中心

#else


//#define TEST_LOGIN
//#define UAT
//#define WORK


//自然人
#ifdef UAT

#ifdef WORK
#define IP @"http://59.151.121.91:8080/"
#else
#define IP @"http://59.151.121.87:8081/"
#endif

#else
#define IP @"http://192.168.1.105:8080/"
#endif

//#define HostURL @"superMoney-core/nature/loginIn?" //测试服务器

#define HostURL @"superMoney-core/appInterface/userLogin?" //测试服务器

#define MInfoURL @"superMoney-core/appInterface/getCommercialInfo?"

#define MessageCodeURL @"superMoney-core/appInterface/sendPhoneVerification?"// 获取验证码

#define settingNatureMenURL @"superMoney-core/appInterface/assignNatural?" //添加自然人

#define AccountURL @"superMoney-core/appInterface/getCommercialWebsiteInfo?"

#define SavaAccountURL @"superMoney-core/appInterface/saveAccountWebsite?"

#define DrawCashURL @"superMoney-core/nature/saveInfo?"//沉淀
#define PayPasswdURL @"superMoney-core/nature/setPayPass?"// 第一次设置交易密码时候使用
#define SetLoginPasswdURL @"superMoney-core/nature/updateLoginPass?"// 创建登录密码,第一次登录时候用
#define ModifyLoginPasswdURL @"superMoney-core/nature/changeLoginPass?"   //改变登录密码
#define ModifyPayPasswdURL @"superMoney-core/nature/changePayPass?"   //改变登录密码
#define ForgetLoginPasswdURL @"superMoney-core/nature/forgetPass?"
#define QueryMainAssetURL @"superMoney-core/nature/queryBlanceInfo?"
#define WithDrawURL @"superMoney-core/nature/withdraw?"// 提现
#define AssetInfoUrl @"superMoney-core/nature/queryDetail?" //资产变动信息查询
#define loginOutUrl @"superMoney-core/nature/loginOut?" //资产变动信息查询

//loginOut
//String phoneNum = request.getParameter("phoneNum");
//String deviceID = request.getParameter("deviceId"); // 手机DeviceID

//商户登录
#ifdef UAT

#ifdef WORK
#define CommercialIP @"http://59.151.121.91:8080"
#else
#define CommercialIP @"http://59.151.121.87:8081"
#endif

#else
#define CommercialIP @"http://192.168.0.56:8080"
//#define CommercialIP @"http://192.168.1.110:8080"
#endif

#define CommercialHostURL @"/superMoney-core/commercia/commerCiainfo?"


#define passCodeURL @"/superMoney-core/commercia/sendPhoneVerification ?"
//#define settingNatureMenURL @"/superMoney-core/commercia/assignNatural?" //添加自然人
#define preSettingNatureMenURL @"/superMoney-core/commercia/preAssignNatural.do?" //预添加自然人

#define ModifyNatureMenIdentifyURL @"/superMoney-core/commercia/updateNaturalPersonDo?" //修改自然人身份证等信息
#define ModifyNatureMenURL @"/superMoney-core/commercia/getUpdateNaturalPersonInfo?"  //获取自然人账号信息

//验证登录地址
#define LoginCheckUrl @"superMoney-core/nature/detection?"

//各种协议地址
//《超额宝自动转入服务协议》
//《众信平台服务协议（超额宝）》
//《借款协议（超额宝）》
//《支付通用户注册协议》
//《超额宝服务协议》
//《资金划转授权协议》
#ifdef UAT

#ifdef WORK
#define PROTOCOL_IP @"http://59.151.121.91:8080"
#else
#define PROTOCOL_IP @"http://59.151.121.87:8081"
#endif

#else
#define PROTOCOL_IP  @"http://192.168.0.56:8080"
#endif

#define BORROW_MONEY_PROTOCOL @"/superMoney-core/pages/borrowProtocol.html"    //《借款协议（超额宝）》
#define CHAOEBAOFUWUXIEYI_PROTOCOL @"/superMoney-core/pages/servicesProtocol.html" //《超额宝服务协议》
#define ZIJINZHUANSHOUXIEYI_PROTOCOL @"/superMoney-core/pages/TransferProtocol.html" //《资金划转授权协议》
#define CHAOEBAOZIDONGZHUANRUFUWUXIEYI_PROTOCOL @"/superMoney-core/pages/transferredProtocol.html" //《超额宝自动转入服务协议》
#define ZHIFUTONGYONGHUZHUCE_PROTOCOL @"/superMoney-core/pages/userProtocol.html"    //《支付通用户注册协议》
#define ZHONGXINPINGTAIFUWU_PROTOCOL @"/superMoney-core/pages/zxServiceProrocol.html" //《众信平台服务协议（超额宝）》


//#define HostURL @"http://192.168.0.120/interfaces.php?app=ios&v=103&op=" //测试服务器
//#define ShareURL_ZX @"http://192.168.0.120/trust/projectintro.php?"//分享
//#define HelpCenterURL_ZX @"http://192.168.0.120/trust/apphelp.php?action="//帮助中心

#endif


#define SharePicURL_ZX @"http://59.151.121.57/static/img/sharelogo.jpg"


#define getversionURL  @"getversion"
#define userloginURL @"userlogin"//登录接口
#define sendcodeURL @"sendcode" //发送验证码
#define getserviceURL @"getservice" //获取服务协议
#define checkuserisexistURL @"checkuserisexist" //注册前一步
#define registerURL @"register"     //
#define setpaypassURL @"setpaypass" //设置支付密码
#define checkuserURL @"checkuser" //判断验证码对不对
#define setuserpassURL @"setuserpass"//设置新的登录密码
#define sendsmsListURL @"sendsmsList"
#define getstandardlistURL @"getstandardlist"//获取 投资项目（全部 转让中）
#define getstandarddetailURL @"getstandarddetail"//获取 投资项目详情
#define getuserinfoURL @"getuserinfo"   //获取用户信息
#define setbankURL @"setbank"           //绑定银行卡
#define setuserpassURL @"setuserpass"   //修改密码
#define authuserURL @"authuser"         //实名认证
#define uploadidcardURL @"uploadidcard"  //实名认证身份证上传
#define getbankinfoURL @"getbankinfo"   //获取绑定银行卡
#define unbindcardURL @"unbindcard"     //解绑银行卡
#define setuserpassURL @"setuserpass"   //修改登录密码
#define getbalanceURL @"getbalance"  //仅仅获取账户余额
#define withdrawURL @"withdraw"   //提现
#define rechargeURL @"recharge"  //充值
#define setinvestURL @"setinvest" //投资  19
#define getmybiddetailURL @"getmybiddetail"//获取 我的 投资项目详情
#define getprojectcontentURL @"getprojectcontent" //获取项目进度信息
#define confirmtransURL @"confirmtrans"// 获取转让收益确认页面(***)
#define finaltransURL @"finaltrans"// 标的最终转让确认
#define getcardbinURL @"getcardbin"
#define getrechargeattorneyURL @"getrechargeattorney"//获取充值代扣委托书信息
#define getbanklimitinformationURL @"getbanklimitinformation"//获取银行限额信息
#define getbuyandtransURL @"getstandardview"//获取购买 转让列表
#define confirmbuyURL @"confirmbuy" //购买收益确认 43
#define cashflowURL @"cashflow"//资金流水（资金变动）
#define getnoticelistURL @"getnoticelist"//公告列表
#define getnoticedetailURL @"getnoticedetail"//公告详情
#define setadviceURL @"setadvice"//意见反馈
#define getaccountinfoURL @"getaccountinfo"

#define checkmerchantisexistURL @"checkmerchantisexist"//检查商户是否在平台注册
#define merchantregisterURL @"merchantregister"//商户注册



