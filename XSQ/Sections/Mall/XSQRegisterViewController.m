//
//  XSQRegisterViewController.m
//  XSQ
//
//  Created by black_dex on 2016/10/27.
//  Copyright © 2016年 com.yxld. All rights reserved.
//

#import "XSQRegisterViewController.h"
#import "PublicMacro.h"
#import <SMS_SDK/SMSSDK.h>
#import <AFHTTPRequestOperationManager.h>
#import "HttpRequest+User.h"
#import "XSQLoginViewController.h"

@interface XSQRegisterViewController ()
{
    NSInteger nTimer;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getIdentifyCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end

@implementation XSQRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    @weakify(self);
    
    self.getIdentifyCodeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        // 获取验证码
        [self getIdentifyCode];
        return [RACSignal empty];
    }];
    self.agreeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.agreeButton.selected = NO;
        return [RACSignal empty];
    }];
    self.agreeButton.selected = YES;
    //    [self.registerButton addTarget:self action:@selector(registerClicked) forControlEvents:UIControlEventTouchUpInside];
    //    RAC(self.registerButton,enabled) = [RACSignal combineLatest:@[self.phoneNumberTextField.rac_textSignal,
    //                                                                  self.passwordTextField.rac_textSignal,self.identifyCodeTextField.rac_textSignal] reduce:^(NSString* username, NSString* password,NSString* code){
    //                                                                      return @(username.length>0 && password.length>0 && code.length>0);
    //                                                                  }];
    // Do any additional setup after loading the view from its nib.
}
- (void)registerClicked{
    if (isEmpty(self.passwordTextField.text)) {
        return [self showTips:@"请填写的手机号码"];
    }
    
    if (self.phoneNumberTextField.text.length != 11) {
        return [self showTips:@"请填写正确格式的手机号码"];
    }
    
    if (isEmpty(self.identifyCodeTextField.text)) {
        return [self showTips:@"请填写验证码"];
    }
    
    if (isEmpty(self.passwordTextField.text)) {
        return [self showTips:@"请填写密码"];
    }
    
    if (self.passwordTextField.text.length<4 || self.passwordTextField.text.length >18) {
        return [self showTips:@"密码长度为4-16个字符"];
    }
    
    if (self.agreeButton.selected == NO) {
        return [self showTips:@"请同意欣物业管理平台协议"];
    }
    
    [self showHUD];
    [self requestRegister];
    
}

- (IBAction)registerClick:(id)sender {
    if (self.agreeButton.selected == NO) {
        [self showTips:@"请同意欣物业管理平台协议"];
    }else{
        [self requestRegister];
    }
    
}
- (void)getIdentifyCode{
    if (isEmpty(self.phoneNumberTextField.text)) {
        return [self showTips:@"手机号不能为空"];
    }
    if (self.phoneNumberTextField.text.length!=11) {
        return [self showTips:@"请输入正确的手机号"];
    }
    [self showHUD];
    @weakify(self);
    [[HttpRequest sharedInstance] postWithURLString:kRequest.mapUrl[@"requestCheckRegister"]
                                         parameters:@{@"user.userTel":NON(self.phoneNumberTextField.text)} success:^(id responseObject) {
                                             NSLog(@"%@",responseObject[@"status"]);
                                             if ([responseObject[@"status"] integerValue] == 0) {
                                                 @strongify(self);
                                                 [self hideHUD];
                                                 self.getIdentifyCodeButton.enabled = NO;
                                                 nTimer = 60;
                                                 [self.getIdentifyCodeButton setTitle:[NSString stringWithFormat:@"%lds",(long)nTimer] forState:UIControlStateDisabled];
                                                 timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
                                                 [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTextField.text zone:@"+86" customIdentifier:nil result:^(NSError *error) {
                                                     if (error) {
                                                         [self showTips:@"获取短信验证码错误"];
                                                     }else{
                                                         
                                                     }
                                                     
                                                 }];
                                             }else{
                                                 @strongify(self);
                                                 [self showTips:responseObject];
                                             }
                                             
                                         } failure:^(NSError *error) {
                                             @strongify(self);
                                             [self hideHUD];
                                             [self showError:error];
                                         }];
    
}

- (void)timerFireMethod:(NSTimer *)ttimer
{
    nTimer--;
    if (nTimer>0) {
        [self.getIdentifyCodeButton setTitle:[NSString stringWithFormat:@"%lds",(long)nTimer] forState:UIControlStateDisabled];
    } else {
        if ([timer isValid]) {
            [timer invalidate];
        }
        self.getIdentifyCodeButton.enabled = YES;
    }
}

- (void)requestRegister{
    
    [[HttpRequest sharedInstance] postWithURLString:kRequest.mapUrl[@"requestRegister"] parameters:@{@"user.userTel":self.passwordTextField.text,@"user.userPassWord":self.passwordTextField.text} success:^(id responseObject) {
        if (responseObject) {
            [self showTips:@"注册成功"];
            [self.navigationController pushViewController:[[XSQLoginViewController alloc] init] animated:YES];
            //跳转
        }
    } failure:^(NSError *error) {
        [self showError:error];
    }];
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
