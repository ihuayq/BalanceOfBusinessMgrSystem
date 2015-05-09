//
//  ZftDriveManager.m
//  ipaycard
//
//  Created by RenLongfei on 14-4-10.
//  Copyright (c) 2014年 Davidsph. All rights reserved.
//

#import "ZftDriveManager.h"

#import "DJYPhoneCardSignInHelp.h"

#import "DJYAnimationFactory.h"


@interface ZftDriveManager ()
{
    BOOL isPlugin;
    NSString *zftType; //类型
    NSString *zftId;  //ID
    NSString *checkCode;  //签到校验
    NSString *checkCodeForPay;
    NSString *enPsw;  //加密密码
    //PBOC
    NSString *ic55Data;
    NSString *icnone55Data;
    
    int zftBat;//电量
    int a;//获取信息标识
    enum DeviceType zftDeviceType;
    
    NSUserDefaults *userInfo;
}

@end
@implementation ZftDriveManager
@synthesize  cardData;


- (id )init{
    self = [super init];
    CCLog(@"11");
    if (self) {
        
    }
    return self;
}

- (id)initWithType:(DeviceName)deviceName{
    self = [super init];
    CCLog(@"12");
    if (self) {
        if (deviceName == DeviceZFT) {
            [self driveInit];
        }
    }
    return self;
}
- (void) driveInit{
    CCLog(@"zftdriveInit");
    cardData = [DJYCardInfoSingle newCardInfoInstance];

    zftIns = [ZFTInstance newInstance];
    zft = zftIns.zft;
    [zft setListener:self];
    userInfo = [NSUserDefaults standardUserDefaults];
    
    [self performSelector:@selector(waitForDevicePlugin) withObject:nil afterDelay:0];

}

- (void) waitForDevicePlugin{
    CCLog(@"zftwaitForDevicePlugin");
    isPlugin = [zft isPluged];
    
    CCLog(@"zft是否插入= %d", isPlugin);
    
    if (isPlugin) {
        [self.delegate deviceManagerDelegateWithInfotype:@"0"];

        cardData.isPlugin = YES;
        [self getDeviceInfo];
        /* 页面改变 */
        /* 逻辑改变 */
    }
}

- (void) getDeviceInfo{
    CCLog(@"zftgetDeviceInfo");
    BOOL flag = [zft open];
    CCLog(@"zft刷卡器打开 %d",flag);
    
    zftBat = 0;
    zftType= nil;
    zftId = nil;
    checkCode = nil;
    
    NSString *__strong zftTypeTest;
    NSString *__strong zftIdTest;
    NSString *__strong checkCodeTest;
    
    NSString *random = [UIQuickHelp get9BytesRandNum];
    
    if (isPlugin) {
        a = [zft getSignInfo:random andADC:&zftBat andDevType:&zftTypeTest andDevid:&zftIdTest  andCheckcode:&checkCodeTest];
        CCLog(@"获取信息 = %d",a);
    }else{
        return;
    }
    
    if (isPlugin) {
        if (a != 0) {
            /* 页面改变 */
            return;
        }else{
            zftType = zftTypeTest;
            zftId = zftIdTest;
            checkCode = checkCodeTest;
        }
    }else{
        return;
    }

    CCLog(@"random=%@ zftType=%@ zftId=%@ checkcode=%@ zftBat=%d",random,zftType,zftId,checkCode,zftBat);
    if ([zftType rangeOfString:@"ZFT-ZXB-I"].location!=NSNotFound) {
        zftDeviceType = ZFT_I_TYPE;
        [userInfo setObject:@"0" forKey:@"ZFTDeviceType"];//支付通设备类型 0代表I版 1代表S版
        [userInfo synchronize];
        
    }
    if ([zftType rangeOfString:@"ZFT-ZXB-S"].location!=NSNotFound) {
        zftDeviceType = ZFT_S_TYPE;

        [userInfo setObject:@"1" forKey:@"ZFTDeviceType"];//支付通设备类型 0代表I版 1代表S版
        [userInfo synchronize];

        if (zftBat<=3) {
            /* 页面改变 */
            return;
        }
    }

    cardData.signRandrom = random;
    cardData.deviceId = zftId;
    cardData.deviceType = zftType;
    cardData.checkCodeForRegister = checkCode;

    sleep(0.2);
    
    [self makeRegister];

}

- (void)makeRegister{
    
    [DJYPhoneCardSignInHelp makeNewSignWithMachineNum:cardData.deviceId random:cardData.signRandrom checkCode:cardData.checkCodeForRegister delegate:self];
    
}

- (void) questSwipeCard{
    CCLog(@"zftquestSwipeCard");
    NSInteger swipeAdc= 0;
    if (isPlugin) {
        a = [zft requestSwipeCard:cardData.fenSanYinZi andADC:&swipeAdc];
    }else{
        return;
    }
    
    CCLog(@"刷卡成功 = %d",a);
    if (a == 0) {
        CCLog(@"刷卡前电量swipeAdc=%d ",swipeAdc);
        
        if (zftDeviceType == 1) {
            if (swipeAdc<=3) {
                /* 页面改变 */
                return;
            }
        }
    }else{
        /* 页面改变 */

        return;
    }

}

- (void) gotoPayWithPsw:(NSString *)psw andBlock:(void(^)(bool finish)) block{
    CCLog(@"zftgotoPayWithBlock");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //加密银行卡密码  //CCLog(@"lalal%@afdafsdfs=",pswText.text);
        NSString *pwd = [UIQuickHelp getEncryptBankCardPassWord:psw];
        
        NSInteger errorcode = 0;     //错误代码
        
        enPsw = [zft encryptDigest:@"05" andDigest:pwd andfactor:cardData.fenSanYinZi andADC:&zftBat andErrorCode:&errorcode];
        CCLog(@"zft输入密码后zftBat = %d",zftBat);
        CCLog(@"zft加密之后的密码：%@",enPsw);
        
        if (enPsw == nil||[enPsw isEqualToString:@""]) {
            /* 页面改变 */
            return;
        }
        
        cardData.psw = enPsw;
        
        NSString *checkCodeTmp = [UIQuickHelp getcheckCodeNumWithCardSd:cardData.cardSd encryptedPwd:enPsw];
        NSInteger adcTmp = 0; //电量
        
        checkCodeForPay = [zft encryptDigest:@"04" andDigest:checkCodeTmp andfactor:cardData.fenSanYinZi andADC:&adcTmp andErrorCode:&errorcode];
        
        if ([checkCodeForPay isEqualToString:@""]||checkCodeForPay == nil) {
            /* 页面改变  文字改变 */
            return;
        }
        CCLog(@"zft 密码时电量adcTmp = %d",adcTmp);
        if (zftDeviceType ==1) {
            if (adcTmp<=3) {
                /* 页面改变 电量不足 */
                return;
            }
        }
        
        cardData.cardPwd = enPsw;
        cardData.checkCodeForPay = checkCodeForPay;
        
        CCLog(@"zft加密之后的摘要密文为%@",checkCodeForPay);
        CCLog(@"支付动作 卡号 = %@ 密码 = %@ ",cardData.cardNum,enPsw);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(true);
        });
    });
}

-(void)queryICCard{
    
//    NSString *timeOne = [Util getCurrentTime:1];
//    NSString *timeTwo = [Util getCurrentTime:2];
//    ic55Data  = [zft getIcCard55DataWithAmount:@"0" Transdate:timeOne Type:@"01" TransTime:timeTwo];
//    CCLog(@"ic55Data=%@",ic55Data);
//    
//    if (ic55Data == nil||ic55Data ==NULL||ic55Data.length<50) {
//        /* 页面改变 电量不足 */
//        return;
//    }
//    NSString *__strong ic55dataTest = ic55Data;
//    int deal55data = [EMVCardVer EMV_CardQueryVerification:&ic55dataTest];
//    if (deal55data !=0) {
//        return;
//    }
//    ic55Data = ic55dataTest;
//    
//    CCLog(@"ic55Datadeal=%@",ic55Data);
//    cardData.icData = ic55Data;
    
    /* 页面改变 逻辑改变 */
    
}

-(void)get55Data{
//    NSString *centStr = [NSString stringWithFormat:@"%.0f",[@"" floatValue ]*100];
//    CCLog(@"centstr＝ %@",centStr);
//    NSString *timeOne = [Util getCurrentTime:1];
//    NSString *timeTwo = [Util getCurrentTime:2];
//    ic55Data = [zft getIcCard55DataWithAmount:centStr Transdate:timeOne Type:@"00" TransTime:timeTwo];
//    CCLog(@"ic55Data=%@",ic55Data);
//    
//    if (ic55Data == nil||ic55Data ==NULL||ic55Data.length<50) {
//        /* 页面改变 电量不足 */
//
//        return;
//    }
//    NSString *__strong ic55dataTestOne = ic55Data;
//    int deal55data = [EMVCardVer EMV_CardLoadVerification:&ic55dataTestOne];
//    if (deal55data !=0) {
//        /* 页面改变 电量不足 */
//        return;
//    }
//    ic55Data = ic55dataTestOne;
//    CCLog(@"ic55Datadeal=%@",ic55Data);
//    cardData.icData = ic55Data;
//    
//    /* 页面改变 逻辑改变 */

    
}

#pragma mark - zftdelegate

- (void)onPlugin{
    [self waitForDevicePlugin];
}

- (void)onCardNum:(NSString *)accNo{
    cardData.cardNum = accNo;
    CCLog(@"zft cardnum =%@",accNo);
    
    /* 页面改变 */
    
}

- (void)onCardData:(NSString *)encTrack{
    cardData.cardSd = encTrack;
    NSInteger i =[encTrack length];
    CCLog(@"zft 磁道长度 = %d %@",i,encTrack);
}

- (void)onError:(NSInteger)errCode{
    CCLog(@"zft errorcode= %d",errCode);
}

- (void)onPlugout{
    
    isPlugin = NO;
    cardData.isPlugin = NO;
    
    CCLog(@"zft 刷卡设备没被插入");
    /* 页面改变 */

}


#pragma mark - netWork
- (void) requestDidFailed:(NSDictionary *) info{
    CCLog(@"zft签到失败");
    /*界面改变*/

}

- (void) requestDidFinishedWithRightMessage:(NSDictionary *)info{
    CCLog(@"info =%@",info);
    if([info objectForKey:@"ret_byte"]){
        if ([Util getRspCode:info]) {
            NSString *fensanYinzi = [info objectForKey:@"ret_byte"];
            cardData.fenSanYinZi = fensanYinzi;
            CCLog(@"zft获取的分散因子为%@",fensanYinzi);
            /*界面改变*/
            [self questSwipeCard];
            
        }
    }
}

- (void) requestDidFinishedWithFalseMessage:(NSDictionary *)info{
    CCLog(@"info=%@",info);
    
    if (![Util getRspCode:info]) {
        CCLog(@"zft签到失败");
        /*界面改变*/
    }
}

@end
