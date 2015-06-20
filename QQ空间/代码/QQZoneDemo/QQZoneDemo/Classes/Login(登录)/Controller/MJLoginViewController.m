//
//  MJLoginViewController.m
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-25.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJLoginViewController.h"
#import "MJMainViewController.h"

@interface MJLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *rememberPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
- (IBAction)buttonClick:(UIButton *)button;

- (IBAction)login;
@end

@implementation MJLoginViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.loginButton setBackgroundImage:[UIImage resizedImageWithName:@"login_button_normal"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage resizedImageWithName:@"login_button_pressed"] forState:UIControlStateHighlighted];
    self.view.backgroundColor = MJGlobalBgColor;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 文本框代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.accountField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        [self login];
    }
    return YES;
}

#pragma mark - 按钮点击
- (IBAction)buttonClick:(UIButton *)button {
    // 状态取反
    button.selected = !button.isSelected;
    
    // 其他操作
    if (button == self.rememberPasswordButton && !button.isSelected) {
        self.autoLoginButton.selected = NO;
    } else if (button == self.autoLoginButton && button.isSelected) {
        self.rememberPasswordButton.selected = YES;
    }
}

- (IBAction)login {
    // 1.如果没有输入帐号
    NSString *account = self.accountField.text;
    if (account.length == 0) {
        [self shake];
        [self showError:@"请输入帐号"];
        return;
    }
    
    // 2.如果没有输入密码
    NSString *password = self.passwordField.text;
    if (password.length == 0) {
        [self shake];
        [self showError:@"请输入密码"];
        return;
    }
    
    // 3.发送请求
    [self.loadingView startAnimating];
    self.view.userInteractionEnabled = NO;
    
    CGFloat delay = 2.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingView stopAnimating];
        self.view.userInteractionEnabled = YES;
        
        // 帐号错误
        if (![account isEqualToString:@"123"]) {
            [self showError:@"请输入正确的帐号"];
            return;
        }
        
        // 密码错误
        if (![password isEqualToString:@"123"]) {
            [self showError:@"请输入正确的密码"];
            return;
        }
        
        // 跳转控制器
        MJMainViewController *mainVc = [[MJMainViewController alloc] init];
        self.view.window.rootViewController = mainVc;
    });
}

- (void)shake
{
    CAKeyframeAnimation *shakeAnim = [CAKeyframeAnimation animation];
    shakeAnim.keyPath = @"transform.translation.x";
    CGFloat margin = 10;
    shakeAnim.values = @[@0, @(-margin), @(margin), @0];
    shakeAnim.duration = 0.2;
    shakeAnim.repeatCount = 2;
    [self.loginView.layer addAnimation:shakeAnim forKey:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 */
- (void)showError:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
@end
