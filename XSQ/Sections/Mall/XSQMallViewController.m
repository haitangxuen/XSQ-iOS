//
//  XSQMallViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//
#import "XSQMallViewController.h"
#import <HTHorizontalSelectionList.h>
#import "PublicMacro.h"
#import "XSQMineViewController.h"
#import "XSQCarViewController.h"
#import "XSQSubMallViewController.h"
#import "XSQSortViewController.h"
#import "XSQLoginViewController.h"

static NSString * const identifier = @"CELL";

@interface XSQMallViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)XSQCarViewController *carVC;
@property (nonatomic, strong)XSQSubMallViewController *subMallVC;
@property (nonatomic, strong)XSQMineViewController *mineVC;
@property (nonatomic, strong)XSQSortViewController *sortVC;

@property (nonatomic, strong)UIView *headerBgView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *titleButtons;
@property (nonatomic, weak)UIButton *selectButton;
@property (nonatomic, weak)UIScrollView *topView;
@property (nonatomic, weak)UIView *lineView;
@property (nonatomic,assign)BOOL isInitial;

@end

@implementation XSQMallViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Mall" bundle:nibBundleOrNil];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"XSQMallViewController"];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
        // 添加标题
        [self setupAllTitle];
        _isInitial = YES;
    }
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"欣商城";
    self.view.backgroundColor = ColorFromHex(0xF5F5F5);
    // 设置导航条内容
    [self setupNavgationBar];
    
    // 添加底部内容view
    [self setupContentView];
    
    // 添加所有子控制器
    [self setupAllChildViewController];
    
    // 不添加额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark - 设置导航条内容
- (void)setupNavgationBar {
    
    _headerBgView = [CommonUI commonViewWithFrame:CGRectMake(0, SCREEN_HEAD, SCREEN_WIDTH, 50) color:ColorFromHex(0xF5F5F5)];
    [self.view addSubview:_headerBgView];
    
    UIScrollView *topView = [[UIScrollView alloc] initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH-60, 50)];
    topView.scrollsToTop = NO;
    topView.backgroundColor = JColor_Clear;
    _topView = topView;
    _headerBgView.layer.zPosition = 1;
    [_headerBgView addSubview: topView];
}


#pragma mark - 选中标题按钮
- (void)selButton:(UIButton *)titleButton
{
    _selectButton.selected = NO;
    titleButton.selected = YES;
    _selectButton = titleButton;
    
    // 移动下划线的位置
    [UIView animateWithDuration:0.25 animations:^{
        if (titleButton.tag==2) {
            _lineView.width = titleButton.titleLabel.width+11.5;
        }
        else{
            _lineView.width = titleButton.titleLabel.width+6.5;
        }
        _lineView.centerX = titleButton.centerX;
        [_topView layoutIfNeeded];
    }];
    
}

#pragma mark - 点击标题

- (void)titleClick:(UIButton *)titleButton
{
    NSInteger i = titleButton.tag;
    
    [titleButton setTitleColor:ColorFromHex(0xFF03A4E7) forState:UIControlStateSelected];
    
    // 重复点击标题按钮的时候,刷新当前界面
    if (titleButton == _selectButton) {
        NSLog(@"重复点击标题按钮");
    }
    
    [self selButton:titleButton];
    
    //滚动collectionView 修改偏移量
    CGFloat offsetX = i * SCREEN_WIDTH;
    _collectionView.contentOffset = CGPointMake(offsetX, 0);
    
}

#pragma mark - UICollectionViewDelegate
// 滚动完成的时候就会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取角标
    NSInteger i = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    // 获取选中标题
    UIButton *selButton = self.titleButtons[i];
    
    // 选中标题
    [self selButton:selButton];
}

#pragma mark - 添加标题
- (void)setupAllTitle
{
    NSUInteger count = self.childViewControllers.count;
    CGFloat btnW = (SCREEN_WIDTH-50)/4;
    CGFloat btnX = 40;
    CGFloat btnH = _topView.height;
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        // 设置标题颜色
        [titleButton setTitleColor:ColorFromHex(0x9D9D9D) forState:UIControlStateNormal];
        
        // 设置标题字体
        titleButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [titleButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        btnX = i * btnW;
        
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
  
        // 监听按钮点击
      [titleButton bk_addEventHandler:^(id sender) {
            [self titleClick:sender];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:titleButton];
        
        if (i == 0) {
            
            CGFloat lineHeight = 2;
            CGFloat y = 38 ;
            UIView *lineView =[[UIView alloc] init];
            // 位置和尺寸
            lineView.height = lineHeight;
            // 先计算文字尺寸,在给label去赋值
            [titleButton.titleLabel sizeToFit];
            lineView.width = titleButton.titleLabel.width;
            lineView.centerX = titleButton.centerX;
            lineView.mj_y = y;
            lineView.backgroundColor = ColorFromHex(0xFF03A4E7);
            _lineView = lineView;
            
            [_topView addSubview:lineView];
        }
        
        [self.titleButtons addObject:titleButton];
    }
}

#pragma mark - 添加底部内容view
- (void)setupContentView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUTHEAD-50);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEAD+50, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUTHEAD-50) collectionViewLayout:layout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:collectionView];
    collectionView.scrollsToTop = NO;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    _collectionView = collectionView;
}

#pragma mark - 添加所有的子控制器
- (void)setupAllChildViewController {
    
    //商城
    self.subMallVC = [[XSQSubMallViewController alloc] init];
    self.subMallVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUTHEAD-50);
    self.subMallVC.title = @"商城";
    [self addChildViewController:self.subMallVC];
    
    //分类
    self.sortVC = [[XSQSortViewController alloc] init];
    self.sortVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUTHEAD-50);
    self.sortVC.title = @"分类";
    [self addChildViewController:self.sortVC];
    

    self.carVC = [[XSQCarViewController alloc] init];
    self.carVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUTHEAD-50);
    self.carVC.title = @"购物车";
    [self addChildViewController:self.carVC];

    self.mineVC = [[XSQMineViewController alloc] init];
    self.mineVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUTHEAD-50);
    self.mineVC.title = @"我的";
    [self addChildViewController:self.mineVC];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

// 只要有新的cell出现的时候才会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // 移除之前子控制器view
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    // 取出对应的子控制器添加到对应cell上
    UIViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT_WITHOUTHEAD-50);
    [cell addSubview:vc.view];
    
    return cell;
}

- (void)moveOutWithViewController:(UIViewController *)vc{
    if (vc) {
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)titleButtons {
    
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)dealloc{
    [kUserDefaults removeObjectForKey:@"backFromLogin"];
    self.carVC = nil;
    self.mineVC = nil;
    self.subMallVC = nil;
}
@end
