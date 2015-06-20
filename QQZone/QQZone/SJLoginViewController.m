//
//  SJLoginViewController.m
//  QQZone
//
//  Created by SoulJa on 15/6/20.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJLoginViewController.h"
#import "UIImage+SJ.h"
#import "SJMainViewController.h"
@interface SJLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)login;
- (IBAction)checkboxClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *rememberPasswordBox;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBox;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@end
@implementation SJLoginViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.loadingView stopAnimating];
    [self.loginButton setBackgroundImage:[UIImage resizeImageWithName:@"login_button_normal"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage resizeImageWithName:@"login_buton_pressed"] forState:UIControlStateHighlighted];
}
- (IBAction)login {
    //1.验证账号
    NSString *account = self.accountField.text;
    if (account.length == 0) {
        [self showError:@"请输入账号"];
        return;
    }
    
    //2.验证密码
    NSString *password = self.passwordField.text;
    if (password.length == 0) {
        [self showError:@"请输入密码"];
        return;
    }
    
    //3.发送请求
    self.view.userInteractionEnabled = NO;
    [self.loadingView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //4.请求完毕
        [self.loadingView stopAnimating];
        self.view.userInteractionEnabled = YES;
        
        //5.账号密码同时为123才正确
        if (![account isEqualToString:@"123"]) {
            [self showError:@"请输入正确的密码"];
            return;
        }
        if (![password isEqualToString:@"123"]) {
            [self showError:@"请输入正确的密码"];
            return;
        }
        
        //6.登陆成功
        self.view.window.rootViewController = [[SJMainViewController alloc] init];
    });
}

- (IBAction)checkboxClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender == self.rememberPasswordBox) {
        if (!sender.isSelected) {
            self.autoLoginBox.selected = NO;
        }
    } else if (sender == self.autoLoginBox) {
        if (sender.selected) {
            self.rememberPasswordBox.selected = YES;
        }
    }
}

- (void)showError:(NSString *)errorMsg
{
    //1.弹框提醒
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    //2.抖动
    CAKeyframeAnimation *shakeAnim = [CAKeyframeAnimation animation];
    shakeAnim.keyPath = @"transform.translation.x";
    shakeAnim.repeatCount = 2;
    shakeAnim.values = @[@0,@-15,@15,@0];
    shakeAnim.duration = 0.2;
    [self.loginView.layer addAnimation:shakeAnim forKey:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma -mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.accountField) {
        [self.passwordField becomeFirstResponder];
    } else {
        [self login];
    }
    return YES;
}
@end
