//
//  SJBottomMenu.m
//  QQZone
//
//  Created by SoulJa on 15/6/23.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJBottomMenu.h"

@implementation SJBottomMenu
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
    [button setBackgroundImage:[UIImage resizeImageWithName:@"tabbar_separate_selected_bg"] forState:UIControlStateHighlighted];
    [self addSubview:button];
}


- (void)rotate:(BOOL)landscape
{
    int count = (int)self.subviews.count;
    if (landscape) { // 横屏
        self.width = SJBottomMenuButtonLandscapeW * 3;
        self.height = SJBottomMenuButtonH;
        
        for (int i = 0; i<count; i++) {
            UIButton *button = self.subviews[i];
            button.x = i * SJBottomMenuButtonLandscapeW;
            button.y = 0;
            button.width = SJBottomMenuButtonLandscapeW;
            button.height = SJBottomMenuButtonH;
        }

    } else {    //  竖屏
        self.width = SJBottomMenuButtonPortraitW;
        self.height = SJBottomMenuButtonH * 3;
        
        for (int i = 0; i<count; i++) {
            UIButton *button = self.subviews[i];
            button.x = 0;
            button.y = i * SJBottomMenuButtonH;
            button.width = SJBottomMenuButtonPortraitW;
            button.height = SJBottomMenuButtonH;
        }
    }
    self.y = self.superview.height - self.height;
}

@end
