//
//  SJDock.h
//  QQZone
//
//  Created by SoulJa on 15/6/20.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJTabBar.h"
#import "SJIconButton.h"
#import "SJBottomMenu.h"

@interface SJDock : UIView
@property (nonatomic,weak,readonly) SJTabBar *tabBar;
@property (nonatomic,weak,readonly) SJIconButton *iconButton;
@property (nonatomic,weak,readonly) SJBottomMenu *bottomMenu;
- (void)rotate:(BOOL)landscape;
@end
