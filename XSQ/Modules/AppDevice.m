//
//  AppDevice.m
//  PublicModule
//
//  Created by zhoupengli on 15/4/20.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import "AppDevice.h"
#import "PublicMacro.h"
#import "UIDevice+Helper.h"

#import "AFNetworkReachabilityManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

//#import <AdSupport/AdSupport.h>

@interface AppDevice ()

@property(nonatomic,readwrite) BOOL bWWAN;

@property(nonatomic,readwrite) int netstatus;

@end

@implementation AppDevice

+ (AppDevice *)sharedInstance
{
    static AppDevice *s_g_Instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_g_Instance = [[AppDevice alloc] init];
    });
    return s_g_Instance;
}

- (id)init {
    self = [super init];
    if(self) {
        UIDevice *device = [UIDevice currentDevice];
        
        _platform = [device platform];
        _systemVersion = [device systemVersion];
        _macaddress = [[device macaddress] uppercaseString];
        _idfv = [[device identifierForVendor] UUIDString];
        //_idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
        _width = SCREEN_WIDTH;
        _height = SCREEN_HEIGHT;

        _version = [NSString stringWithFormat:@"%@.%@",
                    [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"],
                    [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]];

        _bWWAN = NO;
        _netType = @"WIFI";
        _netstatus = AFNetworkReachabilityStatusUnknown;
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
                    NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
                    if (currentRadioAccessTechnology&&[currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                        _netType = @"4G";
                    }else{
                        _netType = @"3G";
                    }
                }else{
                    _netType = @"3G";
                }
            }else{
                _netType = @"WIFI";
            }
            self.netstatus = status;
            self.bWWAN = (status == AFNetworkReachabilityStatusReachableViaWWAN);
        }];
        [manager startMonitoring];
    }

    return self;
}


+ (void)fixDeviceToInterface:(UIInterfaceOrientation)orientation
{
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
    [UIViewController attemptRotationToDeviceOrientation];
}
@end
