//
//  SJBottomMenu.h
//  QQZone
//
//  Created by SoulJa on 15/6/23.
//  Copyright (c) 2015年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJBottomMenu;

typedef enum {
    SJBottomMenuButtonTypeMood,//心情
    SJBottomMenuButtonTypePhoto,//照片
    SJBottomMenuButtonTypeBlog//日志
}SJBottomMenuButtonType;

@protocol SJBottomMenuDelegate <NSObject>
@optional
- (void)bottomMenu:(SJBottomMenu *)bottomMenu didClickButton:(SJBottomMenuButtonType)button;
@end
@interface SJBottomMenu : UIView
@property (nonatomic,weak) id<SJBottomMenuDelegate> delegate;
- (void)rotate:(BOOL)landscape;
@end
