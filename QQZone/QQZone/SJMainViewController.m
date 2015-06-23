//
//  SJMainViewController.m
//  QQZone
//
//  Created by SoulJa on 15/6/20.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJMainViewController.h"
#import "SJDock.h"
@interface SJMainViewController ()
@property (nonatomic,weak) SJDock *dock;
@end
@implementation SJMainViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = SJGlobalBgColor;
    
    // 添加dock
    SJDock *dock = [[SJDock alloc] init];
#warning 一定要添加
    dock.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    dock.height = self.view.height;
    [self.view addSubview:dock];
    self.dock = dock;
    
    // 根据当前的屏幕方向设置dock的属性
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0.0];
}

/**
 *  当屏幕旋转时调用
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.dock rotate:UIInterfaceOrientationIsLandscape(toInterfaceOrientation)];
}
@end
