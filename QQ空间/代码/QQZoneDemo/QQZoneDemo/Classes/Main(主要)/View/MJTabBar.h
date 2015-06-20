//
//  MJTabBar.h
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJTabBar;

@protocol MJTabBarDelegate <NSObject>
@optional

@end

@interface MJTabBar : UIView
@property (weak, nonatomic) id<MJTabBarDelegate> delegate;

/**
 *  旋转
 *
 *  @param lanscape 是否为横屏
 */
- (void)rotate:(BOOL)lanscape;
@end
