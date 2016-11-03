//
//  BaseNavViewController.h
//  PublicModule
//
//  Created by zhoupengli on 15/4/16.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//  导航视图控制器基类

#import "BaseViewController.h"

@interface BaseNavViewController : BaseViewController

//跳转到下一个视图
- (void)goNext;

//返回到上一个视图
- (void)goBack;

//返回到根视图
- (void)goRoot;

@end
