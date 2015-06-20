//
//  MJDock.h
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJDock;

@protocol MJDockDelegate <NSObject>
@optional

@end

@interface MJDock : UIView
@property (weak, nonatomic) id<MJDockDelegate> delegate;

/**
 *  旋转
 *
 *  @param lanscape 是否为横屏
 */
- (void)rotate:(BOOL)lanscape;
@end
