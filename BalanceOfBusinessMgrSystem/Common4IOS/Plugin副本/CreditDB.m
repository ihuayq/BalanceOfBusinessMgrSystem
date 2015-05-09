//
//  CreditDB.m
//  ipaycard
//
//  Created by fei on 13-5-17.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "CreditDB.h"

@implementation CreditDB

static  FMDatabase *db;

+(FMDatabase *) openDatabase{
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"credit.sqlite"];
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"credit" ofType:@"sqlite"];
    
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

+ (void) insertTransData:(DJYCreditCardData *) aData{
    
    CCLog(@"传入的待插入数据为 %@ %@ %@",aData.bankCode , aData.cardNum, aData.orderdate);
    
    FMDatabase *db =[self openDatabase];
    
    if (![db tableExists:@"credit"]) {
        
        NSString *sql =@"CREATE TABLE IF NOT EXISTS credit(credit_id INTEGER PRIMARY KEY AUTOINCREMENT , code TEXT, cardno TEXT , time TEXT ,bankname TEXT) ";
        
        [db executeUpdate:sql];
    }
    
    FMResultSet *rs  = [db executeQuery:@"SELECT * FROM credit WHERE cardno = ?",[NSString stringWithFormat:@"%@",aData.cardNum] ];
    [db beginTransaction];
    
    if ([rs next]) {

        [db executeUpdate:@"UPDATE credit SET code = ?, time = ? ,bankname =? WHERE cardno = %@",aData.bankCode, aData.orderdate, aData.bankName ,aData.cardNum ];
        [db commit];
    }else{

        [db executeUpdate:@"INSERT INTO credit(code,cardno,time,bankname) VALUES(?,?,?,?)",aData.bankCode,aData.cardNum,aData.orderdate, aData.bankName];
        [db commit];
        
        [self findAllData];
        
    }
    
    [db close];
    
}

//查找所有的数据
+ (NSMutableArray *) findAllData{
    
    FMDatabase *db =[self openDatabase];
    
    NSMutableArray *dataArray =[[NSMutableArray alloc] init];
    
    FMResultSet *resultSet =[db executeQuery:@"SELECT * FROM credit ORDER BY cardno"];
    
    while ([resultSet next]) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        [dic setObject:[resultSet stringForColumnIndex:0] forKey:@"credit_id"];
        [dic setObject:[resultSet stringForColumnIndex:1] forKey:@"code"];
        [dic setObject:[resultSet stringForColumnIndex:2] forKey:@"cardno"];
        [dic setObject:[resultSet stringForColumnIndex:3] forKey:@"time"];
        [dic setObject:[resultSet stringForColumnIndex:4] forKey:@"bankname"];
        
        CCLog(@"******************************************************************");
        CCLog(@"%@ %@ %@ %@ %@ %@",resultSet,[resultSet stringForColumnIndex:0],[resultSet stringForColumnIndex:1],[resultSet stringForColumnIndex:2],[resultSet stringForColumnIndex:3],[resultSet stringForColumnIndex:4]);
        
        [dataArray addObject:dic];
    }
    
    [db close];
    
    return dataArray;
}


+(void)deleteDataByID:(NSString *)ID
{
    FMDatabase *db = [self openDatabase];
    
    [db beginTransaction];

    CCLog(@"aa=%@",[NSString stringWithFormat:@"%@",ID]);
    //删除操作
    BOOL isDelete = [db executeUpdate:@"DELETE FROM credit WHERE cardno = ?", ID];
    [db commit];
    CCLog(@"删除成功 isDe=%d",isDelete);
    [db close];
}


@end
