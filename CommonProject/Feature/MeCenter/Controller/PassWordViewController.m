//
//  PassWordViewController.m
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "PassWordViewController.h"
#import "PassWordInputViewController.h"

#import "PWSwitchTableViewCell.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "ConfirmAlertView.h"


@interface PassWordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"密码设置";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_tableView && [self.view.subviews containsObject:_tableView]) {
        [_tableView removeFromSuperview];
        _tableView = nil;
    }
    [self.view addSubview:self.tableView];
}

- (UIView *)createHeaderView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0f)];
    
    UIButton *openPW = [[UIButton alloc] initWithFrame:CGRectMake(20.0f, 10.0, SCREEN_WIDTH - 40.0f, 44.0f)];
    openPW.backgroundColor = kThemeColor;
    [openPW setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openPW setTitleColor:UIColorRGB(240, 240, 240) forState:UIControlStateHighlighted];
    openPW.layer.cornerRadius = 5.0f;
    openPW.layer.masksToBounds = YES;
    [openPW setTitle:@"开启保护" forState:UIControlStateNormal];
    [openPW addTarget:self action:@selector(openPW:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:openPW];
    
    return headerView;
}

- (void)openPW:(UIButton *)sender{
    
    PassWordInputViewController *inputVC = [[PassWordInputViewController alloc] init];
    inputVC.pwViewType = PWViewTypeNew;
    [self.navigationController pushViewController:inputVC animated:YES];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCreenWidth, SCreenHegiht  - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = CellLine_Color;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
        if (STRISEMPTY(password)) {
            _tableView.tableHeaderView = [self createHeaderView];
        }
    }
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
    if (STRISEMPTY(password)) {
        return 0;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    if (indexPath.row == 1) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MAIL"];
        cell.textLabel.text = @"密码保护邮箱";
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row == 2){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CHANGE"];
        cell.textLabel.text = @"更改密码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        
        WeakSelf
        PWSwitchTableViewCell *switchCell = [PWSwitchTableViewCell cellWithTableView:tableView];
        if (indexPath.row == 0) {
            NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
            [switchCell updateDateCellWithTitle:@"密码保护" bOpen:!STRISEMPTY(pw)];
            switchCell.switchBlock = ^(BOOL on){
                if (on) {
                    
                }else{
                    
                    PassWordInputViewController *inputVC = [[PassWordInputViewController alloc] init];
                    inputVC.pwViewType = PWViewTypeCancel;
                    [weakSelf.navigationController pushViewController:inputVC animated:YES];
                }
            };
        }else if (indexPath.row == 3){
            NSNumber *touchIdOpen = [[NSUserDefaults standardUserDefaults] objectForKey:@"TouchID"];
            [switchCell updateDateCellWithTitle:@"Touch ID" bOpen:touchIdOpen.boolValue];
            switchCell.switchBlock = ^(BOOL on) {
                if (on) {
                    
                    LAContext *context = [[LAContext alloc] init];
                    NSError *err = nil;
                    
                    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err]) {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"TouchID"];
                        [ConfirmAlertView showAlertWithMessage:@"您已开启Touch ID验证，将在下次启动软件时验证!"];
                    }
                }else{
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"TouchID"];
                }
            };
        }else{
            [switchCell updateDateCellWithTitle:@"快速记录" bOpen:NO];
        }
        cell = switchCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
