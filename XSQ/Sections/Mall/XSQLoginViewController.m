//
//  XSQLoginViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQLoginViewController.h"
#import "XSQRegisterViewController.h"
#import "PublicMacro.h"

@interface XSQLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, strong)UIScrollView *bgScrollView;

@property (nonatomic, strong)NSString *index;
@end

@implementation XSQLoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [self login];
        return [RACSignal empty];
    }];
    
    
    //    RAC(self.loginButton,enabled) = [RACSignal combineLatest:@[self.usernameTextField.rac_textSignal,
    //                                                               self.passwordTextField.rac_textSignal] reduce:^(NSString* username, NSString* password){
    //                                                                   return @(username.length > 0 && password.length > 0);
    //                                                               }];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidDisappear:(BOOL)animated{
    //    [kUserDefaults setValue:@1 forKey:@"backFromLogin"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:nil];
}
- (IBAction)registerClick:(id)sender {
    XSQRegisterViewController *vc = [[XSQRegisterViewController alloc] initWithNibName:@"XSQRegisterViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];}
- (IBAction)rememberClick:(id)sender {
    
}

- (void)login
{
    if (isEmpty(self.usernameTextField.text)) {
        return [self showTips:@"请输入手机号码"];
    }
    
    if (isEmpty(self.passwordTextField.text)) {
        return [self showTips:@"请输入密码"];
    }
    if (self.rememberButton.selected != YES) {
        return [self showTips:@"请同意欣物业平台协议"];
    }
    [self showHUD];
    @weakify(self);
    [kRequest postWithURLString:kRequest.mapUrl[@"requestLogin"] parameters:@{@"user.userTel":NON(self.usernameTextField.text),@"user.user.userPassWord":NON(self.passwordTextField.text)} success:^(id responseObject) {
        if ([responseObject[@"status"] integerValue] == 0) {
            @strongify(self);
            [self hideHUD];
            [self showTips:@"登录成功"];
            [self loginSuccess];
        }
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self hideHUD];
        [self showError:error];
    }];
}
//登录成功后，跳转并发送成功信号
-(void)loginSuccess
{
    kUserModule.userID = self.usernameTextField.text;
    kUserModule.userToken = @"test";
    [kUserModule save];
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.loginBlock) {
        self.loginBlock(@(YES));
    }
}
+ (void)LoadDefaultVcWithIndex:(BackIndexBlock)backIndex{
    if (backIndex) {
        backIndex(3);
    }
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
