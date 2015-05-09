//
//  UIQuickHelp.m
//  MyFlight2.0
//
//  Created by Davidsph on 12/6/12.
//  Copyright (c) 2012 LIAN YOU. All rights reserved.
//

#import "UIQuickHelp.h"
#import "AppConfigure.h"
@implementation UIQuickHelp


+(NSString *) intToHex:(int) intVal{
    if (intVal < 0) {
        intVal += 256;
    }
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig = intVal%16;
    int tmp = intVal/16;
    switch (ttmpig)     {
        case 10:
            nLetterValue =@"A";
            break;
        case 11:
            nLetterValue =@"B";
            break;
        case 12:
            nLetterValue =@"C";
            break;
        case 13:
            nLetterValue =@"D";
            break;
        case 14:
            nLetterValue =@"E";
            break;
        case 15:
            nLetterValue =@"F";
            break;
        default:
            nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
    }
    switch (tmp)     {
        case 10:
            nStrat =@"A";
            break;
        case 11:
            nStrat =@"B";
            break;
        case 12:
            nStrat =@"C";
            break;
        case 13:
            nStrat =@"D";
            break;
        case 14:
            nStrat =@"E";
            break;
        case 15:
            nStrat =@"F";
            break;
        default:
            nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
    }
    endtmp =[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    NSString *str=@"";
    if([endtmp length]<4)     {
        endtmp=[[NSString alloc]initWithFormat:@"%@%@",str,endtmp];
    }
    return endtmp;
}

+(NSString *) intToHexSmall:(int)intVal{
    if (intVal < 0) {
        intVal += 256;
    }
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig = intVal%16;
    int tmp = intVal/16;
    switch (ttmpig)     {
        case 10:
            nLetterValue =@"a";
            break;
        case 11:
            nLetterValue =@"b";
            break;
        case 12:
            nLetterValue =@"c";
            break;
        case 13:
            nLetterValue =@"d";
            break;
        case 14:
            nLetterValue =@"e";
            break;
        case 15:
            nLetterValue =@"f";
            break;
        default:
            nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
    }
    switch (tmp)     {
        case 10:
            nStrat =@"a";
            break;
        case 11:
            nStrat =@"b";
            break;
        case 12:
            nStrat =@"c";
            break;
        case 13:
            nStrat =@"d";
            break;
        case 14:
            nStrat =@"e";
            break;
        case 15:
            nStrat =@"f";
            break;
        default:
            nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    NSString *str=@"";
    if([endtmp length]<4)     {
        endtmp=[[NSString alloc]initWithFormat:@"%@%@",str,endtmp];
    }
    return endtmp;
}



+(int) stringToInt:(NSString *) strVal{
    NSString *beginStr =[strVal substringToIndex:1];
    NSString *endStr = [strVal substringFromIndex:1];
    
    int tmpBeginInt = 0;
    int tmpEndInt = 0;
    
    if ([beginStr isEqualToString:@"a"] || [beginStr isEqualToString:@"A"]) {
        tmpBeginInt = 10;
    }else if([beginStr isEqualToString:@"b"] || [beginStr isEqualToString:@"B"]){
        tmpBeginInt = 11;
    }else if([beginStr isEqualToString:@"c"] || [beginStr isEqualToString:@"C"]){
        tmpBeginInt = 12;
    }else if([beginStr isEqualToString:@"d"] || [beginStr isEqualToString:@"D"]){
        tmpBeginInt = 13;
    }else if([beginStr isEqualToString:@"e"] || [beginStr isEqualToString:@"E"]){
        tmpBeginInt = 14;
    }else if([beginStr isEqualToString:@"f"] || [beginStr isEqualToString:@"F"]){
        tmpBeginInt = 15;
    }else{
        tmpBeginInt = [beginStr intValue];
    }
    
    if ([endStr isEqualToString:@"a"] || [endStr isEqualToString:@"A"]) {
        tmpEndInt = 10;
    }else if([endStr isEqualToString:@"b"] || [endStr isEqualToString:@"B"]){
        tmpEndInt = 11;
    }else if([endStr isEqualToString:@"c"] || [endStr isEqualToString:@"C"]){
        tmpEndInt = 12;
    }else if([endStr isEqualToString:@"d"] || [endStr isEqualToString:@"D"]){
        tmpEndInt = 13;
    }else if([endStr isEqualToString:@"e"] || [endStr isEqualToString:@"E"]){
        tmpEndInt = 14;
    }else if([endStr isEqualToString:@"f"] || [endStr isEqualToString:@"F"]){
        tmpEndInt = 15;
    }else{
        tmpEndInt = [endStr intValue];
    }
    
    return tmpBeginInt * 16 + tmpEndInt;
}

+(NSString *) stringToSha1:(NSString *) oriStr{
    
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    
    char cStr[256] = {};
    int i = 0;
    for (int idx = 0; idx+2 <= oriStr.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [oriStr substringWithRange:range];
        int strInt = [self stringToInt:hexStr];
        cStr[i] = (char) strInt;
        i++;
    }
    
    CC_SHA1(cStr, i, result); //strlen(cStr)
    
    NSData *pwHashData = [[NSData alloc] initWithBytes:result length: sizeof result];
    
    NSMutableString *pStr = [[NSMutableString alloc] initWithCapacity: 1];
    UInt8 *p = (UInt8*) [pwHashData bytes];
    int len = [pwHashData length];
    for(int i = 0; i < len; i ++)
    {
        if(i%4==0){
            [pStr appendFormat:@"%02x", *(p+i)];
        }else{
            [pStr appendFormat:@"%02x", *(p+i)];
        }
    }
    
    
    NSString *str=pStr;
    return  str;
}


+ (NSString *) get9BytesRandNum{
    
    NSMutableString *rad = [[NSMutableString alloc] init];
    
    for (int i = 0; i<9; i++) {
        int value = (arc4random() % 10) + 1;
        
        [rad appendString:[self intToHex:value]];
        
    }
    
    CCLog(@"生成的随机数为 ；%@",rad);
    return  rad;
 
}


+ (NSString *) get16BytesStringWithPhoneId:(NSString *) phoneId{
    
    char regRandomChar[9] = {};
    
    NSMutableString *rad = [[NSMutableString alloc] init];
    
    [rad appendString:phoneId];
    
    [rad appendString:@"010203040506070801"];
    
    for (int i = 0; i<9; i++) {
         int value = (arc4random() % 10) + 1;
         
         [rad appendString:[self intToHex:value]];
         regRandomChar[i] = value;
    }
    
    printf("c string = %s\n",[rad UTF8String]);
    
    CCLog(@"phoneId = %@",phoneId);
    CCLog(@"radom = %@", [rad substringFromIndex:14]);
    
    CCLog(@"拼接之后的获取checkCodeTmp = %@",rad);
    
    CCLog(@" char = %s",regRandomChar);
    
    for (int i= 0; i<9; i++) {
        printf("char = %d\n",regRandomChar[i]);
    }
    
    return rad;
    
}



+ (void)setRoundCornerForView:(UIView*)view
                   withRadius:(CGFloat)radius{
    
    view.layer.cornerRadius = radius;
    [view setNeedsDisplay];
}


+ (void)setBorderForView:(UIView*)view
               withWidth:(CGFloat)width
               withColor:(UIColor*)color{
    view.layer.borderWidth = width;
    view.layer.borderColor = color.CGColor;
    [view setNeedsDisplay];
}

+ (void) showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delgate cancelButtonTitle:(NSString *)cancel otherButtonTitles:(NSString *)ok{
    NSString *newMessage = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:title message:newMessage delegate:delgate cancelButtonTitle:cancel otherButtonTitles:ok, nil];
    
    [view show];
    
    [view release];
        
}


+ (void) showAlertViewWithMessage:(NSString *) message{
    NSString *newMessage = [message stringByReplacingOccurrencesOfString:@" " withString:@""];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:nil message:newMessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [view show];
    
    [view release];
  
}

+ (void) setTableViewCellBackGroundColorAndHighLighted:(UITableViewCell *) cell{
    
    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
    cell.selectedBackgroundView.backgroundColor=[UIColor redColor];
}


+ (void) setTableViewCellBackGroundColorAndHighLighted:(UITableViewCell *)cell type:(int ) type{
    
    UIImage *image = nil;
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:cell.frame];
    
    switch (type) {
        case 1:
            
            image =[UIImage imageNamed:@"Bg_Cell_Top.png"];
            break;
            
        case 2:
            image =[UIImage imageNamed:@"Bg_Cell_Middle.png"];
            break;
            
        case 3:
            image =[UIImage imageNamed:@"Bg_Cell_Buttom.png"];
            
            break;
        case 4:
            image = [UIImage imageNamed:@"Bg_Cell_TopButtom.png"];
            break;
        default:
            break;
    }
    //    CGRect frame =CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height-1);
    
    
    imageView.image =image;
    cell.selectedBackgroundView = imageView;
    [imageView release];
      
}

+ (BOOL) isRightMobile:(NSString *) mobile{
    
    NSString *phoneStr =[mobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE1 = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneStr] == YES)
        || ([regextestcm evaluateWithObject:phoneStr] == YES)
        || ([regextestct evaluateWithObject:phoneStr] == YES)
        || ([regextestcu evaluateWithObject:phoneStr] == YES)
        )
    {
        
        return true;
        
    }
    else
    {
        
        return false;
        
    }
}




+ (NSString *) getcheckCodeNumWithCardSd:(NSString *)cardSd encryptedPwd:(NSString *) passwd{
    
    
    CCLog(@"待加密的磁道信息为 ：%@ \n 密码的密文为：%@",cardSd,passwd);
    
    NSString *shaOne = [self stringToSha1:[NSString stringWithFormat:@"%@%@",cardSd,passwd]];
    
    NSString *shaOne32 = [shaOne substringToIndex:32];
    
    
    CCLog(@"拼接之后的待加密字符串为：%@",shaOne32);
    
    return shaOne32;
    
}


//pwd 为明文密码 封装后 返回的是待加密的密码
+ (NSString *) getPassWdTmp:(NSString *) passStr{
    
    
    CCLog(@"银行卡密码长度为 %d",[passStr length]);
    
    NSMutableString *mutabPassStr = [[NSMutableString alloc] init];
    
    int passStrLength = [passStr length];
    if (passStrLength < 10) {
        [mutabPassStr appendString:[NSString stringWithFormat:@"0%i",passStrLength]];
    }else{
        [mutabPassStr appendString:[NSString stringWithFormat:@"%i",passStrLength]];
    }
    [mutabPassStr appendString:passStr];
    for (int i = (passStrLength + 2); i<32; i++) {
        [mutabPassStr appendString:@"f"];
    }
    
    CCLog(@"mutabpassstr=%@",mutabPassStr);
    return mutabPassStr;
    
}


//获取银行卡密码待加密的信息
+ (NSString *) getEncryptBankCardPassWord:(NSString *)passStr{
    
    CCLog(@"银行卡密码长度为 %d",[passStr length]);
    
    NSMutableString *mutabPassStr = [[NSMutableString alloc] init];
    
    int passStrLength = [passStr length];
    if (passStrLength < 10) {
        [mutabPassStr appendString:[NSString stringWithFormat:@"0%i",passStrLength]];
    }else{
        [mutabPassStr appendString:[NSString stringWithFormat:@"%i",passStrLength]];
    }
    [mutabPassStr appendString:passStr];
    for (int i = (passStrLength + 2); i<32; i++) {
        [mutabPassStr appendString:@"f"];
    }
    
    
    
#if 0
     char passStrChar[16] = {};
     int i = 0;
     
     NSMutableString *resultString1 =[[NSMutableString alloc] init];
     
     
     for (int idx = 0; idx+2 <= mutabPassStr.length; idx+=2) {
     NSRange range = NSMakeRange(idx, 2);
     NSString* hexStr = [mutabPassStr substringWithRange:range];
     int strInt = [self stringToInt:hexStr];
     
     [resultString1 appendFormat:@"%d",strInt];
     
     passStrChar[i] = (char) strInt;
     
     printf("^^^^^^%s\n",passStrChar);
     
     i++;
     }
     
     
     NSString *resultString = [[NSString alloc] initWithCString:passStrChar encoding:NSUTF8StringEncoding];
     
     
     CCLog(@"待加密的银行卡信息为 ：%@",resultString1);
     
     return resultString;
    
#endif
    
    
    NSString *string = [NSString stringWithString:mutabPassStr];
    //[mutabPassStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    CCLog(@"待加密的银行卡密码信息为：%@  长度为 =%d ",string,[string length]);
    
    return string;
    
}



@end
