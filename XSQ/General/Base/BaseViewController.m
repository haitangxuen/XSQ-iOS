//
//  BaseViewController.m
//  PublicModule
//
//  Created by zhoupengli on 15/4/16.
//  Copyright (c) 2015年 ThinkDIT. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "PublicMacro.h"

@interface BaseViewController ()
{
    MBProgressHUD *HUD;
    int countHUD;
    
    UIActivityIndicatorView *activity;
    int countActivity;
    
    UIView *titleView;
    UILabel *titleLabel;
    
    UIView *backgroud;
    UIActivityIndicatorView *activityBG;
    UIImageView *imageNonet;
    UILabel *labError;
    UILabel *labRetry;
}
@end

@implementation BaseViewController

-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view.
    countHUD = 0;
    countActivity = 0;
    
    self.view.backgroundColor = JColor_Background;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setTitle:(NSString *)str
//{
//    if (str.length>2) {
//        super.title = @"返回";
//    } else {
//        super.title = str;
//    }
//    
//    if (str.length > 10) {
//        [self setNavTitle:[NSString stringWithFormat:@"%@...",[str substringToIndex:10]]];
//    } else {
//        [self setNavTitle:str];
//    }
//}

- (void)setNavTitle:(NSString*)title
{
    UIFont *font = FONT(18);
    if (titleLabel == nil) {
        float w = [title sizeWithAttributes:@{NSFontAttributeName:font}].width;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 30)];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = font;
        titleLabel.textAlignment = NSTextAlignmentCenter;

        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.left = w;
        activity.centerY = 15;
        
        titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 30)];
        titleView.backgroundColor = [UIColor clearColor];
        
        [titleView addSubview:titleLabel];
        [titleView addSubview:activity];
        [self.navigationItem setTitleView:titleView];
    } else {
        float w = [title sizeWithAttributes:@{NSFontAttributeName:font}].width;
        titleView.width = w;
        titleLabel.width = w;
        activity.left = w;
        
        titleLabel.text = title;
    }
}

- (void)startAnimating
{
    if (countActivity == 0) {
        [activity startAnimating];
    }
    countActivity++;
}

- (void)stopAnimating
{
    countActivity--;
    if (countActivity < 1) {
        [activity stopAnimating];
        countActivity = 0;
    }
}

- (void)showHUD
{
    if (countHUD == 0) {
        if(HUD == nil) {
            HUD = [[MBProgressHUD alloc] initWithView:kAppDelegate.window];
            HUD.animationType = MBProgressHUDAnimationZoom;
            [kAppDelegate.window addSubview:HUD];
            //HUD.labelText = @"加载中";
            //HUD.color = SHORTCOLOR(0x66);
            HUD.yOffset = -45;
        }
        [HUD show:YES];
    }
    countHUD++;
}

- (void)hideHUD
{
    countHUD--;
    if (countHUD < 1) {
        [HUD hide:YES];
        countHUD = 0;
    }
}

- (void)showTips:(NSString*)tips
{
    MBProgressHUD *pHud = [[MBProgressHUD alloc] initWithView:kAppDelegate.window];
    [kAppDelegate.window addSubview:pHud];
    
    // Set custom view mode
    pHud.mode = MBProgressHUDModeCustomView;
    pHud.removeFromSuperViewOnHide = YES;
    pHud.detailsLabelText = tips;
    pHud.detailsLabelFont = FONT(15);
    pHud.yOffset = -45;
    pHud.color = COLOR(0, 0, 0, 0.8f);
    
    [pHud show:YES];
    [pHud hide:YES afterDelay:1.5f];
}

- (void)showError:(NSError*)error
{
    if (error && error.localizedDescription && [error.localizedDescription isKindOfClass:[NSString class]] && error.localizedDescription.length>0) {
        [self showTips:error.localizedDescription];
    }
}

- (void)addBackgourd
{
    if (backgroud == nil) {
        backgroud = [CommonUI commonViewWithFrame:self.view.bounds color:[UIColor whiteColor]];
        [self.view addSubview:backgroud];
        
        activityBG = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityBG.centerX = backgroud.width/2;
        activityBG.centerY = backgroud.height/3;
        [backgroud addSubview:activityBG];
        
        imageNonet = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_tips_empty_data"]];
        imageNonet.center = activityBG.center;
        [backgroud addSubview:imageNonet];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger index = 0; index < 10; index++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_amt_%ld",(long)index]]];
        }
        imageNonet.animationImages = array;
        imageNonet.animationDuration = 0.7f;
        
        labError = [CommonUI commonLabelWithFrame:CGRectMake(0, imageNonet.bottom+10, backgroud.width, FONT(13).lineHeight)
                                                 text:@"网络不给力，无法加载"
                                                color:[UIColor grayColor]
                                                 font:FONT(13)
                                        textAlignment:NSTextAlignmentCenter];
        [backgroud addSubview:labError];
        
        labRetry = [CommonUI commonLabelWithFrame:CGRectMake(0, labError.top+20, backgroud.width, FONT(13).lineHeight)
                                                 text:@"点击屏幕重新加载"
                                                color:[UIColor grayColor]
                                                 font:FONT(13)
                                        textAlignment:NSTextAlignmentCenter];
        [backgroud addSubview:labRetry];
        
        imageNonet.hidden = YES;
        labError.hidden = YES;
        labRetry.hidden = YES;
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNonet)];
        [backgroud addGestureRecognizer:tap];
    }
    backgroud.hidden = NO;
    [self.view bringSubviewToFront:backgroud];
}

- (void)showNonet:(NSError *)error
{
    [self addBackgourd];
    
    imageNonet.hidden = NO;
    labError.hidden = NO;
    labRetry.hidden = NO;
    [imageNonet stopAnimating];
    
    labError.text = error.localizedDescription;
//    if (error.code > 20000) {
//        labError.text = error.localizedDescription;
//    } else {
//        labError.text = @"网络不给力，无法加载";
//    }    
}

//Loading
- (void)showLoading
{
    [self addBackgourd];
    
    imageNonet.hidden = NO;
    labError.hidden = NO;
    labRetry.hidden = YES;
    
    labError.text = @"努力加载中...";
    [imageNonet startAnimating];
//    [activityBG startAnimating];
}

- (void)hideLoading
{
    if (!backgroud.hidden) {
        backgroud.hidden  = YES;
        [imageNonet stopAnimating];
    }
}

- (void)tapNonet
{
    if (!imageNonet.hidden) {
        [self showLoading];
        [self nonetViewTouched];
    }
}

//无网络时，cell touch 事件
- (void)nonetViewTouched
{

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
