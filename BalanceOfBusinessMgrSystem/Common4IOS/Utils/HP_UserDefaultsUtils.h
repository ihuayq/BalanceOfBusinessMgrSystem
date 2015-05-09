//
//  HP_UserDefaultsUtils.h
//  blog
//
//  Created by Yi Xu on 12-11-25.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HP_UserDefaultsUtils : NSObject

//获得NSUserDefaults对象
-(NSUserDefaults *) getNSUserDefaults;

//NSUserDefaults对象中存入NSMutableDictionary类型的对象
-(void) setDictionaryForNSUserDefaults:(NSMutableDictionary *) dictionary forKey:(NSString *)key;

//NSUserDefaults对象中存入id类型的对象
-(void) setObjectForNSUserDefaults:(id) object forKey:(NSString *)key;

//NSUserDefaults对象中存入NSString类型的对象
-(void) setStringForNSUserDefaults:(NSString *) string forKey:(NSString *)key;

//从NSUserDefaults获得id对象
-(id) getObjectFromNSUserDefaultsForKey:(NSString *)key;

//从NSUserDefaults获得NSString对象
-(NSString *) getStringFromNSUserDefaultsForKey:(NSString *)key;

//从NSUserDefaults获得NSDictionary对象
-(NSDictionary *) getDictionaryFromNSUserDefaultsForKey:(NSString *)key;

@end
