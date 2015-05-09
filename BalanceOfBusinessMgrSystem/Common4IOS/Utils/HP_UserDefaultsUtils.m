//
//  HP_UserDefaultsUtils.m
//  blog
//
//  Created by Yi Xu on 12-11-25.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//

#import "HP_UserDefaultsUtils.h"

@implementation HP_UserDefaultsUtils

// NSUserDefaults相关
-(NSUserDefaults *) getNSUserDefaults{
    return [NSUserDefaults standardUserDefaults];
}

-(void) setDictionaryForNSUserDefaults:(NSMutableDictionary *) dictionary forKey:(NSString *)key{
    [[self getNSUserDefaults] setObject:dictionary forKey:key];
}

-(void) setObjectForNSUserDefaults:(id) object forKey:(NSString *)key{
    [[self getNSUserDefaults] setObject:object forKey:key];
}

-(void) setStringForNSUserDefaults:(NSString *) string forKey:(NSString *)key{
    [[self getNSUserDefaults] setObject:string forKey:key];
}

-(id) getObjectFromNSUserDefaultsForKey:(NSString *)key{
    return [[self getNSUserDefaults] objectForKey:key];
}

-(NSString *) getStringFromNSUserDefaultsForKey:(NSString *)key{
    return [[self getNSUserDefaults] stringForKey:key];
}

-(NSDictionary *) getDictionaryFromNSUserDefaultsForKey:(NSString *)key{
    return [[self getNSUserDefaults] dictionaryForKey:key];
}

@end
