//
//  UIView+FrameExpand.h
//  PublicModule
//
//  Created by zhoupengli on 15/4/16.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameExpand)

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

- (void)loadRoundBorderStyle:(float)cornerRadius
                       width:(float)width
                       color:(UIColor*)color;

@end
