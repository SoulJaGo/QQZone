//
//  SJSegmentControl.m
//  QQZone
//
//  Created by SoulJa on 15/6/24.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import "SJSegmentControl.h"
#import "SJSegment.h"
@interface SJSegmentControl ()
@property (nonatomic,weak) SJSegment *selectedButton;
@end
@implementation SJSegmentControl
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    //1.移除之前创建的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int count = (int)items.count;
    for (int i = 0; i < count; i++) {
        SJSegment *button = [[SJSegment alloc] init];
        button.tag = i;
        //设置文字
        [button setTitle:items[i] forState:UIControlStateNormal];
        //设置背景
        NSString *bgName = nil;
        NSString *selectedBgName = nil;
        if (i == 0) { // 最左边
            bgName = @"SegmentedControl_Left_Normal";
            selectedBgName = @"SegmentedControl_Left_Selected";
        } else if (i == count - 1) { // 最右边
            bgName = @"SegmentedControl_Right_Normal";
            selectedBgName = @"SegmentedControl_Right_Selected";
        } else {
            bgName = @"SegmentedControl_Normal";
            selectedBgName = @"SegmentedControl_Selected";
        }
        [button setBackgroundImage:[UIImage resizeImageWithName:bgName] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizeImageWithName:selectedBgName] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buttonClick:(SJSegment *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    
    
    for (int i = 0; i < count; i++) {
        SJSegment *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.y = 0;
        button.x = buttonW * i;
    }
}

- (void)setSelectedIndex:(int)selectedIndex
{
    int count = (int)self.items.count;
    if (selectedIndex < 0 || selectedIndex >= count) return;
    
    //取出对应位置的按钮
    SJSegment *segment = self.subviews[selectedIndex];
    
    //点击
    [self buttonClick:segment];
}

- (int)selectedIndex
{
    return (int)self.selectedButton.tag;
}

@end
