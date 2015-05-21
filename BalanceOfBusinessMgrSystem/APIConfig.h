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

//自然人
#define IP @"http://192.168.1.107:8080/"

//#define HostURL @"superMoney-core/nature/loginIn?" //测试服务器
#define HostURL @"superMoney-core/nature/loginIn?" //测试服务器
#define DrawCashURL @"superMoney-core/nature/saveInfo?"//沉淀
#define MessageCodeURL @"superMoney-core/nature/getMessageCode?"// 获取验证码
#define PayPasswdURL @"superMoney-core/nature/setPayPass?"// 第一次设置交易密码时候使用
#define SetLoginPasswdURL @"superMoney-core/nature/updateLoginPass?"// 创建登陆密码,第一次登陆时候用
#define ModifyLoginPasswdURL @"superMoney-core/nature/changeLoginPass?"   //改变登陆密码
#define ModifyPayPasswdURL @"superMoney-core/nature/changePayPass?"   //改变登陆密码

#define WithDrawURL @"superMoney-core/nature/withdraw?"// 提现
#define AssetInfoUrl @"superMoney-core/nature/queryDetail?" //资产变动信息查询


//商户登陆
#define CommercialIP @"http://192.168.1.110:8080/"
#define CommercialHostURL @"superMoney-core/commercia/commerCiainfo?"
#define AccountURL @"superMoney-core/commercia/getCommercialWebsiteInfo?"
#define SavaAccountURL @"/superMoney-core/commercia/saveAccountWebsite?"
#define passCodeURL @"/superMoney-core/commercia/sendPhoneVerification?"
#define settingNatureMenURL @"/superMoney-core/commercia/assignNatural?" //添加自然人
#define ModifyNatureMenIdentifyURL @"superMoney-core/commercia/updateNaturalPersonDo?" //修改自然人身份证等信息
#define ModifyNatureMenURL @"/superMoney-core/commercia/getUpdateNaturalPersonInfo?"  //获取自然人账号信息




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



