//
//  SettingViewController.m
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "SettingViewController.h"
#import "PassWordViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_tableView) {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
        if (STRISEMPTY(pw)) {
            cell.detailTextLabel.text = @"关闭";
        }else{
            cell.detailTextLabel.text = @"开启";
        }
    }
}

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
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10.0f)];
    headerView.backgroundColor = CommonBackgroundColor;
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *const SettingCellID = @"SettingCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingCellID];
    }
    
    cell.textLabel.text = @"密码保护";
    cell.textLabel.textColor = MainTitleColor;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
    if (STRISEMPTY(pw)) {
        cell.detailTextLabel.text = @"关闭";
    }else{
        cell.detailTextLabel.text = @"开启";
    }
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PassWordViewController *pwVC = [[PassWordViewController alloc] init];
    [self.navigationController pushViewController:pwVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
