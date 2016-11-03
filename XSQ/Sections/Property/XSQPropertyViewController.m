//
//  XSQPropertyViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/26.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQPropertyViewController.h"

@interface XSQPropertyViewController ()

@end

@implementation XSQPropertyViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Property" bundle:nibBundleOrNil];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"XSQPropertyViewController"];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"欣物业";
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
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
