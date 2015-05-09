//
//  TransDB.m
//  ipaycard
//
//  Created by fei on 13-5-17.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "TransDB.h"

@implementation TransDB

static  FMDatabase *db;

+(FMDatabase *) openDatabase{
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"banktrans.sqlite"];
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"banktrans" ofType:@"sqlite"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:sqlPath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
    {
        
        NSError *err = nil;
        if([fm copyItemAtPath:orignFilePath toPath:sqlPath error:&err] == NO)//如果拷贝失败
        {
            CCLog(@"open database error %@",[err localizedDescription]);
            return nil;
        }else{
            CCLog(@"拷贝成功");
        }
        
        CCLog(@"document 下没有数据库文件，执行拷贝工作");
    }
    
    //初始化数据库
    db=[FMDatabase databaseWithPath:sqlPath];
    
    //这个方法一定要执行
    if (![db open]) {
        
        CCLog(@"数据库打开失败！");
        return db;
    }else{
        CCLog(@"数据库打开成功");
    }
    
    return  db;
}

+ (void) insertTransData:(DJYBankTransferData *) aData{
    
    CCLog(@"传入的待插入数据为 %@ %@ %@ %@ %@",aData.name,aData.bankCode, aData.cardNum , aData.handingFeeRate, aData.bankName);
        
    FMDatabase *db =[self openDatabase];
    
    if (![db tableExists:@"banktrans"]) {
        
        NSString *sql =@"CREATE TABLE IF NOT EXISTS banktrans(trans_id INTEGER PRIMARY KEY  AUTOINCREMENT, name TEXT, code TEXT , cardno TEXT, feetext TEXT, bankname TEXT) ";

        [db executeUpdate:sql];
    }
    
    FMResultSet *rs  = [db executeQuery:@"SELECT * FROM banktrans WHERE cardno = ?",[NSString stringWithFormat:@"%@",aData.cardNum] ];
    

    if ([rs next]) {
        CCLog(@"aaaaaaaaaaaaa");
        
        [db beginTransaction];

        [db executeUpdate:@"UPDATE banktrans SET name = ?, code = ? ,feetext = ? , bankname =? WHERE cardno = %@",aData.name, aData.bankCode, aData.handingFeeRate ,aData.bankName , aData.cardNum ];
        [db commit];
    }else{
        [db beginTransaction];

        [db executeUpdate:@"INSERT INTO banktrans(name,code,cardno,feetext,bankname) VALUES(?,?,?,?,?)",aData.name,aData.bankCode,aData.cardNum, aData.handingFeeRate,aData.bankName];
        [db commit];
        
    }        
    
    [db close];
    
}

//查找所有的数据
+ (NSMutableArray *) findAllData{
        
    FMDatabase *db =[self openDatabase];
    
    NSMutableArray *dataArray =[[NSMutableArray alloc] init];
    
    FMResultSet *resultSet =[db executeQuery:@"SELECT * FROM banktrans ORDER BY name"];
    
    while ([resultSet next]) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        CCLog(@"******************************************************************");

        [dic setObject:[resultSet stringForColumnIndex:0] forKey:@"trans_id"];
        [dic setObject:[resultSet stringForColumnIndex:1] forKey:@"name"];
        [dic setObject:[resultSet stringForColumnIndex:2] forKey:@"code"];
        [dic setObject:[resultSet stringForColumnIndex:3] forKey:@"cardno"];
        [dic setObject:[resultSet stringForColumnIndex:4] forKey:@"feetext"];
        [dic setObject:[resultSet stringForColumnIndex:5] forKey:@"bankname"];

        CCLog(@"******************************************************************");
        CCLog(@"%@ %@ %@ %@ %@ %@ %@",resultSet,[resultSet stringForColumnIndex:0],[resultSet stringForColumnIndex:1],[resultSet stringForColumnIndex:2],[resultSet stringForColumnIndex:3], [resultSet stringForColumnIndex:4],[resultSet stringForColumnIndex:5]);
        
        [dataArray addObject:dic];
    }

    [db close];
    
    return dataArray;
}


+(void)deleteDataByID:(NSString *)ID
{
    FMDatabase *db = [self openDatabase];
    
    //删除操作
    [db beginTransaction];
    [db executeUpdate:@"DELETE FROM banktrans WHERE cardno = ?", [NSString stringWithFormat:@"%@",ID]];
    [db commit];
    CCLog(@"删除成功");
    [db close];
}

@end
/*

 
 + (NSString *)databaseFilePath{
 //寻找路径
 NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
 //数据库路径
 NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"banktrans.sqlite"];
 
 return sqlPath;
 }
 
 +(FMDatabase *)creatDataBase{
 //初始化数据库
 db=[FMDatabase databaseWithPath:[self databaseFilePath]];
 return db;
 }
 
 +(void)creatTable{
 if (!db) {
 [self creatDataBase];
 }
 
 if (![db open]) {
 CCLog(@"数据库打开失败");
 return;
 }
 
 [db setShouldCacheStatements:YES];
 
 if (![db tableExists:@"banktrans"]) {
 [db executeUpdate:@"CREATE TABLES IF NOT EXISTS banktrans(name TEXT, code TEXT , cardno TEXT , trans_id INTEGER PRIMARY KEY  AUTOINCREMENT)"];
 CCLog(@"创建完成");
 }else{
 CCLog(@"已经存在");
 }
 }
*/