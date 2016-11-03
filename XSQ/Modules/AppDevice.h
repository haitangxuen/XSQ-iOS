//
//  AppDevice.h
//  PublicModule
//
//  Created by zhoupengli on 15/4/20.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//  硬件信息数据模型

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppDevice : NSObject

//单例
+ (AppDevice *)sharedInstance;

@property (nonatomic,readonly) NSString *platform;
@property (nonatomic,readonly) NSString *systemVersion;
@property (nonatomic,readonly) NSString *macaddress;
@property (nonatomic,readonly) NSString *idfa;
@property (nonatomic,readonly) NSString *idfv;

@property (nonatomic,readonly) float width;
@property (nonatomic,readonly) float height;

@property (nonatomic,readonly) NSString *version;

@property (nonatomic,readonly) NSString *netType;
@property (nonatomic,readonly) BOOL     bWWAN;// YES WWAN NO wifi
@property (nonatomic,readonly) int      netstatus;



+ (void)fixDeviceToInterface:(UIInterfaceOrientation)orientation;
@end
