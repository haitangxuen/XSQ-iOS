//
//  AppConfig.m
//  PublicModule
//
//  Created by zhoupengli on 15/4/20.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

+ (AppConfig *)sharedInstance
{
    static AppConfig *s_g_Instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_g_Instance = [[AppConfig alloc] init];
    });
    return s_g_Instance;
}

- (id)init {
    self = [super init];
    if(self) {
        [self read];
    }
    return self;
}

- (void)save
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:_bCache forKey:@"CacheOnWifi"];
    [userDefaults setValue:_gtCid forKey:@"gtCid"];
    [userDefaults setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"LatestVersion"];

    [userDefaults synchronize];
}

- (void)read
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    _bCache = [userDefaults boolForKey:@"CacheOnWifi"];
    _gtCid = [userDefaults stringForKey:@"gtCid"];
}

@end
