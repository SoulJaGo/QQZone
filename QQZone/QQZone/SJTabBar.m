//
//  SJTabBar.m
//  QQZone
//
//  Created by SoulJa on 15/6/23.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJTabBar.h"
#import "SJTabBarButton.h"

@interface SJTabBar()
@property (weak, nonatomic) SJTabBarButton *selectedButton;
@end

@implementation SJTabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化6个按钮
        [self setupButtonWithIcon:@"tab_bar_feed_icon" title:@"全部动态"];
        [self setupButtonWithIcon:@"tab_bar_passive_feed_icon" title:@"与我相关"];
        [self setupButtonWithIcon:@"tab_bar_pic_wall_icon" title:@"照片墙"];
        [self setupButtonWithIcon:@"tab_bar_e_album_icon" title:@"电子相框"];
        [self setupButtonWithIcon:@"tab_bar_friend_icon" title:@"好友"];
        [self setupButtonWithIcon:@"tab_bar_e_more_icon" title:@"更多"];
    }
    return self;
}

- (void)setupButtonWithIcon:(NSString *)icon title:(NSString *)title
{
    SJTabBarButton *button = [[SJTabBarButton alloc] init];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizeImageWithName:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(SJTabBarButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)rotate:(BOOL)landscape
{
    int count = (int)self.subviews.count;
    
    self.width = self.superview.width;
    self.height = SJBottomMenuButtonH * count;
    
    for (int i = 0; i<count; i++) {
        SJTabBarButton *button = self.subviews[i];
        button.width = self.width;
        button.height = SJBottomMenuButtonH;
        button.x = 0;
        button.y = i * button.height;
    }
}
@end
