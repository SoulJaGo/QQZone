//
//  MJDock.m
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJDock.h"
#import "MJTabBar.h"
#import "MJBottomMenu.h"
#import "MJIconView.h"

@interface MJDock()
@property (weak, nonatomic) MJIconView *iconView;
@property (weak, nonatomic) MJTabBar *tabBar;
@property (weak, nonatomic) MJBottomMenu *bottomMenu;
@end

@implementation MJDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.头像
        [self setupIcon];
        
        // 2.选项卡
        [self setupTabBar];
        
        // 3.底部菜单
        [self setupBottomMenu];
    }
    return self;
}

/**
 *  头像
 */
- (void)setupIcon
{
    MJIconView *iconView = [[MJIconView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
}

/**
 *  头像
 */
- (void)setupTabBar
{
    MJTabBar *tabBar = [[MJTabBar alloc] init];
//    tabBar.backgroundColor = [UIColor blueColor];
    tabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:tabBar];
    self.tabBar = tabBar;
}

/**
 *  头像
 */
- (void)setupBottomMenu
{
    MJBottomMenu *bottomMenu = [[MJBottomMenu alloc] init];
//    bottomMenu.backgroundColor = [UIColor greenColor];
    bottomMenu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:bottomMenu];
    self.bottomMenu = bottomMenu;
}

/**
 *  旋转
 */
- (void)rotate:(BOOL)lanscape
{
    // 1.调整Dock
    self.width = lanscape ? MJDockLanscapeW : MJDockPortraitW;
    
    // 2.底部菜单
    [self.bottomMenu rotate:lanscape];
    
    // 3.tabbar
    [self.tabBar rotate:lanscape];
    self.tabBar.y = self.bottomMenu.y - self.tabBar.height;
    
    // 4.头像
    [self.iconView rotate:lanscape];
}

@end
