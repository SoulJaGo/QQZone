//
//  SJTabBar.h
//  QQZone
//
//  Created by SoulJa on 15/6/23.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJTabBar;
@protocol SJTabBarDelegate <NSObject>

@optional
- (void)tabBar:(SJTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;

@end
@interface SJTabBar : UIView
- (void)rotate:(BOOL)landscape;
- (void)unselect;
@property (nonatomic,weak) id<SJTabBarDelegate> delegate;
@end
