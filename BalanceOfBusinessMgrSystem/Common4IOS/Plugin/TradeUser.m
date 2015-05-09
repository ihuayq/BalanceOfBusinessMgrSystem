//
//  TradeUser.m
//  SQL
//
//  Created by 孙朋贞 on 13-7-16.
//
//

#import "TradeUser.h"
#import "DB.h"

@implementation TradeUser
@synthesize tradeId;
@synthesize tradeInfo;
@synthesize ID;
@synthesize tableName;


//初始化
- (id)initWithTableName:(NSString *)tablename
                     ID:(int)newId
                tradeId:(NSString *)tradeid
              tradeInfo:(NSString *)tradeinfo
{
    self = [super init];
    if (self) {
        self.tableName = tablename;
        self.ID = newId;
        self.tradeId = tradeid;
        self.tradeInfo = tradeinfo;
    }
    return self;
}

//创建新表
+ (BOOL)createTable:(NSString *)tableName
{
    sqlite3 *db = [DB openDB];
    //创建一个表: create table student(ID integer primary key,name text,phone text,gender integer);//AUTOINCREMENT
    NSString *sqlStr = [NSString stringWithFormat:@"create table %@(ID integer primary key autoincrement,tradeId text,tradeInfo text)",tableName];
    NSString *createSql = [NSString stringWithFormat:@"%@",sqlStr];
    //stmt是statement的缩写，代表数据库中的语句。
    char *errorMsg;
    if (sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK)
    {
        CCLog(@"创建数据表失败:%s",errorMsg);
        return NO;
    }
    CCLog(@"创建数据表成功");
    return YES;
}

//查找表中所有信息
+ (NSMutableArray *)findAll:(NSString *)tablename
{
    //想要进行查询，首先要打开数据库
    sqlite3 *db = [DB openDB];
    //stmt是statement的缩写，代表数据库中的语句。
    sqlite3_stmt *stmt = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ order by ID desc",tablename];
    NSString *querrySql = [NSString stringWithFormat:@"%@",sqlStr];
    
    int result = sqlite3_prepare_v2(db, [querrySql UTF8String], -1, &stmt, nil);
    if(result == SQLITE_OK)//如果SQL语句编译没有问题
    {
        //创建一个数组保存查询到的信息
        NSMutableArray *trades = [[NSMutableArray alloc] init];
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            int a = sqlite3_column_int(stmt, 0);
            const unsigned char *b = sqlite3_column_text(stmt, 1);
            const unsigned char *c = sqlite3_column_text(stmt, 2);
            //根据取到的信息 创建Trade对象
            TradeUser *trade = [[TradeUser alloc] initWithTableName:tablename ID:a tradeId:[NSString stringWithUTF8String:(const char *)b] tradeInfo:[NSString stringWithUTF8String:(const char *)c]];
            [trades addObject:trade];
        }
        sqlite3_finalize(stmt);//结束SQL执行
        return trades;
    }
    CCLog(@"SQL error %d",result);
    sqlite3_finalize(stmt);
    return nil;
}
+ (NSMutableArray *)findPage:(int)page
                       count:(int)count
                   tablename:(NSString *)tablename
{
    sqlite3 *db = [DB openDB];
    sqlite3_stmt *stmt = nil;
    if (page<1) {
        return nil;
    }
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ order by ID desc limit %d offset %d",tablename,count,15*(page-1)];
    int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, nil);
    if (result==SQLITE_OK) {
        NSMutableArray *trades = [[NSMutableArray alloc] init];
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            int a = sqlite3_column_int(stmt, 0);
            const unsigned char *b = sqlite3_column_text(stmt, 1);
            const unsigned char *c = sqlite3_column_text(stmt, 2);
            //根据取到的信息 创建student对象
            TradeUser *trade = [[TradeUser alloc] initWithTableName:tablename ID:a tradeId:[NSString stringWithUTF8String:(const char *)b] tradeInfo:[NSString stringWithUTF8String:(const char *)c]];
            [trades addObject:trade];
        }
        sqlite3_finalize(stmt);//结束SQL执行
        return trades;
    }
    CCLog(@"SQL error %d",result);
    sqlite3_finalize(stmt);
    return nil;
}

//查看表tablename一共多少条记录
+ (int)count:(NSString *)tablename
{
    sqlite3 *db = [DB openDB];
    sqlite3_stmt *stmt = nil;
    //编译SQL语句
    NSString *sqlStr = [NSString stringWithFormat:@"select count(*) from %@",tablename];
    int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, nil);
    int count = 0;
    if (result == SQLITE_OK) {
        if(sqlite3_step(stmt) == SQLITE_ROW)//找到那条记录
        {
            count = sqlite3_column_int(stmt, 0);//取出值
            sqlite3_finalize(stmt);
        }
        return count;
    }
    sqlite3_finalize(stmt);
    return count;
}
//查找表中ID编号为newId的交易记录
+ (TradeUser *)infoOfTableName:(NSString *)tablename
                     ByTradeId:(NSString *)newId
{
    sqlite3 *db = [DB openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ where tradeId = ?",tablename];
    int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, nil);
    TradeUser *trade = nil;
    if(result == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [newId UTF8String], -1, nil);
        if(sqlite3_step(stmt) == SQLITE_ROW)
        {
            int a = sqlite3_column_int(stmt, 0);
            const unsigned char *b = sqlite3_column_text(stmt, 1);
            const unsigned char *c = sqlite3_column_text(stmt, 2);
            //根据取到的信息 创建student对象
            TradeUser *trade = [[TradeUser alloc] initWithTableName:tablename ID:a tradeId:[NSString stringWithUTF8String:(const char *)b] tradeInfo:[NSString stringWithUTF8String:(const char *)c]];
            sqlite3_finalize(stmt);
            return trade;
        }
    }
    return trade;
}
//添加一条记录
+ (void)addTradeWithTableName:(NSString *)tablename
                      tradeId:(NSString *)tradeid
                    tradeInfo:(NSString *)tradeinfo
{
    sqlite3 *db = [DB openDB];
    sqlite3_stmt *stmt;
    NSString *insertSQL = [NSString stringWithFormat:@"insert into %@(tradeId,tradeInfo) values(?,?)",tablename];
    //CCLog(@"insertSQL---+++%@",insertSQL);
    int result = sqlite3_prepare_v2(db, [insertSQL UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [tradeid UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [tradeinfo UTF8String], -1, nil);
        sqlite3_step(stmt);
        //CCLog(@"添加记录成功");
    }
    else
    {
        CCLog(@"添加记录不成功");
    }
    sqlite3_finalize(stmt);
}
//删除一条记录
+ (void)deleteTradeWithTableName:(NSString *)tablename
                       ByTradeId:(NSString *)tradeid
{
    sqlite3 *db = [DB openDB];
    sqlite3_stmt *stmt = nil;
    NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where tradeId = ?",tablename];
    int result = sqlite3_prepare_v2(db, [deleteSql UTF8String], -1, &stmt, nil);
    if(result == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [tradeid UTF8String], -1, nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
//修改记录信息
+ (void)updateTradeWithTableName:(NSString *)tablename
                       tradeInfo:(NSString *)tradeinfo
                       ByTradeId:(NSString *)tradeid
{
    sqlite3 *db = [DB openDB];
    sqlite3_stmt *stmt = nil;
    NSString *updateSql = [NSString stringWithFormat:@"update %@ set tradeInfo = '%@' where tradeId = '%@'",tablename,tradeinfo,tradeid];
    int result = sqlite3_prepare_v2(db, [updateSql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_step(stmt);
        //CCLog(@"更新成功");
    }else{
        CCLog(@"更新失败");

    }
    sqlite3_finalize(stmt);
}
//重载description方法
- (NSString *)description
{
    return self.tradeId;
}

@end
