////
////  XSQSalesCollectionViewController.m
////  XSQ
////
////  Created by black_dex on 2016/10/29.
////  Copyright © 2016年 com.yxld. All rights reserved.
////
//
//#import "XSQSalesCollectionViewController.h"
//#import "SalesCell.h"
//#import "PublicMacro.h"
//@interface XSQSalesCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
//@property (nonatomic, strong)NSMutableArray *dataArray;
//@property (nonatomic, strong)UICollectionView *collectionView;
//@end
//
//@implementation XSQSalesCollectionViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    // Uncomment the following line to preserve selection between presentations
//    // self.clearsSelectionOnViewWillAppear = NO;
//    
//    // Register cell classes
//    UICollectionViewFlowLayout *salesLayout = [[UICollectionViewFlowLayout alloc] init];
//    salesLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    salesLayout.itemSize = CGSizeMake((SCREEN_WIDTH-20)/3, 160);
//    
//    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:salesLayout];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[SalesCell identifier]];
//    
//    [self.collectionView registerNib:[SalesCell nib] forCellWithReuseIdentifier:[SalesCell identifier]];
//    self.collectionView.backgroundColor = JColor_White;
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    
//    [self.view addSubview:self.collectionView];
//    // Do any additional setup after loading the view.
//}
//#pragma mark -- UICollectionViewDataSource
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    SalesCell *salesCell;
//    salesCell = [collectionView dequeueReusableCellWithReuseIdentifier:[SalesCell identifier] forIndexPath:indexPath];
//    salesCell.priceLabel.text = self.dataArray[indexPath.row];
//    return salesCell;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//
//#pragma mark -- UICollectionViewDelegate
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"%ld",indexPath.row);
//}
//
//#pragma mark -- UIScrollViewDelegate
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 5, 0, 5);
//}
//
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
//- (NSMutableArray *)dataArray{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray arrayWithObjects:@"饮品",@"烟酒",@"零食",@"全部",@"米面油",@"调料",nil];
//    }
//    return _dataArray;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//@end
