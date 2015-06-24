//
//  SJComposeViewController.m
//  QQZone
//
//  Created by SoulJa on 15/6/24.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJComposeViewController.h"

@interface SJComposeViewController ()

@end

@implementation SJComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写说说";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
