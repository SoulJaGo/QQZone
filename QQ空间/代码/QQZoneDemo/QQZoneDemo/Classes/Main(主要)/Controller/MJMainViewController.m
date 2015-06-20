//
//  MJMainViewController.m
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-25.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJMainViewController.h"
#import "MJDock.h"

@interface MJMainViewController ()
@property (weak, nonatomic) MJDock *dock;
@end

@implementation MJMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.背景色
    self.view.backgroundColor = MJGlobalBgColor;
    
    // 2.添加dock
    MJDock *dock = [[MJDock alloc] init];
    dock.frame = CGRectMake(0, 0, MJDockPortraitW, self.view.frame.size.height);
//    dock.backgroundColor = [UIColor redColor];
    dock.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:dock];
    self.dock = dock;
    
    // 3.利用刚开始的屏幕方向设置dock
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0.0];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        BOOL lanscape = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
        
        [self.dock rotate:lanscape];
    }];
}

@end
