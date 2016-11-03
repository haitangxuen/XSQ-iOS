//
//  UIViewController+Helper.m
//  PublicModule
//
//  Created by zhoupengli on 15/4/17.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import "UIViewController+Helper.h"
#import "CommonUI.h"

@implementation UIViewController (Helper)

- (void)setupLeftNavButton:(UIImage*)image
                withOffset:(float)offset
                    target:(id)target
                    action:(SEL)action
{
    
    UIButton *btn = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)
                                                   text:nil
                                                  color:nil
                                                   font:nil
                                        backgroundImage:image
                                                 target:target
                                                 action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setupRightNavButton:(UIImage*)image
                 withOffset:(float)offset
                     target:(id)target
                     action:(SEL)action
{
    
    UIButton *btn = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)
                                                   text:nil
                                                  color:nil
                                                   font:nil
                                        backgroundImage:image
                                                 target:target
                                                 action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setupLeftNavButtonEx:(NSString *)text
                  withOffset:(float)offset
                      target:(id)target
                      action:(SEL)action
{
    CGSize size = TEXT_SIZE(text, FONT(17));
    
    UIButton *btn = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, ceilf(size.width)+10, 30)
                                                   text:text
                                                  color:[UIColor whiteColor]
                                                   font:FONT(17)
                                        backgroundImage:nil
                                                 target:target
                                                 action:action];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setupRightNavButtonEx:(NSString*)text
                   withOffset:(float)offset
                       target:(id)target
                       action:(SEL)action
{
    CGSize size = TEXT_SIZE(text, FONT(17));
    
    UIButton *btn = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, ceilf(size.width)+10, 30)
                                                   text:text
                                                  color:[UIColor whiteColor]
                                                   font:FONT(17)
                                        backgroundImage:nil
                                                 target:target
                                                 action:action];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setupLeftNavButton:(UIImage*)image
                withOffset:(float)offset
                     block:(void (^)(UIButton* btn))block
{
    
    UIButton *btn = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)
                                                   text:nil
                                                  color:nil
                                                   font:nil
                                        backgroundImage:image
                                                  block:block];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setupRightNavButton:(UIImage*)image
                 withOffset:(float)offset
                      block:(void (^)(UIButton* btn))block
{
    
    UIButton *btn = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)
                                                   text:nil
                                                  color:nil
                                                   font:nil
                                        backgroundImage:image
                                                  block:block];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setupLeftNavButtonEx:(NSString *)text
                  withOffset:(float)offset
                       block:(void (^)(UIButton* btn))block
{
    CGSize size = TEXT_SIZE(text, FONT(15));
    
    UIButton *btn = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, ceilf(size.width)+10, 30)
                                                   text:text
                                                  color:[UIColor whiteColor]
                                                   font:FONT(17)
                                        backgroundImage:nil
                                                  block:block];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

- (void)setupRightNavButtonEx:(NSString*)text
                   withOffset:(float)offset
                        block:(void (^)(UIButton* btn))block
{
    CGSize size = TEXT_SIZE(text, FONT(15));
    
    UIButton *btn = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, ceilf(size.width)+10, 30)
                                                   text:text
                                                  color:[UIColor whiteColor]
                                                   font:FONT(16)
                                        backgroundImage:nil
                                                  block:block];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = offset;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
}

@end
