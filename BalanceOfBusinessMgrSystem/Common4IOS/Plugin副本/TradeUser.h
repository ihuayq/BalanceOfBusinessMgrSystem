//
//  TradeUser.h
//  SQL
//
//  Created by 孙朋贞 on 13-7-16.
//
//  
//用户交易类，用于存放数据库DB各种表中的信息,一个用户对应一个表，不删除表  每个表都有3个字段(ID tradeId tradeInfo)

#import <Foundation/Foundation.h>

@interface TradeUser : NSObject

@property(nonatomic, retain) NSString *tradeId,*tradeInfo;
@property(nonatomic, assign) int ID;
@property(nonatomic, retain) NSString *tableName;

//初始化
- (id)initWithTableName:(NSString *)tablename
                     ID:(int)newId
                tradeId:(NSString *)tradeid
              tradeInfo:(NSString *)tradeinfo;

//创建新表
+ (BOOL)createTable:(NSString *)tableName;
//查找表中所有信息
+ (NSMutableArray *)findAll:(NSString *)tablename;

//分页查询 page第几页 count这页几条数据
+ (NSMutableArray *)findPage:(int)page
                       count:(int)count
                   tablename:(NSString *)tablename;

//查看表tablename一共多少条记录
+ (int)count:(NSString *)tablename;
//查找表中ID编号为newId的交易记录 每一个tradeId对应一条记录
+ (TradeUser *)infoOfTableName:(NSString *)tablename
                          ByTradeId:(NSString *)newId;
//添加一条记录
+ (void)addTradeWithTableName:(NSString *)tablename
                      tradeId:(NSString *)tradeid
                    tradeInfo:(NSString *)tradeinfo;

//删除一条记录
+ (void)deleteTradeWithTableName:(NSString *)tablename
                       ByTradeId:(NSString *)tradeid;
//修改记录信息
+ (void)updateTradeWithTableName:(NSString *)tablename
                       tradeInfo:(NSString *)tradeinfo
                       ByTradeId:(NSString *)tradeid;

@end
