//
//  RefreshHeader.m
//  Max
//
//  Created by 鹏程万里 on 15/12/19.
//  Copyright © 2015年 ThinkDIT. All rights reserved.
//

#import "RefreshHeader.h"
#import "PublicMacro.h"

@interface RefreshHeader()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *mango;
@property (strong, nonatomic) UIImageView *flower;

@end

@implementation RefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 70+FONT(12).lineHeight;
    
    // 添加label
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, FONT(12).lineHeight)];
    _label.textColor = JColor_LightGray;
    _label.font = FONT(12);
    _label.backgroundColor = JColor_Red;
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
    // image 300
//    _mango = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 64, 56)];
//    _mango.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:_mango];
    
//    [_mango setImage:[UIImage imageNamed:@"loading_amt"]];
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSInteger index = 0; index < 10; index++) {
//        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_amt_%ld",(long)index]]];
//    }
//    _mango.animationImages = array;
    _mango.animationDuration = 0.7f;
    
    //flower
//    _flower = [CommonUI commonImageViewWithFrame:CGRectMake(0, 0, 14.6f, 10.8f)
//                                               image:[UIImage imageNamed:@"loading_flower"]];
//    _flower.contentMode = UIViewContentModeScaleAspectFit;
    
//    [self addSubview:_flower];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    _mango.top = 10;
    _mango.centerX = self.width/2-5;
    
    _flower.right = _mango.right-3;
    
//    _label.top = _mango.bottom + 4;
    _label.centerX = self.width/2;
    
    _label.top = 20;

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [_mango stopAnimating];
            _flower.hidden = NO;
            break;
        case MJRefreshStatePulling:
            [_mango stopAnimating];
            _flower.hidden = NO;
            break;
        case MJRefreshStateRefreshing:
            [_mango startAnimating];
            _flower.hidden = YES;
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    float p = pullingPercent<1?pullingPercent:1;
    _flower.top = p*p*p*33;
}

@end
