//
//  BaseTableViewController.h
//  PublicModule
//
//  Created by zhoupengli on 15/4/16.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//  列表视图控制器基类

#import "BaseNavViewController.h"

@interface BaseTableViewController : BaseNavViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;

/**
 *  刷新某个Cell
 *
 *  @param index cell坐标
 */
- (void)reloadRowsAtIndexPath:(NSIndexPath*)index;

/**
 *  刷新某个section
 *
 *  @param index section位置
 */
- (void)reloadSection:(NSIndexSet*)index;

/**
 *  添加刷新控件
 */
- (void)createRefreshControl;

/**
 *  结束刷新加载状态
 */
- (void)endRefreshing;

/**
 *  取消刷新控件
 */
- (void)cancelRefreshControl;


/**
 *  刷新加载更多状态，没有时先创建
 *
 *  @param full 列表数据是否已经全部加载
 */
- (void)refrshLoadMoreControlWithFull:(BOOL)full;

/**
 *  取消加载更多控件
 */
- (void)cancelLoadMoreControl;


/**
 *  以下方法需要在子类中复写
 */

//刷新事件回调
- (void)tableRefrsh:(UITableView *)tableView;

//加载更多事件回调
- (void)tableLoadMore:(UITableView *)tableView;

//列表为空状态时，cell touch 事件
- (void)emptyCellTouched:(UITableView *)tableView;

//告知列表是否做为空的展现
- (BOOL)tableViewIsEmpty:(UITableView *)tableView;

//列表为空状态时，需要展示的Cell的图片
- (UIImage *)tableViewEmptyCellImage:(UITableView *)tableView;

//列表为空状态时，展示的Cell的文案
- (NSString *)tableViewEmptyCellMessage:(UITableView *)tableView;

//列表为空状态时，需要展示Cell的高度
- (CGFloat)tableViewEmptyCellHeight:(UITableView *)tableView;


/**
 *  以下方法重构了TableView的DataSource和Delegate，在原方法tableView后添加Ex表示，被重构的方法不能在子类中复写。重构的方法和未重构的方法可以复写。
 */
#pragma mark TableViewDataSource,UITableViewDelegate
//设置Table行数
- (NSInteger)tableViewEx:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

//设置Table每行高度
- (CGFloat)tableViewEx:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

//设置Table每行Cell的唯一标识
- (NSString*)tableViewEx:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;

//实现Cell或重设Cell数据
- (UITableViewCell *)tableViewEx:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//Cell点击事件
- (void)tableViewEx:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end