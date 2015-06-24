//
//  SJNavigationController.m
//  QQZone
//
//  Created by SoulJa on 15/6/24.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJNavigationController.h"

@interface SJNavigationController ()

@end

@implementation SJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!iOS7) {
        UINavigationBar *navBar = self.navigationBar;
        [navBar setBackgroundImage:[UIImage resizeImageWithName:@"NavigationBar_Background"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
