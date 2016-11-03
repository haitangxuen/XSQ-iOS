//
//  BaseViewController.h
//  PublicModule
//
//  Created by zhoupengli on 15/4/16.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//  所有视图控制器基类

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//展现加载指示，位于导航栏，不阻塞其它点击事件
- (void)startAnimating;

//隐藏加载指示
- (void)stopAnimating;

/**
 *  HUD方式提示网络加载，一般用于界面展现后的网络请求
 */

//展现加载指示，位于屏幕中间，阻塞其它点击事件
- (void)showHUD;

//隐藏加载指示
- (void)hideHUD;

//展现提示信息，自动延时隐藏
- (void)showTips:(NSString*)tips;

//展现错误提示信息，自动延时隐藏
- (void)showError:(NSError*)error;


/**
 *  UIActivityIndicatorView方式展现网络加载，一般用于界面主数据展现的网络请求
 */
//展现加载指示
- (void)showLoading;

//隐藏加载指示
- (void)hideLoading;

//展现网络出错情况下的展现
- (void)showNonet:(NSError *)error;

//无网络时，cell touch 事件,子类复写方法
- (void)nonetViewTouched;

@end
