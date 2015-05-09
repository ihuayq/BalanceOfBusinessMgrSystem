//
//  Util.m
//  ipaycard
//
//  Created by han bing on 13-1-3.
//  Copyright (c) 2013年 han bing. All rights reserved.
//

#import "Util.h"
#import "GTMBase64.h"
@implementation Util

/*CMHO,//招商银行    BOBJ,//北京银行    CCB, //建设银行    BCM, //交通银行 
BOC, //中国银行  ABC, //农业银行   CEB, //光大银行    SPDB,//浦发银行 
CGB, //广发银行   CTIB,//中信银行    CMBC,//民生银行   SDB, //深圳发展银行
PGBC,//平安银行   HXB, //华夏银行    IBCN,//兴业银行   BKSH,//上海银行 
NBCB,//宁波银行  NJCB,//南京银行   JSBK,//江苏银行    DLCB,//大连银行 
DEAT,//东亚银行   TZB, //台州市商业银行  BSB, //内蒙古包商银行   TLCB,//浙江泰隆银行 
ICBC//工商银行 工行 */

+ (UIImage *)bankCom : (NSString *)type
{
    UIImage *bankImage;
    if ([type isEqualToString:@"CMHO"]) {
        bankImage = [UIImage imageNamed:@"招商.png"];
    }else if([type isEqualToString:@"BOBJ"]){
        bankImage = [UIImage imageNamed:@"北京.png"];
    }else if([type isEqualToString:@"CCB"]){
        bankImage = [UIImage imageNamed:@"建设.png"];
    }else if([type isEqualToString:@"BCM"]){
        bankImage = [UIImage imageNamed:@"交通.png"];
    }else if([type isEqualToString:@"BOC"]){
        bankImage = [UIImage imageNamed:@"中国.png"];
    }else if([type isEqualToString:@"ABC"]){
        bankImage = [UIImage imageNamed:@"农业.png"];
    }else if([type isEqualToString:@"CEB"]){
        bankImage = [UIImage imageNamed:@"光大.png"];
    }else if([type isEqualToString:@"SPDB"]){
        bankImage = [UIImage imageNamed:@"浦发.png"];
    }else if([type isEqualToString:@"CGB"]){
        bankImage = [UIImage imageNamed:@"广发.png"];
    }else if([type isEqualToString:@"CTIB"]){
        bankImage = [UIImage imageNamed:@"中信.png"];
    }else if([type isEqualToString:@"CMBC"]){
        bankImage = [UIImage imageNamed:@"民生.png"];
    }else if([type isEqualToString:@"SDB"]){
        bankImage = [UIImage imageNamed:@"深发.png"];
    }else if([type isEqualToString:@"PGBC"]){
        bankImage = [UIImage imageNamed:@"平安.png"];
    }else if([type isEqualToString:@"HXB"]){
        bankImage = [UIImage imageNamed:@"华夏.png"];
    }else if([type isEqualToString:@"IBCN"]){
        bankImage = [UIImage imageNamed:@"兴业.png"];
    }else if([type isEqualToString:@"BKSH"]){
        bankImage = [UIImage imageNamed:@"上海.png"];
    }else if([type isEqualToString:@"NBCB"]){
        bankImage = [UIImage imageNamed:@"宁波.png"];
    }else if([type isEqualToString:@"NJCB"]){
        bankImage = [UIImage imageNamed:@"南京.png"];
    }else if([type isEqualToString:@"JSBK"]){
        bankImage = [UIImage imageNamed:@"江苏.png"];
    }else if([type isEqualToString:@"DLCB"]){
        bankImage = [UIImage imageNamed:@"大连.png"];
    }else if([type isEqualToString:@"DEAT"]){
        bankImage = [UIImage imageNamed:@"东亚.png"];
    }else if([type isEqualToString:@"TZB"]){
        bankImage = [UIImage imageNamed:@"台州.png"];
    }else if([type isEqualToString:@"BSB"]){
        bankImage = [UIImage imageNamed:@"包商.png"];
    }else if([type isEqualToString:@"TLCB"]){
        bankImage = [UIImage imageNamed:@"泰隆.png"];
    }else if([type isEqualToString:@"ICBC"]){
        bankImage = [UIImage imageNamed:@"工商.png"];
    }else if([type isEqualToString:@"PSBC"]){
        bankImage = [UIImage imageNamed:@"邮政.png"];
    }
    return bankImage;
}

+ (UIImage *)mobileCom : (int )type{
    UIImage *mobileImage;
    switch (type) {
        case COMCM:
            CCLog(@"aaa1");//移动
            mobileImage = [UIImage imageNamed:@"移动.png"];
            break;
        case COMCU:
            CCLog(@"bbb1");//连通
            mobileImage = [UIImage imageNamed:@"联通.png"];
            break;
        case COMCT:
            CCLog(@"ccc1");//电信
            mobileImage = [UIImage imageNamed:@"电信.png"];
            break;
        default:
            break;
    }
    return mobileImage;
}

+ (int)getType:(NSString *)mobile{
//    mobile = [mobile substringToIndex:3];
    CCLog(@"mobile first 3 =%@",mobile);

    //NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
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
    //NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ( [regextestcm evaluateWithObject:mobile]== YES)
    {
        CCLog(@"aaa0");
        return COMCM;//移动
    }else if([regextestcu evaluateWithObject:mobile] == YES){
        CCLog(@"bbb1");
        return COMCU;//联通
    }else if( [regextestct evaluateWithObject:mobile]== YES){
        CCLog(@"ccc2");
        return COMCT;//典型
    }else {
        CCLog(@"ddd3");
        return OTHENCOM;//其他
    }
    return nil;
}

+ (NSString *)getLocalToken{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"token"] == nil ? @"User_Not_Want_Receive_PushMessage." : [defaults objectForKey:@"token"];
}

+ (void)updateLocalToken:(NSString *)token{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"token"];
    [defaults synchronize];
}

+(NSString *) getDcoumentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    CCLog(@"doc = %@",documentDirectory);
    return documentDirectory;
}

+(NSString *) getCachePath{
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachedictionary = [paths objectAtIndex:0];
    return cachedictionary;
}

+(NSString *) transformDictToString:(NSMutableDictionary *) dataDict{
    NSArray *keys = [dataDict allKeys];
    NSMutableString *resultUrl = [[NSMutableString alloc] init];
    
    for (int i = 0; i< [keys count]; i++) {
        if (i > 0) {
            [resultUrl appendString:@"&"];
        }
        [resultUrl appendString:[keys objectAtIndex:i]];
        [resultUrl appendString:@"="];
        [resultUrl appendString:[dataDict objectForKey:[keys objectAtIndex:i]]];
    }
    return  resultUrl;
    
}

+(NSString *) joinParameterToUrl:(NSString *) businessUrl tradePara:(NSMutableDictionary *) tradeParam{
    
    return [NSString stringWithFormat:@"%@%@%@",BASEURL,businessUrl,[self transformDictToString:tradeParam]];
}

//把本地填写的金额乘以100，转换为分为单位
+(NSString*) transfromSendMoney:(NSString*) money{
    double fltmoney = [money doubleValue];
    fltmoney *= 100;
    
    NSNumber *number = [NSNumber numberWithDouble:fltmoney];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *returnMoney = [numberFormatter stringFromNumber:number];
    return returnMoney;
}

//把接口下载的金额除以100，转换为元为单位
+(NSString*) transfromReceiveMoney:(NSString*) money{
    double fltmoney = [money doubleValue];
    fltmoney /= 100.0;
    
    NSString *returnMoney = [NSString stringWithFormat:@"%.2f", fltmoney];
    return returnMoney;
}

+ (NSString *)encodeMD5_32:(NSString *)sourceString{
    
    const char *cStr = [sourceString UTF8String];
    
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

static Byte iv[] = {1,2,3,4,5,6,7,8};

+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key {
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    char keyChar[8] = {};
    
    int i = 0;
    for (int idx = 0; idx+2 <= key.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [key substringWithRange:range];
        int strInt = [Util stringToInt:hexStr];
        keyChar[i] = (char) strInt;
        i++;
    }
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          keyChar, kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    
    
    if (cryptStatus == kCCSuccess) {
        
        NSMutableString *mutStr = [[NSMutableString alloc] init];
        for (int i =0; i < numBytesEncrypted; i++) {
            [mutStr appendString:[self intToHex:(int)buffer[i]]];
        }
        ciphertext = mutStr;
    }
    return ciphertext;
}

+(NSString *) stringToSha1:(NSString *) oriStr{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    char cStr[256] = {};
    int i = 0;
    for (int idx = 0; idx+2 <= oriStr.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [oriStr substringWithRange:range];
        int strInt = [Util stringToInt:hexStr];
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


+(void) showMsg:(NSString *)Msg{
    if (Msg != nil && ![Msg isEqualToString:@""]) {
        UIAlertView *showMsg = [[UIAlertView alloc] initWithTitle:nil  message:Msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [showMsg show];
    }
}

+(void) showTitle:title Msg:message{
    UIAlertView *showMsg = [[UIAlertView alloc] initWithTitle:title  message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [showMsg show];
}

+(NSString*) getDayString{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMddHHmmss"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *nowString = [dateFormat stringFromDate:now];
    return nowString;
}

+(BOOL) isMoblieNumber:(NSString *) mobileNo{
    
    NSString *regex = @"(\\+86)?0?(13\\d|15[0-35-9]|18[0235-9]|14[57])\\d{8}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:mobileNo])
        return YES;
    else
        return NO;
}
//固件升级版本
+ (BOOL)needUpgradeFirmware:(NSString *)type withDevice:(NSString *)deviceId{
    if ([type rangeOfString:@"ZFT-ZXB-S"].location!= NSNotFound) {

        long long little = 21100010000001 ;//211 00 01 0000001
        long long large  = 21100010000100 ;

        CCLog(@"deviceId=%@  type =%@  ==%d",deviceId, type,deviceId.longLongValue >little);
        if (deviceId.longLongValue >=little && deviceId.longLongValue <=large) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

+(BOOL) isMoney:(NSString *)money{
    
    NSString *regex = @"^([1-9]\\d{0,7}|0)(\\.\\d{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:money])
        return YES;
    else
        return NO;
}

+(NSString *) getValueFromPlist:(NSString *) key{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"shownew.plist"];
    
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:filename])
    {
        CCLog(@"you文件");
    }
    else //若沙盒中没有
    {
        CCLog(@"创建文件");
        [file createFileAtPath:filename contents:nil attributes:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"showWeclome",@"YES",@"updateExit", nil];
        //把数据写入plist文件
        [dic writeToFile:filename atomically:YES];
        //        NSError *error;
        //        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"show" ofType:@"plist"];
        //        [file copyItemAtPath:bundle toPath:filename error:&error];
        //        CCLog(@"写入没有%d",[file copyItemAtPath:bundle toPath:filename error:&error]);
    }
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"dictionary=%@",dictionary);
    return [dictionary objectForKey:key];

}

+(NSString *) getValueFromHomePlist:(NSString *) key{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return [dictionary objectForKey:key];
}

+(void)writeValueToPlist:(NSString *)key value:(NSString *)value{
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show" ofType:@"plist"];
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)       objectAtIndex:0]stringByAppendingPathComponent:@"shownew.plist"];

    NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    [dictionary setValue:value forKey:key];
    NSLog(@"value =%@ key =%@",value, key);
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"shownew.plist"];
    Boolean a = [dictionary writeToFile:filename atomically:YES];
    CCLog(@"writevalue a= %d",a);
}

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
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    NSString *str=@"";
    if([endtmp length]<4)     {
        //        for (int x=[endtmp length]; x<4; x++) {
        //            str=[str stringByAppendingString:@"0"];
        //        }
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
        //        for (int x=[endtmp length]; x<4; x++) {
        //            str=[str stringByAppendingString:@"0"];
        //        }
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

+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        CCLog(@"hexCharStr=%@ scanner＝ %@ ",hexCharStr, scanner);
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}


+(NSString*) getSoftVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return version;
}


+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            //[regularExpression release];
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            //[regularExpression release];
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

+(BOOL) isIdNum:(NSString *)idNum{
//    /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/  15位
//    /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/ 18位
    NSString *regex =@"d{15}|d{18}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:idNum])
        return YES;
    else
        return NO;

    return nil;
    

}

+(BOOL) isChinese:(NSString *)str{
    NSString *regex =@"^[\u4E00-\u9FA5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:str]){
        return YES;
        }
    else
        return NO;
}

//火车票的开车时间加空格处理
+ (NSString *)transformTrainStartTime:(NSString *)startTime
{
    NSMutableString *combineTime = [[NSMutableString alloc] initWithString:startTime];
    [combineTime insertString:@" " atIndex:10];
    return combineTime;
}


+ (NSString *)dotMoney:(NSString*) money{
    double fltmoney = [money doubleValue];
    
    NSString *returnMoney = [NSString stringWithFormat:@"%.2f", fltmoney];
    return returnMoney;
    
}

+ (NSString *)appendYuan:(NSString *)string{
    NSString *returnStr = [NSString stringWithFormat:@"¥%@", string];

    return returnStr;
}

+ (NSString *)transDataWithPi:(NSString *)string{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"MMddHHmmss"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"MM月dd日 HH:mm:ss"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+ (NSString *)transDataWithNone:(NSString *)string{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+ (NSString *)transDataWithOri:(NSString *)string{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"MMddHHmmss"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+ (NSString *)transData:(NSString *)string{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}
//MMddHHmmss转化为类似2013-07-20 22:06:39
+ (NSString *)transDataToSepicalLongDate:(NSString *)oriStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSString *showtimeNew = [formatter stringFromDate:[NSDate date]];
    NSString *subStr = [showtimeNew substringToIndex:4];
    NSString *combineStr = [subStr stringByAppendingFormat:@"%@%@",@"-",[oriStr substringToIndex:2]];
    NSString *combineStr1 = [combineStr stringByAppendingFormat:@"%@%@",@"-",[[oriStr substringFromIndex:2] substringToIndex:2]];
    NSString *combineStr2 = [combineStr1 stringByAppendingFormat:@"%@%@",@" ",[[oriStr substringFromIndex:4] substringToIndex:2]];
    NSString *combineStr3 = [combineStr2 stringByAppendingFormat:@"%@%@",@":",[[oriStr substringFromIndex:6] substringToIndex:2]];
    NSString *combineStr4 = [combineStr3 stringByAppendingFormat:@"%@%@",@":",[[oriStr substringFromIndex:8] substringToIndex:2]];
    return combineStr4;
}
+ (NSString *)transDataLong:(NSString *)string{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+ (NSString *)transDataShort:(NSString *)string{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    CCLog(@"%@",str);
    CCLog(@"%s %d",__FUNCTION__,__LINE__);
    return str;
}
+ (NSString *)transShortDateToSepicalDate:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:string];

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}
+ (NSString *)transLengthEightToShort:(NSString *)oriStr
{
    NSString *combinestr = [[oriStr substringToIndex:4] stringByAppendingFormat:@"%@%@",@"-",[[oriStr substringFromIndex:4] substringToIndex:2]];
    NSString *combineDate = [combinestr stringByAppendingFormat:@"%@%@",@"-",[[oriStr substringFromIndex:6] substringToIndex:2]];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:combineDate];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    CCLog(@"%@",str);
    return str;
}
+ (NSString *)transLengthEightToYYYYMMddDate:(NSString *)oriStr
{
    NSString *combinestr = [[oriStr substringToIndex:4] stringByAppendingFormat:@"%@%@",@"-",[[oriStr substringFromIndex:4] substringToIndex:2]];
    NSString *combineDate = [combinestr stringByAppendingFormat:@"%@%@",@"-",[[oriStr substringFromIndex:6] substringToIndex:2]];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:combineDate];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}
+ (NSString *)transShortDateToYYMMDatestr:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

/*
 *将2013-12-24 14:26:46日期转换成交易详情中指定格式2013.12.24 14:26
 */
+ (NSString *)transLongDateToDetailFormat:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    if (string.length == 10) {
        [inputFormatter setDateFormat:@"MMddHHmmss"];
    }else{
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }

    NSDate *inputDate = [inputFormatter dateFromString:string];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    if (string.length == 10) {
        [outputFormatter setDateFormat:@"MM.dd  HH:mm"];
    }else{
        [outputFormatter setDateFormat:@"yyyy.MM.dd  HH:mm"];
    }
    NSString *str = [outputFormatter stringFromDate:inputDate];
    CCLog(@"%@",str);
    return str;
}
/*
 *将2013-12-24日期转换成交易详情中指定格式2013.12.24
 */
+ (NSString *)transShortDateToDetailFormat:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    CCLog(@"%@",str);
    return str;
}


+ (NSString *)transDotShort:(NSString *)string{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+(NSString *)errorMsg:(NSString *)cpscod{
    NSString *backMsg;
    if ([cpscod isEqualToString:@"01"]) {
        backMsg = @"请持卡人与发卡银行联系";
    }else if ([cpscod isEqualToString:@"03"]){
        backMsg = @"无效商户";
    }else if ([cpscod isEqualToString:@"04"]||[cpscod isEqualToString:@"05"]||[cpscod isEqualToString:@"34"]||[cpscod isEqualToString:@"35"]||[cpscod isEqualToString:@"36"]||[cpscod isEqualToString:@"37"]||[cpscod isEqualToString:@"41"]||[cpscod isEqualToString:@"43"]||[cpscod isEqualToString:@"59"]||[cpscod isEqualToString:@"60"]||[cpscod isEqualToString:@"63"]||[cpscod isEqualToString:@"67"]){
        backMsg = @"卡bin信息异常，请联系客服";
    }else if ([cpscod isEqualToString:@"09"]) {
        backMsg = @"请求正在处理中,请重新提交交易";
    }else if ([cpscod isEqualToString:@"12"]){
        backMsg = @"无效交易";
    }else if ([cpscod isEqualToString:@"13"]){
        backMsg = @"无效金额";
    }else if ([cpscod isEqualToString:@"14"]){
        backMsg = @"无效卡号";
    }else if ([cpscod isEqualToString:@"15"]){
        backMsg = @"此卡无对应发卡方";
    }else if ([cpscod isEqualToString:@"16"]){
        backMsg = @"无此发卡行，请咨询发卡行";
    }else if ([cpscod isEqualToString:@"17"]){
        backMsg = @"争议金额不符，交易取消";
    }else if([cpscod isEqualToString:@"19"]){
        backMsg = @"刷卡读取数据有误，请重新刷卡";
    }else if([cpscod isEqualToString:@"20"]){
        backMsg = @"无效应答";
    }else if ([cpscod isEqualToString:@"22"]){
        backMsg = @"无效商户";
    }else if ([cpscod isEqualToString:@"23"]){
        backMsg = @"不可接受的交易费";
    }else if([cpscod isEqualToString:@"25"]){
        backMsg = @"无原始交易，请联系发卡行";
    }else if([cpscod isEqualToString:@"30"]){
        backMsg = @"交易失败，请联系客服";
    }else if([cpscod isEqualToString:@"31"]){
        backMsg = @"此卡不能受理";
    }else if([cpscod isEqualToString:@"33"]){
        backMsg = @"您的银行卡已过期";
    }else if([cpscod isEqualToString:@"38"]){
        backMsg = @"密码错误次数超限";
    }else if([cpscod isEqualToString:@"39"]){
        backMsg = @"无此信用卡账户";
    }else if([cpscod isEqualToString:@"40"]){
        backMsg = @"不支持的交易类型";
    }else if([cpscod isEqualToString:@"42"]){
        backMsg = @"无此帐户";
    }else if([cpscod isEqualToString:@"44"]){
        backMsg = @"无此投资账户";
    }else if([cpscod isEqualToString:@"51"]){
        backMsg = @"余额不足，请查询";
    }else if([cpscod isEqualToString:@"52"]){
        backMsg = @"无此支票账户";
    }else if([cpscod isEqualToString:@"53"]){
        backMsg = @"无此储蓄卡账户";
    }else if([cpscod isEqualToString:@"54"]){
        backMsg = @"过期卡，请联系发卡行";
    }else if([cpscod isEqualToString:@"55"]){
        backMsg = @"密码错误";
    }else if([cpscod isEqualToString:@"56"]){
        backMsg = @"无此卡记录";
    }else if([cpscod isEqualToString:@"57"]){
        backMsg = @"交易失败，请联系发卡行";
    }else if([cpscod isEqualToString:@"58"]){
        backMsg = @"终端无效，请联系收单行或银联";
    }else if([cpscod isEqualToString:@"61"]){
        backMsg = @"超出金额限制";
    }else if([cpscod isEqualToString:@"62"]){
        backMsg = @"您的银行卡为受限制的卡";
    }else if([cpscod isEqualToString:@"64"]){
        backMsg = @"原始金额与原交易不匹配,请尝试重新支付";
    }else if([cpscod isEqualToString:@"65"]){
        backMsg = @"超出消费次数限制";
    }else if([cpscod isEqualToString:@"66"]){
        backMsg = @"交易失败，请联系收单行或银联";
    }else if([cpscod isEqualToString:@"68"]){
        backMsg = @"交易超时";
    }else if([cpscod isEqualToString:@"75"]){
        backMsg = @"密码错误次数超限";
    }else if([cpscod isEqualToString:@"90"]){
        backMsg = @"交易失败，请联系收单行或银联";
    }else if([cpscod isEqualToString:@"91"]){
        backMsg = @"发卡状态不正常";
    }else if([cpscod isEqualToString:@"92"]){
        backMsg = @"交易失败，请联系客服";
    }else if([cpscod isEqualToString:@"93"]){
        backMsg = @"交易违法，不能完成";
    }else if([cpscod isEqualToString:@"94"]){
        backMsg = @"被拒绝，重复交易";
    }else if([cpscod isEqualToString:@"96"]){
        backMsg = @"被拒绝，系统出错";
    }else if([cpscod isEqualToString:@"97"]){
        backMsg = @"终端未登记";
    }else if([cpscod isEqualToString:@"98"]){
        backMsg = @"交易超时";
    }else if([cpscod isEqualToString:@"99"]){
        backMsg = @"校验错,请重新签到";
    }else if([cpscod isEqualToString:@"A0"]){
        backMsg = @"校验错,请重新签到";
    }else if([cpscod isEqualToString:@"P0"]){
        backMsg = @"购电成功，但是没有写卡数据，可以尝试补写卡";
    }else if([cpscod isEqualToString:@"P4"]){
        backMsg = @"账务时间，暂停交易";
    }else if([cpscod isEqualToString:@"P5"]){
        backMsg = @"扣款成功，写表失败";
    }else if([cpscod isEqualToString:@"P6"]){
        backMsg = @"第三方错误";
    }else if([cpscod isEqualToString:@"P7"]){
        backMsg = @"卡信息有误";
    }else if([cpscod isEqualToString:@"Q2"]){
        backMsg = @"交易遇到问题，请联系客服解决";
    }else if([cpscod isEqualToString:@"LD"]){
        backMsg = @"交易遇到问题，请联系客服解决";
    }
    return backMsg;
}

+(NSString *)chargeAmount:(int)dealCharge{
    int length = [[NSString stringWithFormat:@"%d",dealCharge] length];
    NSLog(@"dealchareg= %d  lenth =%d",dealCharge, length);
    //32 6
    NSMutableString *resultStr = [NSMutableString stringWithString:@""];
    NSLog(@"str = %@",resultStr);
    for (int i = length; i<8; i++) {
        [resultStr appendString:@"0"];
    }
    [resultStr appendFormat:@"%d",dealCharge];
    NSLog(@"chargeAmount=%@",[NSString stringWithFormat:@"%@",resultStr]);
    return  [NSString stringWithFormat:@"%@",resultStr];
}

//16转10进制
+(NSString *)changeToInt:(NSString *)num{
    NSString *result10 = [NSString stringWithFormat:@"%ld",strtoul([num UTF8String], 0, 16)];
    return result10;
}

//10转16进制
+(NSString *)changeToHet:(int)num{
    NSString *result16 = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%1x",num]];
    return result16;
}

+(void)alertHelp:(NSString *)temstr{
    
    if (temstr == nil || temstr == NULL) {
        dispatch_async(dispatch_get_main_queue(),^{
            [Util showMsg:@"获取信息失败"];
            CCLog(@"获取%@错误",temstr);
        });
        return;
    }
}

+(NSString *)getTLVwithTag:(NSString *)tag andStr:(NSString *)string andLengh:(NSInteger )temLen{
    NSString *result;
    NSRange range ;

    do {
        range = [string rangeOfString:tag options:NSCaseInsensitiveSearch];
        if (range.location%2!=0) {
            string = [string substringFromIndex:(range.location+range.length+1)];
            CCLog(@"tlv string =%@",string);
        }
    } while (range.location%2!=0);
    
    NSString *lenStr = [self changeToInt:[string substringWithRange:NSMakeRange(range.location+range.length, 2)]];
    
    NSUInteger length = [lenStr integerValue]*2;
    CCLog(@"length=%lu --- %@",(unsigned long)length, [string substringWithRange:NSMakeRange(range.location+range.length, 2)]);
    
    result  = [string substringWithRange:NSMakeRange(range.location+range.length+2, length)];
    
    CCLog(@"result end=%@",result);
  
    return result;
    
}


+(NSString *)getLVwithTag:(NSString *)tag andStr:(NSString *)string andLengh:(NSInteger )temLen{
    NSString *result;
    NSRange range = [string rangeOfString:tag options:NSCaseInsensitiveSearch];
    NSString *lenStr = [self changeToInt:[string substringWithRange:NSMakeRange(range.location+range.length, 2)]];
    
    NSUInteger length = [lenStr integerValue]*2+2;
    CCLog(@"**length=%lu --- %@",(unsigned long)length, [string substringWithRange:NSMakeRange(range.location+range.length, 2)]);
    
    result  = [string substringWithRange:NSMakeRange(range.location+range.length, length)];
    CCLog(@"**result end=%@",result);
        
    return result;
}

+(NSString *)getTLVfromByte:(NSString *)tlvString andTag:(NSString *)tag{
    //不用处理
    //tlvString  = [tlvString substringFromIndex:14];
    
    NSData *tlvData  = [tlvString HexToData];
    Byte *tlvByte = (Byte *)[tlvData bytes];
    NSLog(@"tlvData lenght=%d\n",tlvData.length);
    for(int i=0;i<[tlvData length];i++)
        printf("%d ",tlvByte[i]);
    
    NSData *tagData = [tag HexToData];
    Byte *tagByte = (Byte *)[tagData bytes];
    
    NSLog(@"tagData lenght=%d",tagData.length);
    
    for(int i=0;i<[tagData length];i++)
        printf("tagByte = %d\n",tagByte[i]);
    
    if (tlvByte == nil||tlvData.length<=0 ) {
        return nil;
    }
    if (tagByte == nil ||tagData.length <=0 ) {
        return nil;
    }
    BOOL flag = YES;
    int dataIndex = 0;
    int dataIndexTemp = 0;
    NSString *resultStr =nil;
    int valueLength = 0;
    
    while (flag) {
        // 下标大于等于传进来的数据长度，则已经遍历完成 -2是为去掉tag，len的最小值
        if (dataIndex >= tlvData.length-1-1) {
            break;
        }
        /**
         * 从第一个字节开始判断 看tag值占几个字节
         *
         * 从第一个TLV开始校验 直到获取到第一个T中的V为止
         **/
        
        Byte firstTag = tlvByte[dataIndex];
        NSLog(@"tag %d",firstTag);
        if ((firstTag&0x1f)==0x1f) {// 说明Tag值占用两个字节
            dataIndexTemp = 2;       //该tag值的value长度
            NSLog(@"dataIndexTemp=%d",dataIndexTemp);
            valueLength = (int)tlvByte[dataIndex+2];
            NSLog(@"valueLength=%d",valueLength);
            if (tagData.length <2) {
                dataIndex +=2+1+valueLength;   //2+1+valueLength;
                NSLog(@"dataIndex=%d",dataIndex);
            }else{
                if ((tlvByte [dataIndex] ==tagByte[0])&&(tlvByte[dataIndex+1]== tagByte[1])) {
                    if (tlvData.length>= dataIndex+2+1+valueLength) {
                        Byte resultDatasTemp [valueLength+1];
                        for (int i = 0; i< valueLength+1; i++) {
                            resultDatasTemp[i] = tlvByte[dataIndex +2+i]; //[dataIndex +2+1+i]
                            NSLog(@"resultDatasTemp=%d",resultDatasTemp[i]);
                        }
                        resultStr = [self byteToString:resultDatasTemp andLength:valueLength+1];
                    }
                    break;
                }else{
                    dataIndex += 2+1+valueLength;
                }
            }
        }else{
            if (tagData.length == 2){
                // 请求的tag值是两个字节的，还是没有获取到Tag对应的值，值增加数据的下标
                valueLength  = (int)tlvByte[dataIndex+1];
                NSLog(@"valueLength=%d",valueLength);
                dataIndexTemp = valueLength;
                dataIndex +=  dataIndexTemp + 2;
            }else{
                if (tlvByte [dataIndex] == tagByte[0]) {
                    valueLength = (int)tlvByte[dataIndex+1];
                    NSLog(@"valueLength=%d",valueLength);
                    if (tlvData.length >= dataIndex+2+valueLength) {
                        Byte resultDatasTemp[valueLength+1];
                        for (int i = 0; i<valueLength+1; i++) {
                            resultDatasTemp[i] = tlvByte[dataIndex+1+i]; //[dataIndex+2+i]
                            NSLog(@"resultDatasTemp=%d",resultDatasTemp[i]);
                        }
                        resultStr = [self byteToString:resultDatasTemp andLength:valueLength+1];
                        
                    }
                    break;
                }else{
                    // 还是没有获取到Tag对应的值
                    valueLength = (int)tlvByte[dataIndex+1];
                    NSLog(@"valueLength=%d",valueLength);
                    dataIndexTemp = valueLength;
                    dataIndex+= dataIndexTemp+2;
                    NSLog(@"dataIndex=%d",dataIndex);
                }
            }
        }
    }
    
    NSLog(@"valueLength=%d resultStr=%@",valueLength+1,resultStr);
    
    return resultStr;
}

+(NSString *)byteToString:(Byte *)byte  andLength:(int )length{
    
    NSString *hexStr=@"";
    
    for (int i = 0; i< length; i++) {
        
        NSString *newHexStr = [NSString stringWithFormat:@"%x",byte[i]&0xff];///16进制数
        NSLog(@"newHexStr=%@ byte=%d",newHexStr,byte[i]);
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+(NSString *)getCardSd:(NSString *)temStr{
    NSString *result = temStr;
    CCLog(@"temStr=%@",temStr);
    do {
        result = [result stringByAppendingString:@"F"];
    } while (result.length!= 172);
    
    CCLog(@"result =%@, lenght =%d",result,result.length);
    return result;
}

+ (NSString *)getCurrentTime:(int)data
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    if (data ==1) {
        [dateFormatter setDateFormat:@"YYMMdd"];
    }else{
        [dateFormatter setDateFormat:@"HHmmss"];
    }
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    CCLog(@"时间为:%@",currentDateStr);
    
    return  currentDateStr;
}

+ (NSString *)getAlichargeCardno:(NSString *)cardMsgStr{
    NSString *resultStr;
    if ([cardMsgStr rangeOfString:@"|"].location!=NSNotFound) {
        NSArray *aliArray = [cardMsgStr componentsSeparatedByString:@"|"];
        NSString *str = [aliArray objectAtIndex:0];
        if ([str rangeOfString:@"."].location!=NSNotFound) {
            resultStr = [[str componentsSeparatedByString:@"."] objectAtIndex:0];
        }
    }
    return resultStr;
}

+ (NSString *)getBussString:(NSString *)busType{
    NSString *retStr;
    
    if ([busType isEqualToString:@"1001"]) {
        retStr = @"手机充值";
    }else if([busType isEqualToString:@"1002"]){
        retStr = @"购买支付宝卡";
    }else if([busType isEqualToString:@"1003"]){
        retStr = @"支付宝订单";
    }else if([busType isEqualToString:@"1004"]){
        retStr = @"信用卡还款";
    }else if([busType isEqualToString:@"1005"]){
        retStr = @"银行卡转账";
    }else if([busType isEqualToString:@"1006"]){
        retStr = @"银行卡查询";
    }else if([busType isEqualToString:@"1007"]){
        retStr = @"水费";
    }else if([busType isEqualToString:@"1008"]){
        retStr = @"网络购电";
    }else if([busType isEqualToString:@"1009"]){
        retStr = @"燃气费";
    }else if([busType isEqualToString:@"1010"]){
        retStr = @"供暖费";
    }else if([busType isEqualToString:@"1011"]){
        retStr = @"通讯费";
    }else if([busType isEqualToString:@"1012"]){
        retStr = @"IC卡购电";
    }else if([busType isEqualToString:@"1013"]){
        retStr = @"金融IC卡";
    }else if([busType isEqualToString:@"1014"]){
        retStr = @"交享卡";
    }else if([busType isEqualToString:@"1015"]){
        retStr = @"ETC充值";
    }else if([busType isEqualToString:@"1016"]){
        retStr = @"游戏点卡";
    }else if([busType isEqualToString:@"1017"]){
        retStr = @"火车票";
    }else if([busType isEqualToString:@"1018"]){
        retStr = @"二维码";
    }
    return retStr;
}

+ (NSString *)getBussType:(NSString *)busString{
    NSString *retStr;
    
    if ([busString isEqualToString:@"手机充值"]) {
        retStr = @"1001";
    }else if([busString isEqualToString:@"购买支付宝卡"]){
        retStr = @"1002";
    }else if([busString isEqualToString:@"支付宝订单支付"]){
        retStr = @"1003";
    }else if([busString isEqualToString:@"信用卡还款"]){
        retStr = @"1004";
    }else if([busString isEqualToString:@"银行卡转账"]){
        retStr = @"1005";
    }else if([busString isEqualToString:@"银行卡查询"]){
        retStr = @"1006";
    }else if([busString isEqualToString:@"水费"]||[busString isEqualToString:@"水费缴费"]){
        retStr = @"1007";
    }else if([busString isEqualToString:@"网络购电缴费"]){
        retStr = @"1008";
    }else if([busString isEqualToString:@"燃气费"]||[busString isEqualToString:@"燃气费缴费"]){
        retStr = @"1009";
    }else if([busString isEqualToString:@"供暖费"]||[busString isEqualToString:@"热力缴费"]){
        retStr = @"1010";
    }else if([busString isEqualToString:@"通讯费缴费"]|[busString isEqualToString:@"通讯费"]){
        retStr = @"1011";
    }else if([busString isEqualToString:@"IC购电"]){
        retStr = @"1012";
    }else if([busString isEqualToString:@"金融IC卡"]){
        retStr = @"1013";
    }else if([busString isEqualToString:@"交享卡"]){
        retStr = @"1014";
    }else if([busString isEqualToString:@"ETC速通卡"]|[busString isEqualToString:@"ETC充值"]){
        retStr = @"1015";
    }else if([busString isEqualToString:@"游戏点卡"]||[busString isEqualToString:@"游戏点卡充值"]){
        retStr = @"1016";
    }else if([busString isEqualToString:@"购买火车票"]){//trian_icon.png
        retStr = @"1017";
    }else if([busString isEqualToString:@"二维码"]){
        retStr = @"1018";
    }
    else if ([busString isEqualToString:@"特约商户交易"]){
        retStr = @"record_merchant_icon";
    }
    else if ([busString isEqualToString:@"水电燃缴费"]){
        retStr = @"水电燃热";
    }
    return retStr;
}
+ (NSString *)getTrainSeatType:(NSString *)trainTag{
    NSString *seatStr;
    if([trainTag isEqualToString:@"6"]){
        seatStr = @"高软";
    }else if([trainTag isEqualToString:@"O"]){
        seatStr = @"二等";
    }else if([trainTag isEqualToString:@"M"]){
        seatStr = @"一等";
    }else if([trainTag isEqualToString:@"1"]){
        seatStr = @"硬座";
    }else if([trainTag isEqualToString:@"3"]){
        seatStr = @"硬卧";
    }else if([trainTag isEqualToString:@"4"]){
        seatStr = @"软卧";
    }else if([trainTag isEqualToString:@"9"]){
        seatStr = @"商务";
    }else if([trainTag isEqualToString:@"P"]){
        seatStr = @"特等";
    }else if([trainTag isEqualToString:@"WZ"]){
        seatStr = @"无座";
    }
    return seatStr;
}

+ (NSString *)getTrainTag:(NSString *)trainSeatType{
    NSString *trainTag;
    if([trainSeatType isEqualToString:@"高软"]){
        trainTag = @"6";
    }else if([trainSeatType isEqualToString:@"二等"]){
        trainTag = @"O";
    }else if([trainSeatType isEqualToString:@"一等"]){
        trainTag = @"M";
    }else if([trainSeatType isEqualToString:@"硬座"]){
        trainTag = @"1";
    }else if([trainSeatType isEqualToString:@"硬卧"]){
        trainTag = @"3";
    }else if([trainSeatType isEqualToString:@"软卧"]){
        trainTag = @"4";
    }else if([trainSeatType isEqualToString:@"商务"]){
        trainTag = @"9";
    }else if([trainSeatType isEqualToString:@"特等"]){
        trainTag = @"P";
    }else if([trainSeatType isEqualToString:@"无座"]){
        trainTag = @"WZ";
    }
    return trainTag;
}

+ (NSString *)getCardTag:(NSString *)cardType{
    NSString *cardTagStr;
    if([cardType isEqualToString:@"二代身份证"]){
        cardTagStr = @"1";
    }else if([cardType isEqualToString:@"一代身份证"]){
        cardTagStr = @"2";
    }else if([cardType isEqualToString:@"港澳通行证"]){
        cardTagStr = @"C";
    }else if([cardType isEqualToString:@"台湾通行证"]){
        cardTagStr = @"G";
    }else if([cardType isEqualToString:@"护照"]){
        cardTagStr = @"B";
    }
    return cardTagStr;
}

+ (NSString *)getTicketType:(NSString *)ticketTag{
    NSString *ticketTypeStr;
    if([ticketTag isEqualToString:@"1"]){
        ticketTypeStr = @"成人";
    }else if([ticketTag isEqualToString:@"2"]){
        ticketTypeStr = @"儿童";
    }else if([ticketTag isEqualToString:@"4"]){
        ticketTypeStr = @"残军";
    }
    return ticketTypeStr;
}

+ (NSString *)getTicketTag:(NSString *)ticketType{
    NSString *ticketTagStr;
    if([ticketType isEqualToString:@"成人票"]){
        ticketTagStr = @"1";
    }else if([ticketType isEqualToString:@"儿童票"]){
        ticketTagStr = @"2";
    }else if([ticketType isEqualToString:@"残军票"]){
        ticketTagStr = @"4";
    }
    return ticketTagStr;
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{

    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    if ([date compare:endDate] == NSOrderedSame)
        return NO;
    return YES;
}

+ (NSDate *)getDateFromString:(NSString *)temStr{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *resultDate = [inputFormatter dateFromString:temStr];
    return resultDate;
}

+ (NSString *)getStringFromDate:(NSDate *)temDate{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *resultStr = [inputFormatter stringFromDate:temDate];
    return resultStr;
}

+ (NSDate *)getNextOrPreDateFromString:(NSString *)temStr andInt: (int)nextOrPre{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //[inputFormatter setLocale:[NSLocale currentLocale]]; //[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *temDate = [inputFormatter dateFromString:temStr];
    NSLog(@"temDate=%@",temDate);

    if (nextOrPre == 0) {
        temDate = [NSDate dateWithTimeInterval:-60*60*24*1 sinceDate:temDate];
    }else{
        temDate = [NSDate dateWithTimeInterval:60*60*24*1 sinceDate:temDate];
    }
    return temDate;
}

+ (NSMutableArray *)getTrainSeatTypeArray:(NSString *)seatTypeStr{
    //   WZ,474/4,4/1,214/3,19
    NSArray * temArray = [seatTypeStr componentsSeparatedByString:@"/"];
    NSMutableArray *reslutArray = [NSMutableArray array];
    for (int i=0; i< temArray.count; i++) {
        NSString *key  = [[[temArray objectAtIndex:i] componentsSeparatedByString:@","] objectAtIndex:0];
        NSString *value  = [[[temArray objectAtIndex:i] componentsSeparatedByString:@","] objectAtIndex:1];
        NSDictionary *temDic = [NSDictionary dictionaryWithObject:value forKey:key];
        [reslutArray addObject:temDic];
    }

    return reslutArray;
}

+ (NSString *)getRspMsg:(NSString *)rspcod{
    NSString *resultStr;
    if([rspcod isEqualToString:@"F0008"]||[rspcod isEqualToString:@"F0009"]||[rspcod isEqualToString:@"F0010"]||[rspcod isEqualToString:@"F0015"]||[rspcod isEqualToString:@"F9993"]||[rspcod isEqualToString:@"F9994"]||[rspcod isEqualToString:@"F9995"]){
        resultStr = @"交易超时，请查询后再尝试！";
    }else if([rspcod isEqualToString:@"F0014"]||[rspcod isEqualToString:@"F9996"]||[rspcod isEqualToString:@"F9997"]||[rspcod isEqualToString:@"F9998"]||[rspcod isEqualToString:@"F0014"]){
        resultStr = @"交易失败，请查询后再尝试！";
    }else if([rspcod isEqualToString:@"F9999"]){
        resultStr = @"系统错误，请查询后再尝试！";
    }else if([rspcod isEqualToString:@"F0026"]){
        resultStr = @"银行卡磁密信息获取失败，请稍后再试！";
    }
    
    return resultStr;
}
+ (BOOL )isTransRspCod:(NSString *)rspcod{
    if([rspcod isEqualToString:@"F0008"]||[rspcod isEqualToString:@"F0009"]||[rspcod isEqualToString:@"F0010"]||[rspcod isEqualToString:@"F0015"]||[rspcod isEqualToString:@"F9993"]||[rspcod isEqualToString:@"F9994"]||[rspcod isEqualToString:@"F9995"]||[rspcod isEqualToString:@"F0014"]||[rspcod isEqualToString:@"F9996"]||[rspcod isEqualToString:@"F9997"]||[rspcod isEqualToString:@"F9998"]||[rspcod isEqualToString:@"F0014"]||[rspcod isEqualToString:@"F9999"]||[rspcod isEqualToString:@"F0026"]){
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)getVersionInteger{
    
    NSString  *strVersion = [[[NSString  stringWithFormat:@"%@",CurVervionString] substringWithRange:NSMakeRange(0,1)]  stringByAppendingString:@".0"] ;
    
    return strVersion;
}

+(UIImage*) getImageByString:(NSString *)string
{
    NSData *data = [GTMBase64 decodeString:string];
    
    // data  = Decode3DESWithKey(data);
    
    UIImage *resImage = [UIImage imageWithData:data];
    return resImage;

}

+ (NSDate *)getNowDate
{
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

+ (BOOL)getRspCode:(NSDictionary *)dict{
    BOOL code = NO;
    if ([[dict objectForKey:@"RSPCD"] isKindOfClass:[NSNull class]]) {
        code = YES;
        NSLog(@"%s %d",__FUNCTION__,__LINE__);
    }
    if ([dict objectForKey:@"rsp_code"] == nil && ![[dict objectForKey:@"RSPCD"] isEqualToString:@"00"]) {
        code = YES;
        NSLog(@"%s %d",__FUNCTION__,__LINE__);
    }
    if ([dict objectForKey:@"RSPCD"] == nil && ![[dict objectForKey:@"rsp_code"] isEqualToString:@"0000"]) {
        code = YES;
        NSLog(@"%s %d",__FUNCTION__,__LINE__);
    }
    return code;
}


+ (NSDictionary *)dictionaryFromString:(NSString *)str
{
    NSArray *arr = [str componentsSeparatedByString:@";"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:10];
    for (int i = 0; i<[arr count]; i++) {
        NSArray *arrI = [NSArray arrayWithArray:[[arr objectAtIndex:i] componentsSeparatedByString:@"="]];
        [dict setObject:[arrI objectAtIndex:1] forKey:[arrI objectAtIndex:0]];
    }
    return dict;
}

@end
