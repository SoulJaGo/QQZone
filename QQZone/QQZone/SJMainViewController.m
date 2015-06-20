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
@property (nonatomic,weak) UIView *dock;
@end
@implementation SJMainViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    //添加Dock
    SJDock *dock = [[SJDock alloc] init];
    dock.backgroundColor = [UIColor blueColor];
    CGFloat dockH = self.view.frame.size.height;
    dock.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    dock.frame = CGRectMake(0, 0, SJDockPortraitW, dockH);
    [self.view addSubview:dock];
    self.dock = dock;
}

/**
 *  当屏幕旋转时调用
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        CGRect dockF = self.dock.frame;
        dockF.size.width = SJDockLandscapeW;
        self.dock.frame = dockF;
    } else {
        CGRect dockF = self.dock.frame;
        dockF.size.width = SJDockPortraitW;
        self.dock.frame = dockF;
    }
}
@end
