//
//  XSQSubMallViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQSubMallViewController.h"
#import <SDCycleScrollView.h>
#import "SortLayout.h"
#import "MallClassCell.h"
#import "SalesCell.h"
#import "AdvertismentCell.h"
#import "SallHeaderCell.h"
#import "PublicMacro.h"
#import "XSQSubMallData.h"
#import <AFNetworkReachabilityManager.h>

@interface XSQSubMallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchControllerDelegate,UISearchBarDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong)UICollectionView *sortCollectionView;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *titleArray;
@property (nonatomic, strong)NSMutableArray *sortArray;

@end

@implementation XSQSubMallViewController
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化商品分类
    [self setupShopClass];
    // Do any additional setup after loading the view.
}
#pragma mark -- 商品分类
- (void)setupShopClass{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showHUD];
        @weakify(self);
        [kRequest postWithURLString:kRequest.mapUrl[@"requestCircleScrollAndIconInMall"] parameters:nil success:^(id responseObject) {
            @strongify(self);
            [self hideHUD];
            if (responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    id object = (NSDictionary*)responseObject[NON(@"tblist")];
                    id ob = (NSDictionary*)responseObject[NON(@"lblist")];
                    if (([object isKindOfClass:[NSArray class]]) && ([ob isKindOfClass:[NSArray class]])) {
                        
                        NSArray *array = (NSArray*)object;
                        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            NSError *error;
                            XSQMallAdvertis *data = [[XSQMallAdvertis alloc] initWithDictionary:obj error:&error];
                            NSString *address  = @"http://222.240.1.133";
                            if ([data.mallPeizhiType isEqualToString: @"图片"]) {
                                address = [address stringByAppendingString: data.mallPeizhiValue];
                                [self.sortArray addObject:address];
                                [self.titleArray addObject:data.mallPeizhiBeiyong];
                            }
                            
                        }];
                        
                        NSArray *arr = (NSArray*)ob;
                        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            NSError *error;
                            XSQMallAdvertis *data = [[XSQMallAdvertis alloc] initWithDictionary:obj error:&error];
                            NSString *address  = @"http://222.240.1.133";
                            if ([data.mallPeizhiType isEqualToString: @"轮播图"]) {
                                address = [address stringByAppendingString: data.mallPeizhiValue];
                                [self.dataArray addObject:address];
                            }
                            else{
                                return ;
                            }
                        }];
                        
                    }
                }
                
                [self.sortCollectionView reloadData];
            }
        }
                            failure:^(NSError *error) {
                                @strongify(self);
                                [self hideHUD];
                                [self showError:error];
                            }];
        
    });
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    SortLayout *sortLayout = [[SortLayout alloc] init];
    sortLayout.minimumInteritemSpacing = 12.5;
    sortLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    sortLayout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH-20, 50);
    
    self.sortCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-5, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:sortLayout];
    [self.sortCollectionView registerNib:[MallClassCell nib] forCellWithReuseIdentifier:[MallClassCell identifier]];
    [self.sortCollectionView registerNib:[SalesCell nib] forCellWithReuseIdentifier:[SalesCell identifier]];
    [self.sortCollectionView registerNib:[AdvertismentCell nib] forCellWithReuseIdentifier:[AdvertismentCell identifier]];
    [self.sortCollectionView registerNib:[SallHeaderCell nib] forCellWithReuseIdentifier:[SallHeaderCell identifier]];
    [self.sortCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    self.sortCollectionView.backgroundColor = ColorFromHex(0xF5F5F5);
    self.sortCollectionView.pagingEnabled = YES;
    self.sortCollectionView.delegate = self;
    self.sortCollectionView.dataSource = self;
    
    [self.scrollView addSubview:self.sortCollectionView];
}

#pragma mark -- 设置搜索框
- (UISearchBar *)setupSearchBar {
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 30)];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = 30/2;
    searchBar.placeholder = @"请输入商品类型";
    searchBar.delegate = self;
    searchBar.tintColor = [UIColor grayColor];
    searchBar.showsCancelButton = YES;
    return searchBar;
    //    [self.scrollView addSubview:searchBar];
}

#pragma mark -- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
}


#pragma mark -- SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //jump
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}
#pragma mark -- UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            MallClassCell *classCell;
            classCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MallClassCell identifier] forIndexPath:indexPath];
            if (self.sortArray.count==0) {
                classCell.sortImageView.image = [UIImage imageNamed:@"mall_sort_placeholder_icon"];
                classCell.sortName.text = @"";
            }else{
                classCell.sortName.text = self.titleArray[indexPath.row];
                [classCell.sortImageView sd_setImageWithURL:[NSURL URLWithString:self.sortArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"mall_sort_placeholder_icon"]];
            }
            return classCell;
        }
        case 1:
        {
            AdvertismentCell *advertismentCell;
            advertismentCell = [collectionView dequeueReusableCellWithReuseIdentifier:[AdvertismentCell identifier] forIndexPath:indexPath];
            advertismentCell.cycleScrollView.imageURLStringsGroup = self.dataArray;
            advertismentCell.cycleScrollView.placeholderImage = [UIImage imageNamed:@"scroll_test1"];
            advertismentCell.cycleScrollView.autoScrollTimeInterval = 2.0;
            advertismentCell.cycleScrollView.delegate = self;
            return advertismentCell;
        }
            break;
        case 2:
        {
            SallHeaderCell *sallHeaderCell;
            sallHeaderCell = [collectionView dequeueReusableCellWithReuseIdentifier:[SallHeaderCell identifier] forIndexPath:indexPath];;
            return sallHeaderCell;
        }
            break;
        case 3:
        {
            SalesCell *salesCell;
            salesCell = [collectionView dequeueReusableCellWithReuseIdentifier:[SalesCell identifier] forIndexPath:indexPath];
            [salesCell.productImageView sd_setImageWithURL:[NSURL URLWithString:@"http://image.baidu.com/search/down?tn=download&ipn=dwnl&word=download&ie=utf8&fr=result&url=http%3A%2F%2Fwww.5888.tv%2FUpload_Map%2Fuploads%2F2016%2F03%2F2016-03-30-10-33-15-58334.jpg&thumburl=http%3A%2F%2Fimg5.imgtn.bdimg.com%2Fit%2Fu%3D2979009410%2C1480808809%26fm%3D21%26gp%3D0.jpg"]];
            salesCell.priceLabel.text = self.dataArray[indexPath.row];
            return salesCell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            if (self.sortArray.count>0) {
                return self.sortArray.count;
            }
            if (self.sortArray.count==0) {
                return 8;
            }
            [self.sortCollectionView reloadData];
            return self.sortArray.count;
            break;
        case 3:
            return self.dataArray.count;
            break;
        default:
            break;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (indexPath.section==0) {
        if (kind == UICollectionElementKindSectionFooter)
        {
            UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            reusableView = footerview;
            [reusableView addSubview:[self setupSearchBar]];
        }
    }else{
        if (kind == UICollectionElementKindSectionFooter)
        {
            UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            reusableView = footerview;
            [reusableView removeFromSuperview];
        }
    }
    return reusableView;
}
#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        return CGSizeMake(SCREEN_WIDTH-40, 130);
    }
    if (indexPath.section==2) {
        return CGSizeMake(SCREEN_WIDTH-40, 28);
    }
    if (indexPath.section==3) {
        return CGSizeMake((SCREEN_WIDTH-60)/3, 87);
    }
    return CGSizeMake(SCREEN_WIDTH/4-10, 67);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return UIEdgeInsetsMake(10, 5, 20, 5);
    }
    if (section==1) {
        return UIEdgeInsetsMake(20, 20, 0, 10);
    }
    if (section==3) {
        return UIEdgeInsetsMake(0, 25, 0, 15);
    }
    return UIEdgeInsetsMake(20, 20, 20, 10);
}
//行列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section==3) {
        return 10;
    }
    return 0;
}
// footer size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(SCREEN_WIDTH-30, 30);
    }
    return CGSizeZero;
}

- (NSMutableArray *)sortArray{
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
    }
    return _sortArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
