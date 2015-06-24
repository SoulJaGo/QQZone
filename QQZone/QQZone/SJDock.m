//
//  SJDock.m
//  QQZone
//
//  Created by SoulJa on 15/6/20.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJDock.h"
#import "SJIconButton.h"
#import "SJTabBar.h"
#import "SJBottomMenu.h"

@interface SJDock ()

@end
@implementation SJDock
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //1.头像
        [self setupIconButton];
        
        //2.选项卡
        [self setupTabBar];
        
        //3.底部菜单
        [self setupBottomMenu];
    }
    return self;
}

/**
 *  头像
 */
- (void)setupIconButton
{
    SJIconButton *iconButton = [[SJIconButton alloc] init];
    [self addSubview:iconButton];
    _iconButton = iconButton;
}

/**
 *  选项卡
 */
- (void)setupTabBar
{
    SJTabBar *tabBar = [[SJTabBar alloc] init];
    [self addSubview:tabBar];
    _tabBar = tabBar;
}

/**
 *  底部菜单
 */
- (void)setupBottomMenu
{
    SJBottomMenu *bottomMenu = [[SJBottomMenu alloc] init];
    bottomMenu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:bottomMenu];
    _bottomMenu = bottomMenu;
}

/**
 *  旋转判断是否为横屏
 */
- (void)rotate:(BOOL)landscape
{
    //2.调整底部菜单
    [self.bottomMenu rotate:landscape];
    
    //2.设置dock自己的属性
    self.height = self.superview.height;
    self.width = self.bottomMenu.width;
    
    //3.调整头像
    [self.iconButton rotate:landscape];
 
    //4.调整tabBar
    [self.tabBar rotate:landscape];
    self.tabBar.y = self.bottomMenu.y - self.tabBar.height;
    self.tabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}
@end
