//
//  NNString.m
//  AllBelieve
//
//  Created by fengxiaoguang on 14-3-25.
//  Copyright (c) 2014年 aaa. All rights reserved.
//

#import "NNString.h"

@implementation NNString

+ (NSString *)getRightString_BysortArray_dic:(NSDictionary *)dic
{
    NSMutableString *rightString =[NSMutableString stringWithString:@""];
    
    NSArray *_sortedArray= [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    NSLog(@"排序后:%@",_sortedArray);
    
    for (NSString *key in _sortedArray)
    {
        
        [rightString appendFormat:@"%@",[dic objectForKey:key]];
        
    }
    return rightString;
}
+(NSString*)delStringNull:(id)object
{
    
    if ([object isEqual:[NSNull null]])
    {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if (object==nil)
    {
        return @"";
    }
    return object;
    
}
+(NSMutableDictionary* )delStringNullOfDictionary:(NSDictionary *)object
{
    NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
    
    for (NSString *key in object)
    {
        [Dict setObject:[self delStringNull:[object objectForKey:key]] forKey:key];
    }
    
    return Dict;
}
+(NSString *) getStringUTF8ToGBK:(NSString *) string
{
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *) getStringGBKToUTF8:(NSString *) string{
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSData *) getDataFromString:(NSString *) string encoding:(NSStringEncoding)encoding{
    //NSUTF32BigEndianStringEncoding
    return [string dataUsingEncoding:encoding];
}

+(NSString *) addPrefix:(NSString *) prefix withString:(NSString *) str{
    return [NSString stringWithFormat:@"%@%@",prefix,str];
}

+(NSString *) addSuffix:(NSString *) suffix withString:(NSString *) str{
    return [NSString stringWithFormat:@"%@%@",str,suffix];
}

+(CGSize)getTextSizeByString:(NSString *) string byFont:(UIFont *) font{
    return [string sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
}

+(CGSize)getTextSizeByString:(NSString *) string byFont:(UIFont *) font bySize:(CGSize) size{
    return [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail];
}

+(NSArray *)splitString:(NSString*) string withStr:(NSString*)str{
    return [string componentsSeparatedByString:str];
}

+(NSString *)getSubStringWithString:(NSString *) string from:(NSInteger)start to:(NSInteger)end{
    return  [string substringWithRange:NSMakeRange(start, end)];
}
+(BOOL)isNumber:(char)c
{
    for(int i=0;i<10;i++)
    {
        if (i==c-'0')
        {
            return YES;
        }
    }
    return NO;
    
}

+(NSString *)getQianFenFu:(NSString *)price
{
    
    if(!price)
    {
        return @"";
    }
    BOOL isfushu=NO;
    
    if ([price characterAtIndex:0]=='-')
    {
        isfushu=YES;
        price=[price substringFromIndex:1];
    }
    
    NSArray* array=[price componentsSeparatedByString:@"."];
    price=[array objectAtIndex:0];
    
    
    if([self isNumber:[price characterAtIndex:0]])
    {
        
        NSMutableString *sb;
        NSString *oldPrice=price;
        int x=[oldPrice length]%3;
        int xx=[oldPrice length]/3;
        sb=[[NSMutableString alloc]init];
        NSString *s1=[[oldPrice substringToIndex:x]stringByAppendingFormat:@","];
        [sb appendString:s1];
        for(int i=0;i<xx;i++)
        {
            [sb appendString:[[oldPrice substringWithRange:NSMakeRange((x+(3*i)),3)]stringByAppendingFormat:@","]];
        }
        NSString *str=[NSString stringWithFormat:@"%@",sb];
        for (int i=0; i<[str length]; i++)
        {
            char c1=[str characterAtIndex:0];
            char c2=[str characterAtIndex:[str length]-1];
            if([self isNumber:c1] && [self isNumber:c2])
            {
            }
            else if([self isNumber:c1])
            {
                str =[str substringWithRange:NSMakeRange(0, [str length]-1)];
            }
            else if([self isNumber:c2])
            {
                str =[str substringWithRange:NSMakeRange(1, [str length])];
            }
            else
            {
                str =[str substringWithRange:NSMakeRange(1, [str length]-1)];
            }
        }
        for (int i=1;i<[array count] ;i++)
        {
            
            str=[[str stringByAppendingString:@"." ] stringByAppendingString:[array objectAtIndex:i]];
        }
        if (isfushu)
        {
            str=[@"-" stringByAppendingString:str];
        }
        return str;
    }
    return @"";
}
+(NSString *)delQianFenFu:(NSString *)price
{
    
    NSArray* array=[price componentsSeparatedByString:@","];
   
    NSString* str=[[NSString alloc]init];
    for (int i=0;i<[array count] ;i++)
    {
        
        str=[str stringByAppendingString:[array objectAtIndex:i]];
       
    }
    return str;
}

+ (NSString *) getCurrentTimeWithSpecialFormat:(NSString* )string
{
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:string];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //CCLog(@"时间为:%@",currentDateStr);
    return  currentDateStr;
}
@end
