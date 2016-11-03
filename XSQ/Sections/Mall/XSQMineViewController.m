//
//  XSQMineViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQMineViewController.h"
#import "XSQRegisterViewController.h"
#import "XSQLoginViewController.h"
#import "PublicMacro.h"
@interface XSQMineViewController ()
@property (weak, nonatomic) IBOutlet UIButton *resetPasswordButton;

@end

@implementation XSQMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    
    @weakify(self);
    self.resetPasswordButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        XSQLoginViewController *vc = [[XSQLoginViewController alloc] initWithNibName:@"XSQLoginViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
        return [RACSignal empty];
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
