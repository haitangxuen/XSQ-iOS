//
//  UIViewController+Helper.h
//  PublicModule
//
//  Created by zhoupengli on 15/4/17.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helper)

//创建导航栏左侧图片按钮
- (void)setupLeftNavButton:(UIImage*)image
                withOffset:(float)offset
                    target:(id)target
                    action:(SEL)action;

- (void)setupLeftNavButton:(UIImage*)image
                withOffset:(float)offset
                     block:(void (^)(UIButton* btn))block;

//创建导航栏右侧图片按钮
- (void)setupRightNavButton:(UIImage*)image
                 withOffset:(float)offset
                     target:(id)target
                     action:(SEL)action;

- (void)setupRightNavButton:(UIImage*)image
                 withOffset:(float)offset
                      block:(void (^)(UIButton* btn))block;

//创建导航栏左侧文字按钮
- (void)setupLeftNavButtonEx:(NSString*)text
                  withOffset:(float)offset
                      target:(id)target
                      action:(SEL)action;

- (void)setupLeftNavButtonEx:(NSString *)text
                  withOffset:(float)offset
                       block:(void (^)(UIButton* btn))block;

//创建导航栏右侧文字按钮
- (void)setupRightNavButtonEx:(NSString*)text
                   withOffset:(float)offset
                       target:(id)target
                       action:(SEL)action;

- (void)setupRightNavButtonEx:(NSString*)text
                   withOffset:(float)offset
                        block:(void (^)(UIButton* btn))block;

@end
