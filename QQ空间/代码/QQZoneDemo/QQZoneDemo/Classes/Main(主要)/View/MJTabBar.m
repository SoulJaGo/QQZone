//
//  MJTabBar.m
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJTabBar.h"
#import "MJTabBarButton.h"

@interface MJTabBar()
@property (weak, nonatomic) MJTabBarButton *selectedButton;
@end

@implementation MJTabBar

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
    MJTabBarButton *button = [[MJTabBarButton alloc] init];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImageWithName:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

- (void)buttonClick:(MJTabBarButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

/**
 *  旋转
 */
- (void)rotate:(BOOL)lanscape
{
    // 1.设置tabbar的尺寸
    self.height = MJDockPortraitW * 6;
    self.width = self.superview.width;
    
    // 2.所有子控件的frame
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        MJTabBarButton *button = self.subviews[i];
        button.x = 0;
        button.width = self.width;
        button.height = MJDockPortraitW;
        button.y = i * button.height;
    }
}
@end
