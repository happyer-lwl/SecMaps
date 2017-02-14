//
//  MeCenterViewController.m
//  CommonProject
//
//  Created by WyzcWin on 16/10/26.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "MeCenterViewController.h"
#import "SettingViewController.h"

@interface MeCenterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(pushToSettingVC)];
}

#pragma mark - CustomMethods
- (void)pushToSettingVC{
    
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - UI 懒加载

- (UITableView *)tableView{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCreenWidth, SCreenHegiht  - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *const cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
