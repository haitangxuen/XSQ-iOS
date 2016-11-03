//
//  AppDelegate.m
//  XSQ
//
//  Created by black_dex on 2016/10/26.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "AppDelegate.h"
#import "PublicMacro.h"
#import <SMS_SDK/SMSSDK.h>
#import "UIViewController+Helper.h"
#import "XSQLoginViewController.h"

@interface AppDelegate ()

@end

#define appkey @"14e1cc04efbc0"
#define app_secrect @"39a445e014ef8b2575238d50f97b94b2"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 根视图
    [self setupRootViewController];
    
    [SMSSDK registerApp:appkey
             withSecret:app_secrect];
    return YES;
}

- (void)setupRootViewController{
    // 定义NavBar样式
    [[UINavigationBar appearance] setBarTintColor:JColor_NavBar];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:JColor_White];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"navi_back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navi_back"]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    XSQHomeViewController *vc = [XSQHomeViewController new];
    UINavigationController *navigationCtrl = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationCtrl;
    [self.window makeKeyWindow];

#if 0
    // 定义TabBar样式
    [[UITabBar appearance] setTintColor:JColor_Blue];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : JColor_White } forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: JFont_Tabbar} forState:UIControlStateNormal];
#endif
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
