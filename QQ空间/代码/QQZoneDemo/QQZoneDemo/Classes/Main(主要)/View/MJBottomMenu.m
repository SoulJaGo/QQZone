//
//  MJBottomMenu.m
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJBottomMenu.h"

@implementation MJBottomMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化3个按钮
        [self setupButtonWithIcon:@"tabbar_mood"];
        [self setupButtonWithIcon:@"tabbar_photo"];
        [self setupButtonWithIcon:@"tabbar_blog"];
    }
    return self;
}

- (void)setupButtonWithIcon:(NSString *)icon
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImageWithName:@"tabbar_separate_selected_bg"] forState:UIControlStateHighlighted];
    button.size = CGSizeMake(MJDockPortraitW, MJDockPortraitW);
    [self addSubview:button];
}

/**
 *  旋转
 */
- (void)rotate:(BOOL)lanscape
{
    // 设置内部按钮
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.x = lanscape ? (i * button.width) : 0;
        button.y = lanscape ? 0 : (i * button.height);
    }
    
    // 设置底部菜单
    self.height = lanscape ? MJDockPortraitW : (MJDockPortraitW * 3);
    self.width = self.superview.width;
    self.y = self.superview.height - self.height;
}

@end
