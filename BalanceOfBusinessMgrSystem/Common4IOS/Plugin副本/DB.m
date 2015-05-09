//
//  DB.m
//  SQL
//
//  Created by 孙朋贞 on 12-3-19.
//

#import "DB.h"

#define kDataBaseName @"TradeHistory.sqlite"

//数据库类 主要用于打开以及关闭数据库。
static sqlite3 *db = nil;
@implementation DB


+ (sqlite3 *)openDB//打开数据库
{
    if(db)
    {
        return db;
    }
    //原文件路径
    NSString *originFilePath = [[NSBundle mainBundle] pathForResource:@"TradeHistory" ofType:@"sqlite"];
    //目的路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *targetFilePath = [docPath stringByAppendingPathComponent:kDataBaseName];
    CCLog(@"记录数据库地址%@",targetFilePath);
    //创建文件管理器，对文件进行copy操作
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:targetFilePath];
    if(!isExist)//document下面没有数据库文件
    {
        CCLog(@"添加数据库文件TradeHistory.sqlite");
        BOOL cp = [fm copyItemAtPath:originFilePath toPath:targetFilePath error:nil];
        CCLog(@"cp = %d",cp);
    }
    CCLog(@"isExist =%d",isExist);
    //打开数据库，将数据库地址赋值给指针db
    sqlite3_open([targetFilePath UTF8String], &db);
    return db;
}
+ (void)closeDB//关闭数据库
{
    if(db)
    {
        sqlite3_close(db);
    }
}


@end
