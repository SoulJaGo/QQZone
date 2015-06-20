//
//  SettingViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SettingViewController.h"
#import "CellItem.h"
#import "SettingCell.h"

@interface SettingViewController ()
{
    NSMutableArray *_cellItems;
}
@end

@implementation SettingViewController

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    // 初始化item
    [self addCellItems];
    
    // 覆盖group样式tableView默认的header
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    // 退出当前账号按钮
    UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
    logout.frame = CGRectMake(0, 0, 0, 40);
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizeImage:@"logout_btn_bg.png"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizeImage:@"logout_btn_bg_highlighted.png"] forState:UIControlStateHighlighted];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    logout.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    self.tableView.tableFooterView = logout;
}

- (void)logout
{
    [self dismissViewControllerAnimated:YES completion:^{
        // 发出通知给HomeViewController
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
    }];
}

- (void)addCellItems
{
    CellItem *note = [CellItem itemWithTitle:@"通知设置" cellItemType:CellItemTypeDisclosureIndicator];
    
    CellItem *upload = [CellItem itemWithTitle:@"上传高清图片" cellItemType:CellItemTypeSwitch];
    CellItem *photo = [CellItem itemWithTitle:@"照片水印" cellItemType:CellItemTypeSwitch];
    
    CellItem *power = [CellItem itemWithTitle:@"权限设置" cellItemType:CellItemTypeDisclosureIndicator];
    
    CellItem *skin = [CellItem itemWithTitle:@"皮肤" cellItemType:CellItemTypeDisclosureIndicator];
    skin.cellClickBlock = ^(CellItem *item){
        NSLog(@"点击了皮肤------");
    };
    
    CellItem *voice = [CellItem itemWithTitle:@"提示音" cellItemType:CellItemTypeSwitch];
    
    // 监听Cell的switch改变
    __unsafe_unretained SettingViewController *setting = self;
    voice.switchChangeBlock = ^(CellItem *item) {
        if (![item.title isEqualToString:@"提示音"]) return;
        
        if (item.isOn) {
            [setting->_cellItems addObject:@[
             [CellItem itemWithTitle:@"新增的" cellItemType:CellItemTypeDetailDisclosureButton]
             ]];
        } else {
            [setting->_cellItems removeLastObject];
        }
        
        [setting.tableView reloadData];
    };
    
    CellItem *suggest = [CellItem itemWithTitle:@"意见反馈" cellItemType:CellItemTypeDisclosureIndicator];
    suggest.className = @"SuggestViewController";
    
    CellItem *about = [CellItem itemWithTitle:@"关于" cellItemType:CellItemTypeDisclosureIndicator];
    about.className = @"AboutViewController";
    
    NSArray *array = @[
                    @[note],
                    @[upload, photo],
                    @[power],
                    @[skin],
                    @[voice],
                    @[suggest, about]
                   ];
    _cellItems = [NSMutableArray arrayWithArray:array];
}

#pragma mark close
- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cellItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _cellItems[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.cellItem = _cellItems[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellItem *item = _cellItems[indexPath.section][indexPath.row];
    if (item.cellClickBlock) {
        item.cellClickBlock(item);
    } else if (item.className) { // 想跳到下一个界面
        Class c = NSClassFromString(item.className);
        UIViewController *vc = [[c alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end