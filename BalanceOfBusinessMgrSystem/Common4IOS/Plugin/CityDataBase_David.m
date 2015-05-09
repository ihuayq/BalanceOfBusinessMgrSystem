//
//  CityDataBase_David.m
//  MyFlight2.0
//
//  Created by Davidsph on 1/12/13.
//  Copyright (c) 2013 LIAN YOU. All rights reserved.
//

#import "CityDataBase_David.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "AppConfigure.h"
#import "CityData_David.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"



@interface  CityDataBase_David  (city)


+ (NSMutableArray *) findAllProvince;

@end



@implementation CityDataBase_David



+(FMDatabase *) openDatabase{
    
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"AllCityDataBase.sqlite"];
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"AllCityDataBase" ofType:@"sqlite"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:sqlPath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
    {
        
        NSError *err = nil;
        if([fm copyItemAtPath:orignFilePath toPath:sqlPath error:&err] == NO)//如果拷贝失败
        {
            CCLog(@"open database error %@",[err localizedDescription]);
            return nil;
        }
        
        CCLog(@"document 下没有数据库文件，执行拷贝工作");
    }
    
    //初始化数据库
    FMDatabase *db=[FMDatabase databaseWithPath:sqlPath];
    
    //这个方法一定要执行
    if (![db open]) {
        
        CCLog(@"数据库打开失败！");
        return db;
    }
    
    return  db;
}



//添加数据库新方法

+ (void) insertIntoTableWithAirPortCompanyArray:(NSMutableArray *) dataArray{
    
    CCLog(@"传入的待插入数据为 %d",[dataArray count]);
    
    
    FMDatabase *db =[self openDatabase];
    
    static BOOL isDataBaseNew =false;
    
    if (isDataBaseNew==false) {
        
        if ([db tableExists:@"cityAllDataBase"]) {
            
            [db executeUpdate:@"drop table cityAllDataBase"];
            
        }
        
        
        NSString *sql =@"CREATE TABLE cityAllDataBase (name TEXT, code TEXT, pinyin TEXT,hotcity text,parentCode text,parentName text, id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ) ";
        
        [db executeUpdate:sql];
        
        
        isDataBaseNew =true;
    }
    
    for (CityData_David *data in dataArray) {
        
        
        BOOL flag=  [db executeUpdate:@"insert into cityAllDataBase(name,code,pinyin,hotcity,parentCode,parentName) values(?,?,?,?,?,?)",data.name,data.code,data.pinyin,data.hotcity,data.parentCode,data.parentName];
        
        
        if (flag) {
            CCLog(@"插入成功");
        } else{
            
            CCLog(@"插入失败");
        }
    }
    
    
    [db close];
    
    
}



//初始化数据库
+(BOOL) initDataBaseTable:(NSData *) jsonData{
    
    //    NSString *countNum =[[jsonData objectFromJSONData] objectForKey:@"cities"];
    //
    //    CCLog(@"cityCount =%@",countNum);
    
    NSArray *resultArray = [[jsonData objectFromJSONData] objectForKey:@"cities"];
    NSMutableArray *array =[[NSMutableArray alloc] init];
    
    CCLog(@"数组cityCcount = %d",[resultArray count]);
    
    
    
    for (NSDictionary *dic  in resultArray) {
        
        
        CityData_David *data =[[CityData_David alloc] init];
        
        data.name =[dic objectForKey:@"name"];
        data.code =[dic objectForKey:@"code"];
        data.pinyin =[dic objectForKey:@"pinyin"];
        data.hotcity =[dic objectForKey:@"hotcity"];
        data.parentCode = [dic objectForKey:@"parentCode"];
        data.parentName =[dic objectForKey:@"parentName"];
        
        //        CCLog(@"parentName = %@  cityName = %@",)
        
        [array addObject:data];
        [data release];
        
        
    }
    
    CCLog(@"待插入的航空公司数据%d",[array count]);
    [self insertIntoTableWithAirPortCompanyArray:array];
    

    [array release];
    
    return true;
}


+ (void) initDataBase{
    
    CCLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *urlString = @"http://223.202.36.179:9580/web/phone/prod/flight/allCitySearch.jsp";
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setCompletionBlock:^{
        
        
        
        CCLog(@"网络返回的数据为：%@",[request responseString]);
        
        //初始化表格
        [self initDataBaseTable:[request responseData]];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        CCLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    [request startAsynchronous];
}



//查找所有的 正确的省份
+ (NSMutableDictionary *) findAllCitiesSortedInKeys{
    
    NSMutableArray *provinceArray =[[self findAllProvince] retain];
    
    FMDatabase *db =[self openDatabase];
    
    
    NSMutableDictionary *resultDic =[[NSMutableDictionary alloc] init];
    
    
    
    
    for (CityData_David *data in provinceArray) {
        
        NSString *parentCode = data.parentCode;
        
        NSString *parentName =[data.parentName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
    //    CCLog(@"************parentName = %@",parentName);
        
        
        FMResultSet *resultSet =[db executeQuery:@"SELECT *  FROM cityAllDataBase where parentCode = ? order by pinyin",parentCode];
        
        
        
        NSMutableArray *cityArray =[[NSMutableArray alloc] init];
        
        
        
        while ([resultSet next]) {
            
            //加入省份之下的所有 城市
            
            CityData_David *data =[[CityData_David alloc] init];
            
            data.name = [resultSet stringForColumnIndex:0];
            data.code = [resultSet stringForColumnIndex:1];
            data.pinyin =[resultSet stringForColumnIndex:2];
            data.hotcity =[resultSet stringForColumnIndex:3];
            data.parentName =[resultSet stringForColumn:@"parentName"];
            
     //       CCLog(@"******************************************************************");
            
   //         CCLog(@"%@",data.name);
            
            [cityArray addObject:data];
            [data release];
            
        }
        
        
        [resultDic setObject:cityArray forKey:parentName];
        
        [cityArray release];
        
        
        
        
    }
    
    
       
    
    [provinceArray release];
    
    [db close];
    return [resultDic autorelease];
    
}




//查询所有直辖市

+ (NSMutableDictionary *) findAllDerectCities{
    
    FMDatabase *  db =[self openDatabase];
    
    
    
    //保存直辖市的数组
    NSMutableArray *zhixiashiArray =[[NSMutableArray alloc] init];
    
    NSString *thisstring =@"直辖市";
    FMResultSet *thisSet =[db executeQuery:@"SELECT *  FROM cityAllDataBase   where parentName = ? order by pinyin",thisstring];
    
    
    while ([thisSet next]) {
        
        CityData_David *data =[[CityData_David alloc] init];
        
        data.name = [thisSet stringForColumnIndex:0];
        data.code = [thisSet stringForColumnIndex:1];
        data.pinyin =[thisSet stringForColumnIndex:2];
        data.hotcity =[thisSet stringForColumnIndex:3];
        data.parentName =[thisSet stringForColumn:@"parentName"];
        
        [zhixiashiArray addObject:data];
        [data release];
        
        
    }
    
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
    
    CCLog(@"查找直辖市的数量 ：%d",[zhixiashiArray count]);
    [dic setObject:zhixiashiArray forKey:thisstring];
    
    [zhixiashiArray release];
    
    [db close];
    return  [dic autorelease];
    
}



//查找所有的省份

+ (NSMutableArray *) findAllProvince{
    
    
    FMDatabase *db =[self openDatabase];
    
    NSString *str1 =@"直辖市";
    NSString *str2 =@"大兴安岭";
    NSString *str3 =@"呼伦贝尔";
    NSString *str4 =@"甘孜州";
    
    
    FMResultSet *resultSet =[db executeQuery:@"SELECT distinct parentName ,parentCode FROM cityAllDataBase  where parentName  not in( ?,?,?,?)",str1,str2,str3,str4];
    
    NSMutableArray *resultArray =[[NSMutableArray alloc] init];
    
    while ([resultSet next]) {
        
        CityData_David *data =[[CityData_David alloc] init];
        
        
        //        data.name = [resultSet stringForColumnIndex:0];
        //        data.code = [resultSet stringForColumnIndex:1];
        //        data.pinyin =[resultSet stringForColumnIndex:2];
        //        data.hotcity =[resultSet stringForColumnIndex:3];
        
        data.parentName =[resultSet stringForColumn:@"parentName"];
        data.parentCode =[resultSet stringForColumn:@"parentCode"];
        
        [resultArray addObject:data];
        
        [data release];
        
    }
    
    
    CCLog(@"查询到的省的数目为：%d",[resultArray count]);
    
    [db close];
    return [resultArray autorelease];
    
    
}





//查找所有的城市

+ (NSMutableArray *) findAllCities{
    
    
    FMDatabase *db =[self openDatabase];
    
    FMResultSet *resultSet =[db executeQuery:@"SELECT *  FROM cityAllDataBase"];
    
    NSMutableArray *resultArray =[[NSMutableArray alloc] init];
    
    while ([resultSet next]) {
        
        CityData_David *data =[[CityData_David alloc] init];
        
        data.name = [resultSet stringForColumnIndex:0];
        data.code = [resultSet stringForColumnIndex:1];
        data.pinyin =[resultSet stringForColumnIndex:2];
        data.hotcity =[resultSet stringForColumnIndex:3];
        data.parentName =[resultSet stringForColumn:@"parentName"];
        
        
        [resultArray addObject:data];
        
        [data release];
        
    }
    
    
    CCLog(@"查询到的城市数目为：%d",[resultArray count]);
    
    [db close];
    
    return [resultArray autorelease];
    
    
}
//查找搜索城市
+(NSMutableArray *)findCityBySiftBy:(NSString *)condition
{
    FMDatabase *db =[self openDatabase];
;

    FMResultSet *resultSet =[db executeQuery:[NSString stringWithFormat:@"SELECT *  FROM cityAllDataBase where name like '%%%@%@'",condition,@"%"]];

    NSMutableArray *resultArray =[[NSMutableArray alloc] init];
    
    while ([resultSet next]) {

        CityData_David *data =[[CityData_David alloc] init];
        
        data.name = [resultSet stringForColumnIndex:0];
        data.code = [resultSet stringForColumnIndex:1];
        data.pinyin =[resultSet stringForColumnIndex:2];
        data.hotcity =[resultSet stringForColumnIndex:3];
        data.parentName =[resultSet stringForColumn:@"parentName"];
        
        [resultArray addObject:data];
        
        [data release];
        
    }

    
    [db close];
    
    
  
    
    return [resultArray autorelease];

}
@end
