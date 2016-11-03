//
//  XSQAroundViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/26.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQAroundViewController.h"
#import <HTHorizontalSelectionList.h>
#import "PublicMacro.h"
@interface XSQAroundViewController ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet HTHorizontalSelectionList *selectListView;
@property (nonatomic, strong)UIScrollView *contentView;

@end

@implementation XSQAroundViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Around" bundle:nibBundleOrNil];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"XSQAroundViewController"];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"欣周边";
    
    self.selectListView.dataSource = self;
    self.selectListView.delegate = self;
    
    self.selectListView.selectionIndicatorAnimationMode = HTHorizontalSelectionIndicatorAnimationModeNoBounce;
    [self.selectListView setTitleColor:JColor_Black forState:UIControlStateNormal];
    [self.selectListView setTitleColor:JColor_Blue forState:UIControlStateSelected];
    [self.selectListView setTitleFont:[UIFont boldSystemFontOfSize:15] forState:UIControlStateNormal];
    [self.selectListView setTitleFont:[UIFont systemFontOfSize:15] forState:UIControlStateNormal];
    [self.selectListView setButtonInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    [self.selectListView reloadData];
    
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50+64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.contentView.contentSize = CGSizeMake(self.dataArray.count*SCREEN_WIDTH, SCREEN_HEIGHT);
    self.contentView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.contentView];
    
    // Do any additional setup after loading the view.
}

#pragma mark -- HTHorizontalSelectionListDelegate
- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList{
    return self.dataArray.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index{
    return self.dataArray[index];
}

#pragma mark -- HTHorizontalSelectionListDelegate
- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index{
    self.contentView.contentOffset = CGPointMake(index*SCREEN_WIDTH, 0);
    self.contentView.backgroundColor = JRandColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"到家",@"车主服务",@"支付",@"生活助手",@"娱乐",@"运动",@"时尚",@"新闻", nil];
    }
    return _dataArray;
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
