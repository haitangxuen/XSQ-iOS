//
//  AppConfig.h
//  PublicModule
//
//  Created by zhoupengli on 15/4/20.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//  应用数据模型，保存应用相关配置

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

//单例
+ (AppConfig *)sharedInstance;

//保持配置到UserDefaults
- (void)save;

@property (nonatomic) BOOL bCache; //仅在WiFi下缓存，YES 是 NO 否

@property (nonatomic,strong) NSString *gtCid;

@end
