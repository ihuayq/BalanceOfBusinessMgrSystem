//
//  DB.h
//  SQL
//
//  Created by 孙朋贞 on 12-3-19.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DB : NSObject

+ (sqlite3 *)openDB;//打开数据库
+ (void)closeDB;//关闭数据库


@end
