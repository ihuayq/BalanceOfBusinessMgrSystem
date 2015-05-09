//
//  HP_PlistUtils.h
//  youyouapp
//
//  Created by Yi Xu on 12-12-3.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_PlistUtils : NSObject

//根据Plist的名字获得Plist的存放路径(info.plist)
-(NSString *) getPlistFilePathByName:(NSString *) plistFileName;

//根据Plist的名字和Dictionary数据创建Plist文件
-(void) createPlistFileByName:(NSString *) plistName withDictionary:(NSMutableDictionary *) dictionary;

//根据Plist的名字和Array数据创建Plist文件
-(void) createPlistFileByName:(NSString *) plistName withArray:(NSMutableArray *) array;

//根据Plist的名字获得Dictionary的数据
-(NSMutableDictionary *)getDictionaryFromPlistFileByName:(NSString *) plistName;

//根据Plist的名字获得Array的数据
-(NSMutableArray *)getArrayFromPlistFileByName:(NSString *) plistName;

@end
