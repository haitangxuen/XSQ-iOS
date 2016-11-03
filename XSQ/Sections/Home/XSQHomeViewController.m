//
//  HomeViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/26.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQHomeViewController.h"
#import "PublicMacro.h"
#import <SDCycleScrollView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "XSQAroundViewController.h"
#import "XSQMallViewController.h"
#import "XSQPropertyViewController.h"
#import "XSQLoginViewController.h"
#import "XSQOpenDoorViewController.h"
#import <MJRefresh.h>
#import "XSQHomeData.h"
#import "RefreshHeader.h"
#import <AFNetworkReachabilityManager.h>
#import "SURefreshHeader.h"

@interface XSQHomeViewController ()<SDCycleScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong)UILabel *notificationLabel;
@property (nonatomic, strong)UIImageView *messageImgView;
@property (nonatomic, strong)UILabel *welComeLabel;
@property (nonatomic, strong)UIButton *parcelQueryButton;
@property (nonatomic, strong)UIButton *parcelDetailButton;
@property (nonatomic, strong)UIButton *Property;
@property (nonatomic, strong)UIButton *Around;
@property (nonatomic, strong)UIButton *Mall;

@end

@implementation XSQHomeViewController
+ (instancetype)new
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    vc.automaticallyAdjustsScrollViewInsets = NO;
    return (XSQHomeViewController *)vc;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"欣商城";
    // 判断是否登录，暂时屏蔽
    //if (![kUserModule hasLogin]) {
    // [self.navigationController pushViewController:[[XSQLoginViewController alloc] init] animated:YES;
    //  }
    
    
    
    // MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
    
    //}];
    // 设置普通状态的动画图片
    // [header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    //[header setImages:pullingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    //[header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置header
    //self.tableView.mj_header = header;
    
    __weak __typeof(self) wkSelf = self;
    [self.tableView addRefreshHeaderWithHandle:^{
        XSQOpenDoorViewController *vc = [[XSQOpenDoorViewController alloc] init];
        [wkSelf.navigationController pushViewController:vc animated:YES];
        [wkSelf.tableView.header endRefreshing];
    }];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bg"]];
    
    //轮播视图
    [self setupCircleView];
    
    //轮播图上按钮
    [self setupTopButton];
    
    //中间视图
    [self setupCenterView];
    
    //底部标签
    [self setupTabBarView];
    
    
    // Do any additional setup after loading the view.
}
- (void)setupTopButton{
    
    UIView *headerView = [CommonUI commonViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) color:JColor_Clear];
    [self.cycleScrollView addSubview:headerView];
    
    UIButton *leftNavButton = [CommonUI commonButtonWithFrame:CGRectMake(0, 0, 75, 30) text:@"凯姆国际" color:JColor_White font:JFont_Middle backgroundImage:nil block:^(UIButton *btn) {
        
    }];
    
    leftNavButton.backgroundColor = JColor_Clear;
    [headerView addSubview:leftNavButton];
    
    UIButton *rightNavButton = [CommonUI commonButtonWithFrame:CGRectMake(SCREEN_WIDTH-34, (SCREEN_HEAD-STATUSBAR_HEIGHT)/2-17, 17, 17) text:nil color:nil font:JFont_Middle backgroundImage:[UIImage imageNamed:@"navi_notification_button_icon"] block:^(UIButton *btn) {
        
    }];
    
    rightNavButton.backgroundColor = JColor_Clear;
    [headerView addSubview:rightNavButton];
    
}

- (void)setupCircleView{
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT/3) delegate:self placeholderImage:[UIImage imageNamed:@"scroll_test1"]];
    self.cycleScrollView.backgroundColor = JColor_Clear;
    
    [self showHUD];
    dispatch_async(dispatch_get_main_queue(), ^{
        @weakify(self);
        [kRequest postWithURLString:kRequest.mapUrl[@"requestCircleScrollInHome"] parameters:nil success:^(id responseObject) {
            @strongify(self);
            [self hideHUD];
            if (responseObject) {
                XSQHomeAdvertis *homeData = [[XSQHomeAdvertis alloc] init];
                [homeData praseResponseObject:responseObject];
                
                NSMutableArray *cycleArrar = [NSMutableArray array];
                if (homeData.dataArray) {
                    [homeData.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSError *error;
                        XSQHomeAdvertis *data = [[XSQHomeAdvertis alloc]
                                                 initWithDictionary:obj error:&error];
                        
                        NSLog(@"%@",data.mallPeizhiValue);
                        NSString *address  = @"http://222.240.1.133";
                        address = [address stringByAppendingString: data.mallPeizhiValue];
                        [cycleArrar addObject:address];
                    }];
                    
                }
                self.cycleScrollView.imageURLStringsGroup = cycleArrar;
            }
        } failure:^(NSError *error) {
            @strongify(self);
            [self hideHUD];
            [self showError:error];
        }];
    });
#if 0
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (kAppDevice.netstatus == AFNetworkReachabilityStatusUnknown) {
            [self showTips:@"未知网络"];
            return;
        }
        if (kAppDevice.netstatus == AFNetworkReachabilityStatusNotReachable) {
            [self showTips:@"无法联网"];
            return;
        }
    });
#endif
    self.cycleScrollView.autoScrollTimeInterval = 2.0;
    self.cycleScrollView.delegate = self;
    [self.tableView addSubview:self.cycleScrollView];
    
}
- (void)setupCenterView{
    
    self.messageImgView = [CommonUI commonImageViewWithFrame:CGRectMake(15, self.cycleScrollView.bottom+5, 16, 15.7) image:[UIImage imageNamed:@"home_message_icon"]];
    [self.tableView addSubview:self.messageImgView];
    
    self.notificationLabel = [CommonUI commonLabelWithFrame:CGRectMake(self.messageImgView.right+20, self.messageImgView.mj_y, SCREEN_WIDTH-self.messageImgView.right-20, 15.7) text:@"各位亲爱的业主，12月30日停水。。。。" color:JColor_White font:JFont_Small textAlignment:NSTextAlignmentLeft];
    [self.tableView addSubview:self.notificationLabel];
    
    self.welComeLabel = [CommonUI commonLabelWithFrame:CGRectMake(15, self.notificationLabel.mj_y+self.notificationLabel.height+20, SCREEN_WIDTH, 50) text:@"你好，尊敬的用户" color:JColor_White font:JFont_Large textAlignment:NSTextAlignmentLeft];
    [self.tableView addSubview:self.welComeLabel];
    
    //    @weakify(self);
    self.parcelQueryButton = [CommonUI commonButtonWithFrame:CGRectMake(15, self.welComeLabel.mj_y + self.welComeLabel.height+15, SCREEN_WIDTH/2, 20) text:@"邮包查询 >>" color:JColor_White selectColor:JColor_Green font:JFont_Small backgroundImage:nil block:^(UIButton *btn) {
        //         strongify(self);
        self.parcelQueryButton.selected = YES;
        
    }];
    self.parcelQueryButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.tableView addSubview:self.parcelQueryButton];
    
    self.parcelDetailButton = [CommonUI commonButtonWithFrame:CGRectMake(15, self.parcelQueryButton.mj_y + self.parcelQueryButton.height+20, SCREEN_WIDTH, 20) text:@"邮包查询详情详情详情详情详情详情详情" color:JColor_White font:JFont_Small backgroundImage:nil block:^(UIButton *btn) {
    }];
    self.parcelDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.tableView addSubview:self.parcelDetailButton];
    
}

- (void)setupTabBarView{
    CGFloat tab_padding= (SCREEN_WIDTH-3*64)/4.0;
    
    @weakify(self);
    self.Property = [CommonUI commonButtonWithFrame:CGRectMake(tab_padding, SCREEN_HEIGHT_WITHOUTHEAD - 100 - 64  + self.parcelQueryButton.height+20, 64, 64) text:@"欣物业" color:JColor_White font:JFont_Small backgroundImage:[UIImage imageNamed:@"property"] block:^(UIButton *btn) {
        XSQPropertyViewController *vc = [[XSQPropertyViewController alloc] initWithNibName:nil bundle:nil];
        @strongify(self);
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.Property setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -95, 0)];
    [self.tableView addSubview:self.Property];
    
    self.Around = [CommonUI commonButtonWithFrame:CGRectMake(self.Property.mj_x+64+tab_padding, self.Property.mj_y, 64, 64) text:@"欣周边" color:JColor_White font:JFont_Small backgroundImage:[UIImage imageNamed:@"around"] block:^(UIButton *btn) {
        XSQAroundViewController *vc = [[XSQAroundViewController alloc] initWithNibName:nil bundle:nil];
        @strongify(self);
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.Around setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -95, 0)];
    [self.tableView addSubview:self.Around];
    
    self.Mall = [CommonUI commonButtonWithFrame:CGRectMake(self.Around.mj_x+64+tab_padding, self.Around.mj_y, 64, 64) text:@"欣商城" color:JColor_White font:JFont_Small backgroundImage:[UIImage imageNamed:@"mall"] block:^(UIButton *btn) {
        XSQMallViewController *vc = [[XSQMallViewController alloc] initWithNibName:nil bundle:nil];
        @strongify(self);
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.Mall setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -95, 0)];
    [self.tableView addSubview:self.Mall];
    
}

- (void)tableRefrsh:(UITableView *)tableView
{
    NSLog(@"..");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //jump
    switch (index) {
        case 0:
        {
            XSQOpenDoorViewController *vc = [[XSQOpenDoorViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 1:
            
            break;
            
        case 2:
            
            break;
            
            
        default:
            break;
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

@end
