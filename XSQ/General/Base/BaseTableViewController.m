//
//  BaseTableViewController.m
//  PublicModule
//
//  Created by zhoupengli on 15/4/16.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import "BaseTableViewController.h"
#import "PublicMacro.h"
#import "RefreshHeader.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadRowsAtIndexPath:(NSIndexPath*)index
{
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadSection:(NSIndexSet*)index
{
    [self.tableView beginUpdates];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

#pragma mark Refresh
- (void)createRefreshControl
{
    if(self.tableView.mj_header == nil)
    {
        @weakify(self)
        RefreshHeader *header = [RefreshHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self tableRefrsh:self.tableView];
        }];
        
        // 设置header
        self.tableView.mj_header = header;
    }
}


- (void)cancelRefreshControl
{
    if (self.tableView.mj_header) {
        [self.tableView.mj_header removeFromSuperview];
    }
}

- (void)endRefreshing
{
    [self.tableView.mj_header endRefreshing];
}

#pragma mark LoadMore
- (void)refrshLoadMoreControlWithFull:(BOOL)full
{
    if (self.tableView.mj_footer == nil) {
        @weakify(self)
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self tableLoadMore:self.tableView];
        }];
    }
    
    if (full) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)cancelLoadMoreControl
{
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer removeFromSuperview];
    }
}

#pragma mark BaseTableViewController 复写部分
//刷新事件
- (void)tableRefrsh:(UITableView *)tableView
{
 
}

//加载更多事件
- (void)tableLoadMore:(UITableView *)tableView
{
   
}

//为空时，cell touch 事件
- (void)emptyCellTouched:(UITableView *)tableView
{
    
}

//table是否为空
- (BOOL)tableViewIsEmpty:(UITableView *)tableView
{
    return NO;
}

//数据为空时，展示的Cell的image
- (UIImage *)tableViewEmptyCellImage:(UITableView *)tableView
{
    return [UIImage imageNamed:@"nodata_default"];
}

//数据为空时，展示的Cell的文案
- (NSString *)tableViewEmptyCellMessage:(UITableView *)tableView
{
    return @"没有数据";
}

//数据为空的，展示Cell的高度
- (CGFloat)tableViewEmptyCellHeight:(UITableView *)tableView
{
    return tableView.height;
}

#pragma mark TableViewDataSource,UITableViewDelegate 扩展
- (NSInteger)tableViewEx:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableViewEx:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString*)tableViewEx:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"UITableViewCellIdentifier_Default";
}

- (UITableViewCell *)tableViewEx:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self tableViewEx:tableView cellIdentifierForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"CellDefault:%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    return cell;
}

- (void)tableViewEx:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_tableView]) {
        if (section+1  == [self numberOfSectionsInTableView:tableView]) {
            if ([self tableViewIsEmpty:tableView]) {
                return 1;
            }
        }
    }
    
    return [self tableViewEx:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView]) {
        if (indexPath.section+1 == [self numberOfSectionsInTableView:tableView]) {
            if ([self tableViewIsEmpty:tableView]) {
                return [self tableViewEmptyCellHeight:tableView];
            }
        }
    }
    
    return [self tableViewEx:tableView heightForRowAtIndexPath:indexPath];
}

- (NSString*)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView]) {
        if (indexPath.section+1  == [self numberOfSectionsInTableView:tableView]) {
            if ([self tableViewIsEmpty:tableView]) {
                return @"UITableViewCellIdentifier_Empty";
            }
        }
    }
    
    return [self tableViewEx:tableView cellIdentifierForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self tableView:tableView cellIdentifierForRowAtIndexPath:indexPath];
    
    if ([cellIdentifier isEqualToString:@"UITableViewCellIdentifier_Empty"]) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell ==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = tableView.backgroundColor;
            cell.contentView.backgroundColor = tableView.backgroundColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *img = [[UIImageView alloc] init];
            img.tag = 10086;
            [cell addSubview:img];
            
            UILabel *lab = [CommonUI commonLabelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)
                                                              text:nil
                                                             color:[UIColor grayColor]
                                                              font:FONT(15)
                                                     textAlignment:NSTextAlignmentCenter];
            lab.tag = 10088;
            [cell addSubview:lab];
        }
        
        UIImageView *imgEmpty = (UIImageView *)[cell viewWithTag:10086];
        UILabel *labEmpty = (UILabel *)[cell viewWithTag:10088];
        UIImage *image = [self tableViewEmptyCellImage:tableView];
        if (image) {
            imgEmpty.image = image;
            imgEmpty.width = image.size.width;
            imgEmpty.height = image.size.height;
            imgEmpty.centerX = tableView.centerX;
            imgEmpty.centerY = [self tableView:tableView heightForRowAtIndexPath:indexPath]/3;
            
            labEmpty.top = imgEmpty.bottom;
            labEmpty.text = [self tableViewEmptyCellMessage:tableView];
        }
    
        return cell;
    }
    
    return [self tableViewEx:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView]) {
        if (indexPath.section+1 == [self numberOfSectionsInTableView:tableView]) {
            if ([self tableViewIsEmpty:tableView]) {
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                [self emptyCellTouched:tableView];
                return;
            }
        }
    }
    
    [self tableViewEx:tableView didSelectRowAtIndexPath:indexPath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
