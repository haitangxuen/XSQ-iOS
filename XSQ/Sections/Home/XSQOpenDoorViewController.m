//
//  XSQOpenDoorViewController.m
//  XSQ
//
//  Created by black_dex on 2016/11/1.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQOpenDoorViewController.h"
#import "UIViewController+Helper.h"

@interface XSQOpenDoorViewController ()

@end

@implementation XSQOpenDoorViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机开门";
    
    [self setupRightNavButton:[UIImage imageNamed:@"share_button_icon"] withOffset:-10 block:^(UIButton *btn) {
        
    }];
    // Do any additional setup after loading the view from its nib.
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
