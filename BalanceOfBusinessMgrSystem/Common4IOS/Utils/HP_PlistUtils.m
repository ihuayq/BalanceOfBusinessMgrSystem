//
//  HP_PlistUtils.m
//  youyouapp
//
//  Created by Yi Xu on 12-12-3.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import "HP_PlistUtils.h"

@implementation HP_PlistUtils

-(NSString *) getPlistFilePathByName:(NSString *) plistName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:plistName];
    return plistPath;
}

-(void) createPlistFileByName:(NSString *) plistName withDictionary:(NSMutableDictionary *) dictionary{

    NSString *plistPath = [self getPlistFilePathByName:plistName];
    [dictionary writeToFile:plistPath atomically:YES];

}

-(void) createPlistFileByName:(NSString *) plistName withArray:(NSMutableArray *) array{
    
    NSString *plistPath = [self getPlistFilePathByName:plistName];
    [array writeToFile:plistPath atomically:YES];

}

-(NSMutableDictionary *)getDictionaryFromPlistFileByName:(NSString *) plistName{
    NSString *plistPath = [self getPlistFilePathByName:plistName];
    NSMutableDictionary *plistDictionary= [[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath]mutableCopy];
    return plistDictionary;
}

-(NSMutableArray *)getArrayFromPlistFileByName:(NSString *) plistName{
    NSString *plistPath = [self getPlistFilePathByName:plistName];
    NSMutableArray *plistArray= [[[NSMutableArray alloc]initWithContentsOfFile:plistPath]mutableCopy];
    return plistArray;
}
@end
