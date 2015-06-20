//
//  SettingCell.m
//  QQ空间-HD
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SettingCell.h"
#import "CellItem.h"

@interface SettingCell()
{
    UISwitch *_switch;
    UIButton *_btn;
}
@end

@implementation SettingCell

- (void)setFrame:(CGRect)frame
{
    CGFloat margin = 15;
    frame.origin.x = -margin;
    frame.size.width += 2 * margin;
    
    [super setFrame:frame];
}

- (void)setCellItem:(CellItem *)cellItem
{
    _cellItem = cellItem;
    
    self.textLabel.text = cellItem.title;
    
    if (cellItem.cellItemType == CellItemTypeSwitch) {
        if (_switch == nil) {
            _switch = [[UISwitch alloc] init];
            [_switch addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
        }
        _switch.on = _cellItem.isOn;
        self.accessoryView = _switch;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if(cellItem.cellItemType == CellItemTypeButton) {
        if (_btn == nil) {
            _btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        }
        self.accessoryView = _btn;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        self.accessoryView = nil;
        self.accessoryType = cellItem.cellItemType;
        
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
}

- (void)switchChange
{
    // 更改模型的状态
    _cellItem.on = _switch.isOn;
    
    // NSLog(@"%@---%d", _cellItem.title, _switch.isOn);
}
@end