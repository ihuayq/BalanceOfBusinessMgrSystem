//
//  DJYBlanceQuaryHelper.h
//  ipaycard
//
//  Created by Davidsph on 4/12/13.
//  Copyright (c) 2013 Davidsph. All rights reserved.
//

#import "DJYBaseNetworkHelp.h"

@interface DJYBlanceQuaryHelper : DJYBaseNetworkHelp


/*******
 
 
 请求参数说明 
 
 termid --》》》终端号
 
 cardNum  ----》》》银行卡号 
 
 passwd ---》》》银行卡密码
 
 checkCode --->>> 
 
 
 返回参数说明
 
 
 
 
 ********/



+ (void)quaryCardBalanceWithTermid:(NSString *) termid
                         checkCode:(NSString *) checkCode
                             cardNum:(NSString *)cardNum
                        andCardPwd:(NSString *)passwd
                          delegate:(id<ServiceDelegate>) delegate;



@end
