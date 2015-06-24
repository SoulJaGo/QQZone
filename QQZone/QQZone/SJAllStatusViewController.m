//
//  SJAllStatusViewController.m
//  QQZone
//
//  Created by SoulJa on 15/6/24.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJAllStatusViewController.h"
#import "SJSegmentControl.h"
#import "SJNavigationController.h"

@interface SJAllStatusViewController ()

@end

@implementation SJAllStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SJSegmentControl *sc = [[SJSegmentControl alloc] init];
    self.view.backgroundColor = [UIColor blueColor];
    sc.items = @[@"全部",@"好友动态",@"好友"];
    sc.selectedIndex = 0;
    sc.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = sc;
}

@end
