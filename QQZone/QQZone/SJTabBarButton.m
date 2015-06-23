//
//  SJTabBarButton.m
//  QQZone
//
//  Created by apple on 14-5-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "SJTabBarButton.h"

#define SJTabBarButtonImageLanscpaeWRatio 0.4

@implementation SJTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

/**
 *  图片的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.width > SJBottomMenuButtonLandscapeW) {// 横屏
        CGFloat imageW = self.width * SJTabBarButtonImageLanscpaeWRatio;
        CGFloat imageH = self.height;
        return CGRectMake(0, 0, imageW, imageH);
    } else { // 竖屏
        return self.bounds;
    }
}


/**
 *  文字的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (self.width > SJBottomMenuButtonLandscapeW) {// 横屏
        CGFloat titleX = self.width * SJTabBarButtonImageLanscpaeWRatio;
        CGFloat titleW = self.width - titleX;
        CGFloat titleH = self.height;
        return CGRectMake(titleX, 0, titleW, titleH);
    } else { // 竖屏
        return CGRectZero;
    }
}

@end
