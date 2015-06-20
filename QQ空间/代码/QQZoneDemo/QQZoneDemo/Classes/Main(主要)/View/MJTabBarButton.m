//
//  MJTabBarButton.m
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJTabBarButton.h"

#define MJTabBarButtonImageLanscapeWidthRatio 0.4

@implementation MJTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizedImageWithName:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.width > MJDockPortraitW) {
        CGFloat imageW = self.width * MJTabBarButtonImageLanscapeWidthRatio;
        CGFloat imageH = self.height;
        return CGRectMake(0, 0, imageW, imageH);
    } else {
        return CGRectMake(0, 0, self.width, self.height);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (self.width > MJDockPortraitW) {
        CGFloat titleW = self.width * (1 - MJTabBarButtonImageLanscapeWidthRatio);
        CGFloat titleX = self.width - titleW;
        CGFloat titleH = self.height;
        return CGRectMake(titleX, 0, titleW, titleH);
    } else {
        return CGRectZero;
    }
}
@end
