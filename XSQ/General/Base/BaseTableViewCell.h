//
//  BaseTableViewCell.h
//  MicroIncubation
//
//  Created by zhoupengli on 15/8/10.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *bottomLine;

@property (nonatomic,strong) NSDictionary *dictInfo;

@end
