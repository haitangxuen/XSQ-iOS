//
//  XSQSortViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/30.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQSortViewController.h"
#import "PublicMacro.h"
#import "LeftListCell.h"
@interface XSQSortViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_leftListView;
    UIButton *_abstainBtn;
}
@property(nonatomic ,strong)NSMutableArray *dataArray;
@end

@implementation XSQSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化分类列表
    [self setupLeftListView];
    // Do any additional setup after loading the view.
}
- (void)setupLeftListView{
    
    _leftListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, SCREEN_HEIGHT_WITHOUTHEAD-50-100) style:UITableViewStylePlain];
    _leftListView.showsVerticalScrollIndicator = NO;
    _leftListView.showsHorizontalScrollIndicator = NO;
    _leftListView.scrollEnabled = NO;
    [_leftListView registerNib:[LeftListCell nib] forCellReuseIdentifier:[LeftListCell identifier]];
    _leftListView.delegate = self;
    _leftListView.dataSource = self;
    [self.view addSubview:_leftListView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftListCell *cell;
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:[LeftListCell identifier] forIndexPath:indexPath];
        cell.sortName.text = self.dataArray[indexPath.row];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LeftListCell height];
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"饮品",@"烟酒",@"零食",@"全部",@"米面油",@"调料",@"日用",@"百货",nil];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
