//
//  SJSegmentControl.h
//  QQZone
//
//  Created by SoulJa on 15/6/24.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJSegmentControl : UIView
@property (nonatomic,strong) NSArray *items;
/**
 *  一个segment的宽度
 */
@property (nonatomic,assign) CGFloat segmentWidth;
@property (nonatomic,assign) int selectedIndex;
@end
