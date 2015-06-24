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
#import "SJNavigationController.h"
#import "SJComposeViewController.h"
#define SJRandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]
#define SJContentViewW 600
@interface SJMainViewController () <SJTabBarDelegate,SJBottomMenuDelegate>
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
    //1.创建
    UIView *contentView = [[UIView alloc] init];
    contentView.width = SJContentViewW;
    contentView.height = self.view.height;
    contentView.x = self.dock.width;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    //2.pan
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self    action:@selector(dragContentView:)];
    [self.contentView addGestureRecognizer:recognizer];
}

- (void)dragContentView:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:0.25 animations:^{
            pan.view.transform = CGAffineTransformIdentity;
        }];
    }
    
    CGPoint translation = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformMakeTranslation(translation.x * 0.2, 0);
}

/**
 *  初始化子控制器
 */
- (void)setupChildViewControllers
{
    SJAllStatusViewController *allStatus = [[SJAllStatusViewController alloc] init];
    [self setupOneChildViewController:allStatus];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    [self setupOneChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    [self setupOneChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    [self setupOneChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    [self setupOneChildViewController:vc4];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    [self setupOneChildViewController:vc5];
    
    // 点击头像显示的主页控制器
    UIViewController *home = [[UIViewController alloc] init];
    [self setupOneChildViewController:home];

}

- (void)setupOneChildViewController:(UIViewController *)vc
{
    SJNavigationController *nav = [[SJNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - SJTabBarDelegate
- (void)tabBar:(SJTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    // 1.新控制器
    UIViewController *newVc = self.childViewControllers[to];
    if (newVc.view.superview) return;
    newVc.view.frame = self.contentView.bounds;
    
    //取出导航控制器的根控制器
    UIViewController *rootVc = [newVc.childViewControllers firstObject];
    rootVc.view.backgroundColor = SJColor(212, 212, 212);
    
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
    
    //设置buttonMenu的代理
    self.dock.bottomMenu.delegate = self;
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

#pragma mark - SJBottomMenuDelegate
- (void)bottomMenu:(SJBottomMenu *)bottomMenu didClickButton:(SJBottomMenuButtonType)button
{
    switch (button) {
        case SJBottomMenuButtonTypeBlog:
        case SJBottomMenuButtonTypePhoto:
        case SJBottomMenuButtonTypeMood:
        {
            SJComposeViewController *compose = [[SJComposeViewController alloc] init];
            SJNavigationController *nav = [[SJNavigationController alloc] initWithRootViewController:compose];
            [self presentViewController:nav animated:YES completion:nil];
            self.modalPresentationStyle = UIModalPresentationFormSheet;
        }
            break;
            
        default:
            break;
    }
}
@end
