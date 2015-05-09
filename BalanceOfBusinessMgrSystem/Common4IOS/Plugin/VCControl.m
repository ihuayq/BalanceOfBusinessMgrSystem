//
//  VCControl.m
//  ipaycard
//
//  Created by han bing on 13-1-28.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "VCControl.h"
//#import "MyAccountVC.h"
//#import "ListVC.h"

#import "PayView.h"

#import <QuartzCore/QuartzCore.h>

#import "CreditDB.h"
#import "TransDB.h"

@implementation VCControl
+(UIViewController *) backViewController:(int) nextId{
    switch (nextId) {
        case BegMobRech:{//手机充值
            UIViewController *bMRVC = [[NSClassFromString(@"BeginMobileVC") alloc] initWithNibName:@"BeginMobileVC" bundle:nil];
            return bMRVC;
        } break;
        case BegAlpRech:{//支付宝充值
            UIViewController *bApPay = [[NSClassFromString(@"BeginAlipayRechargeViewController") alloc] initWithNibName:@"BeginAlipayRechargeViewController" bundle:nil];
            return bApPay;
            //AlipayRechargeNewViewController
            //UIViewController *bApPay = [[NSClassFromString(@"AlipayRechargeNewViewController") alloc] initWithNibName:@"AlipayRechargeNewViewController" bundle:nil];
            //return bApPay;
        }   break;
        case BegAlpPay:{//支付宝订单支付
            UIViewController *bApRech = [[NSClassFromString(@"BeginAlipayPayViewController") alloc] initWithNibName:@"BeginAlipayPayViewController" bundle:nil];
            return bApRech;
        } break;
        case CreditPay:{//信用卡还款
            UIViewController *trdPayV;

            if ([[CreditDB findAllData] count]==0) {
                trdPayV = [[NSClassFromString(@"AddCreditVC") alloc] initWithNibName:@"AddCreditVC" bundle:nil];
            }else{
                 trdPayV = [[NSClassFromString(@"CreditPayViewController") alloc] initWithNibName:@"CreditPayViewController" bundle:nil];
            }
            return trdPayV;

        }   break;
        case BankTransfer:{//银行卡转账
            UIViewController *rtTransView ;
            if ([[TransDB findAllData] count]==0) {
                rtTransView= [[NSClassFromString(@"RTTransBeginVC") alloc] initWithNibName:@"RTTransBeginVC" bundle:nil];
            }else{
                rtTransView= [[NSClassFromString(@"RTTransFirstVC") alloc] initWithNibName:nil bundle:nil];
            }
            return rtTransView;
#if 0
            UIViewController *trdPayV;
            if ([[TransDB findAllData] count]==0) {
                trdPayV = [[NSClassFromString(@"AddBankVC") alloc] initWithNibName:@"AddBankVC" bundle:nil];
            }else{
                trdPayV = [[NSClassFromString(@"BankTransferViewController") alloc] initWithNibName:@"BankTransferViewController" bundle:nil];
            }
            return trdPayV;
#endif
        }
            break;
        case OverSearth:{//余额查询
            PayView *payView = [[NSClassFromString(@"PayView") alloc] initWithNibName:@"PayView" bundle:nil];
            return  payView;
        }   break;
        case WaterCharge:{//水费缴纳
            UIViewController *waterDeal = [[NSClassFromString(@"BeginWaterCharge") alloc] initWithNibName:@"BeginWaterCharge" bundle:nil];
            return waterDeal;
        }   break;
        case ElecCharge:{//电费缴纳
            UIViewController *elecDeal= [[NSClassFromString(@"BeginElecCharge") alloc] initWithNibName:@"BeginElecCharge" bundle:nil];
            return elecDeal;
        }   break;
        case GasCharge:{//燃气费缴纳
            UIViewController *gasDeal = [[NSClassFromString(@"BeginGasCharge") alloc] initWithNibName:@"BeginGasCharge" bundle:nil];
            return gasDeal;
        }   break;
        case HeatCharge:{//热力费缴费
            UIViewController *heatDeal = [[NSClassFromString(@"BeginHeatCharge") alloc] initWithNibName:@"BeginHeatCharge" bundle:nil];
            return heatDeal;
        }   break;
        case PhoneCharge:{//通讯费缴费
            UIViewController *commDeal= [[NSClassFromString(@"BeginCommCharge") alloc] initWithNibName:@"BeginCommCharge" bundle:nil];
            return commDeal;
        }   break;
        case IC:{  //IC卡业务
            UIViewController *icElec = [[NSClassFromString(@"SignViewController") alloc] initWithNibName:@"SignViewController" bundle:nil];
            return icElec;
        }   break;
        case MerIC:{//金融IC卡
            UIViewController *gameDeal = [[NSClassFromString(@"PBOCViewController") alloc] initWithNibName:@"PBOCViewController" bundle:nil];      //PBOCViewController old
            return gameDeal;
        }   break;
        case GIFT:{//礼品卡
            UIViewController *icElec = [[NSClassFromString(@"JXTuanGift") alloc] initWithNibName:@"JXTuanGift" bundle:nil];
            
            return icElec;
        }   break;
        case ETC:{//ETC
            UIViewController *icElec = [[NSClassFromString(@"ETCSignView") alloc] initWithNibName:@"ETCSignView" bundle:nil];
            return icElec;
        }   break;
        case GameCharge:{//游戏点卡
            UIViewController *icElec = [[NSClassFromString(@"BeginGameCharge") alloc] initWithNibName:@"BeginGameCharge" bundle:nil];
            return icElec;
        }   break;
        case TrainTicket:{ //火车票
            UIViewController *trainTicket = [[NSClassFromString(@"TicketBeginViewController") alloc]initWithNibName:@"TicketBeginViewController" bundle:nil];
            return trainTicket;
        }
            break;
        case AccCharge:{ //账户充值
            UIViewController *accChaView = [[NSClassFromString(@"") alloc]initWithNibName:nil bundle:nil];
            return accChaView;
        }
            break;
        case QRCode:{//二维码
            UIViewController *qrcodeView = [[NSClassFromString(@"RTTransFirstVC") alloc] initWithNibName:nil bundle:nil];
            return qrcodeView;
        }
            break;
        case TrdDetail:{//交易详情
            UIViewController *trdDetailV = [[NSClassFromString(@"TradeDetailViewController") alloc] initWithNibName:@"TradeDetailViewController" bundle:nil];
            return trdDetailV;
        }   break;
        case MobRechEnd:{//手机充值结束
            UIViewController *mobREndVC = [[NSClassFromString(@"EndMobileRechargeViewController") alloc] initWithNibName:@"EndMobileRechargeViewController" bundle:nil];
            return mobREndVC;
        }   break;
        case AlpRechEnd:{//支付宝充值结束
            UIViewController *alpREndVC = [[NSClassFromString(@"EndAlipayRechargeViewController") alloc] initWithNibName:@"EndAlipayRechargeViewController" bundle:nil];
            return alpREndVC;
        }   break;
        case AlpPayEnd:{//支付宝订单支付结束
            UIViewController *alpPEndVC = [[NSClassFromString(@"EndAlipayPayViewController") alloc] initWithNibName:@"EndAlipayPayViewController" bundle:nil];
            return alpPEndVC;
        }   break;
        case OverEnd://余额查询结束
        {
            UIViewController *searchResult = [
            [NSClassFromString(@"SearchResult") alloc]initWithNibName:@"SearchResult" bundle:nil];
            return searchResult;
        } break;
        case CreditEnd://信用卡结束
        {
            UIViewController *searchResult = [
                    [NSClassFromString(@"EndCrediPayVC") alloc]initWithNibName:@"EndCrediPayVC" bundle:nil];
            return searchResult;
        } break;
        case BankTransferEnd://银行卡转账结束
        {
            UIViewController *bankTransEnd = [[NSClassFromString(@"RTTransEndVC") alloc]initWithNibName:@"RTTransEndVC" bundle:nil];
            return bankTransEnd;
        } break;
        case WaterEnd://水费结束
        {
            UIViewController *waterEnd = [[NSClassFromString(@"EndWaterCharge") alloc]initWithNibName:@"EndWaterCharge" bundle:nil];
            return waterEnd;
        } break;
        case ElecEnd://电费结束
        {
            UIViewController *elecEnd = [[NSClassFromString(@"EndElecCharge") alloc]initWithNibName:@"EndElecCharge" bundle:nil];
            return elecEnd;
        } break;
        case GasEnd://燃气费结束
        {
            UIViewController *gasEnd = [[NSClassFromString(@"EndGasCharge") alloc]initWithNibName:@"EndGasCharge" bundle:nil];
            return gasEnd;
        } break;
            
        case HeatEnd://热力费结束
        {
            UIViewController *heatEnd = [[NSClassFromString(@"EndHeatCharge") alloc]initWithNibName:@"EndHeatCharge" bundle:nil];
            return heatEnd;
        } break;
        case PhoneEnd://通讯费结束
        {
            UIViewController *commEnd = [[NSClassFromString(@"EndCommCharge") alloc]initWithNibName:@"EndCommCharge" bundle:nil];
            return commEnd;
        } break;
        case ICEnd://IC结束 两种结果
        {
            UIViewController *icEnd  = [[NSClassFromString(@"EndIC") alloc]initWithNibName:@"EndIC" bundle:nil];
            return icEnd;
        } break;
        case MerICEnd://MerIC查询结束
        {
            UIViewController *merIcEnd  = [[NSClassFromString(@"queryEndViewController") alloc]initWithNibName:@"queryEndViewController" bundle:nil];
            return merIcEnd;
        } break;
        case GiftEnd://礼品卡结束
        {
            UIViewController *giftEnd  = [[NSClassFromString(@"what") alloc]initWithNibName:@"what" bundle:nil];
            return giftEnd;
        } break;
        case ETCEnd://ETC结束 两种结果
        {
            UIViewController *etcEnd  = [[NSClassFromString(@"ETCSignView") alloc]initWithNibName:@"ETCSignView" bundle:nil];
            return etcEnd;
        } break;
            
        case ETCEndJZ://ETC结束
        {
            UIViewController *etcJZEnd  = [[NSClassFromString(@"ETCEndView") alloc]initWithNibName:@"ETCEndView" bundle:nil];
            return etcJZEnd;
        } break;
        case GameEnd://游戏点卡结束
        {
            UIViewController *gameEnd  = [[NSClassFromString(@"EndGameCharge") alloc]initWithNibName:@"EndGameCharge" bundle:nil];
            return gameEnd;
        } break;
            
        case WriteCard://写卡
        {
            UIViewController *writecard   = [[NSClassFromString(@"SignViewController") alloc]initWithNibName:@"SignViewController" bundle:nil];
            return writecard;
        }
            break;
        case MerLoadEnd://金融卡圈存写卡
        {
            UIViewController *merLoadEnd   = [[NSClassFromString(@"LoadTimerVC") alloc]initWithNibName:nil bundle:nil];
            return merLoadEnd;
        }
            break;
        case TicketEnd: //火车票结束
        {
            UIViewController *ticketEnd   = [[NSClassFromString(@"EndTicketPayViewController") alloc]initWithNibName:nil bundle:nil];
            return ticketEnd;
        }
            break;
        case AccChaEnd: //账户充值结束
        {
            UIViewController *rttEnd   = [[NSClassFromString(@"EndAccountRechargeVC") alloc]initWithNibName:@"EndAccountRechargeVC" bundle:nil];
            return rttEnd;
        }
            break;
        case QRCodeEnd: //结束
        {
            UIViewController *rttEnd   = [[NSClassFromString(@"RTTransEndVC") alloc]initWithNibName:nil bundle:nil];
            return rttEnd;
        }
            break;
        case TestView: //测试页面
        {
            UIViewController *testEnd   = [[NSClassFromString(@"WriteSRMsgViewController") alloc]initWithNibName:nil bundle:nil];
            return testEnd;
        }
            break;
        default:{
            return nil;
        }
            break;
    }
}


+(UIViewController *) nextView{
    
    NSDictionary *normalDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:11.5f],UITextAttributeFont,[UIColor blackColor],UITextAttributeTextColor,[UIColor grayColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0.0f,0.0f)],UITextAttributeTextShadowOffset,nil]; //AmericanTypewriter Helvetica
    NSDictionary *selectDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:11.5f],UITextAttributeFont,[UIColor redColor],UITextAttributeTextColor,[UIColor redColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0.0f,0.0f)],UITextAttributeTextShadowOffset,nil];

//    IndexViewController *indexViewControl = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
//    [indexViewControl.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"应用_d.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"应用.png"]];

//    [indexViewControl.tabBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
//    [indexViewControl.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
//    [indexViewControl.tabBarItem setTitle:@"应用"];
//    UINavigationController *indexNavController = [[UINavigationController alloc] initWithRootViewController:indexViewControl];

//    MyAccountVC *myaccountview = [[MyAccountVC alloc]initWithNibName:@"MyAccountVC" bundle:nil];
//    [myaccountview.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"账户_d.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"账户.png"]];
//    [myaccountview.tabBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
//    [myaccountview.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
//    [myaccountview.tabBarItem setTitle:@"我的账户"];
//    UINavigationController *accountNav = [[UINavigationController alloc] initWithRootViewController:myaccountview];
//    
//    ListVC *listview = [[ListVC alloc]initWithNibName:@"ListVC" bundle:nil];
//    [listview.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"记录_d.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"记录.png"]];
//    [listview.tabBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
//    [listview.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
//    [listview.tabBarItem setTitle:@"记录"];
//    UINavigationController *listNav = [[UINavigationController alloc] initWithRootViewController:listview];

    
    //MoreViewController *moreView = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
//    UINavigationController *moreViewNav = [[UINavigationController alloc] initWithRootViewController:moreView];
//    [moreViewNav.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"设置_d.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"设置.png"]];
//    [moreViewNav.tabBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
//    [moreViewNav.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
//    [moreViewNav.tabBarItem setTitle:@"设置"];
    
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    UIView * mView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 48)];
    [mView setBackgroundColor:[UIColor whiteColor]];
    [tabbarVC.tabBar insertSubview:mView atIndex:1];

    tabbarVC.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"footerP.png"];
    //tabbarVC.viewControllers = [NSArray arrayWithObjects:indexNavController,accountNav,listNav,moreViewNav, nil];
    //[tabbarVC.tabBar setAlpha:0.8];
    
    //UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:2];
    //[item setFinishedSelectedImage:[UIImage imageNamed:@"应用_d.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"应用.png"]];
    //[item setImage:[UIImage imageNamed:@"应用.png"]];
    //indexViewControl.tabBarItem = item;
    //indexViewControl.tabBarController.tabBar.clipsToBounds = YES;
    //indexViewControl.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -7, 0);//(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    //[(UITabBarItem *)[tabbarVC.tabBar.items objectAtIndex:0] setFinishedSelectedImage:[UIImage imageNamed:@"应用_d.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"应用.png"]];
    //[(UITabBarItem *)[tabbarVC.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"应用.png"]];

    return tabbarVC;
}
@end
/*
 [tabbarVC.tabBar setBackgroundImage:[UIImage imageNamed:@""]];

 
 NSArray *array = [tabbarVC.view subviews];
 UITabBar *tabBar = [array objectAtIndex:1];
 UIImage *image = [UIImage imageNamed:@"底部导航left.png"];
 tabBar.layer.contents = (id)image.CGImage;
*/