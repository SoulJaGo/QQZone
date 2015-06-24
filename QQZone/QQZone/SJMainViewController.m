//
//  SJMainViewController.m
//  QQZone
//
//  Created by SoulJa on 15/6/20.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJMainViewController.h"
#import "SJDock.h"
#import "SJAllStatusViewController.h"
#define SJRandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]
#define SJContentViewW 600
@interface SJMainViewController () <SJTabBarDelegate>
@property (nonatomic,weak) SJDock *dock;
@property (nonatomic, weak) UIViewController *currentChildViewController;
/**
 *  存放右边子控制器的view
 */
@property (nonatomic, weak) UIView *contentView;
@end
@implementation SJMainViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.初始化Dock
    [self setupDock];
    
    // 2.初始化contentView
    [self setupContentView];
    
    // 3.初始化控制器
    [self setupChildViewControllers];
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.width = SJContentViewW;
    contentView.height = self.view.height;
    contentView.x = self.dock.width;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

/**
 *  初始化子控制器
 */
- (void)setupChildViewControllers
{
    SJAllStatusViewController *allStatus = [[SJAllStatusViewController alloc] init];
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:allStatus];
    [self addChildViewController:nav0];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = SJRandomColor;
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [self addChildViewController:nav1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = SJRandomColor;
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    [self addChildViewController:nav2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = SJRandomColor;
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    [self addChildViewController:nav3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = SJRandomColor;
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    [self addChildViewController:nav4];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    vc5.view.backgroundColor = SJRandomColor;
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    [self addChildViewController:nav5];
    
    // 点击头像显示的主页控制器
    UIViewController *home = [[UIViewController alloc] init];
    home.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    [self addChildViewController:homeNav];

}

#pragma mark - SJTabBarDelegate
- (void)tabBar:(SJTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    // 1.新控制器
    UIViewController *newVc = self.childViewControllers[to];
    if (newVc.view.superview) return;
    newVc.view.frame = self.contentView.bounds;
    
    // 2.旧控制器
    UIViewController *oldVc;
    // 取出最后一个子控制器
    UIViewController *lastVc = [self.childViewControllers lastObject];
    if (lastVc.view.superview) { // 如果最后一个控制器正在显示
        oldVc = lastVc;
    } else {
        oldVc = self.childViewControllers[from];
    }
    
    // 3.转场动画
    if (oldVc.view.superview) { // 正在显示这个旧控制器
        [oldVc.view removeFromSuperview];
        [self.contentView addSubview:newVc.view];
        
        // 转场动画
        CATransition *transition = [CATransition animation];
        transition.type = @"cube";
        transition.duration = 0.5;
        [self.contentView.layer addAnimation:transition forKey:nil];
    } else { // 没有显示任何控制器
        [self.contentView addSubview:newVc.view];
    }

}

/**
 *  设置Dock
 */
- (void)setupDock
{
    // 设置背景色
    self.view.backgroundColor = SJGlobalBgColor;
    
    // 添加dock
    SJDock *dock = [[SJDock alloc] init];
    dock.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    dock.height = self.view.height;
    [self.view addSubview:dock];
    self.dock = dock;
    self.dock.tabBar.delegate = self;
    self.contentView.x = self.dock.width;

    // 根据当前的屏幕方向设置dock的属性
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0.0];
    
    
    //监听头像点击
    [self.dock.iconButton addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  监听头像点击
 */
- (void)iconClick
{
    // 子控制器的个数
    int count = self.childViewControllers.count;
    
    // 获得当前正在显示的控制器的索引
    int from = 0;
    for (int i = 0; i<count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        
        if (vc.view.superview) { // 如果控制器正在显示
            from = i;
            break;
        }
    }
    
    // 最后一个子控制器的索引
    int index = count - 1;
    
    // 从当前正在显示的控制器切换切换控制器
    [self tabBar:nil didSelectButtonFrom:from to:index];
    
    // 让tabbar里面的所有按钮取消选中
    [self.dock.tabBar unselect];

}

/**
 *  当屏幕旋转时调用
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        [self.dock rotate:UIInterfaceOrientationIsLandscape(toInterfaceOrientation)];
    }];
}
@end
