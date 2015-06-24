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
        [self setupButtonWithIcon:@"tabbar_mood" tag:SJBottomMenuButtonTypeMood];
        [self setupButtonWithIcon:@"tabbar_photo" tag:SJBottomMenuButtonTypePhoto];
        [self setupButtonWithIcon:@"tabbar_blog" tag:SJBottomMenuButtonTypeBlog];
    }
    return self;
}

- (void)setupButtonWithIcon:(NSString *)icon tag:(SJBottomMenuButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizeImageWithName:@"tabbar_separate_selected_bg"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:)    forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(bottomMenu:didClickButton:)]) {
        [self.delegate bottomMenu:self didClickButton:(int)button.tag];
    }
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
