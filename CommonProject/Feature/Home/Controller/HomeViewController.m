//
//  HomeViewController.m
//  BaseProject
//
//  Created by WyzcWin on 16/10/26.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "HomeViewController.h"
#import "GoodViewController.h"
#import "GoodsManagerCell.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *_dataSource;
}

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;   // 列表

@end

@implementation HomeViewController

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refreshData)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"KRefreshHomeDataNotifi" object:nil];
}

- (void)refreshData{
    
    _dataSource = [NSMutableArray arrayWithArray:[[BPDBManager sharedInstance] queryGoodItems]];
    
    [self createTableview];
}

- (void)createTableview{
    
    if (_tableView && [self.view.subviews containsObject:_tableView]) {
        [_tableView removeFromSuperview];
        _tableView = nil;
    }
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TABBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = CellLine_Color;
        _tableView.backgroundColor = CommonBackgroundColor;
        [self.view addSubview:_tableView];
    }
}

- (UIView *)createFooterView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70.0f)];
    
    footerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat padding = 10.0f;
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(2 * padding, padding, SCREEN_WIDTH - 4 * padding, 50.0f)];
    startBtn.backgroundColor = kThemeColor;
    startBtn.layer.cornerRadius = 5.0f;
    startBtn.layer.masksToBounds = YES;
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [startBtn addTarget:self action:@selector(startToRecord:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5f)];
    lineView.backgroundColor = CellLine_Color;
    
    [footerView addSubview:lineView];
    [footerView addSubview:startBtn];
    
    return footerView;
}

- (void)startToRecord:(UIButton *)sender{
    
    GoodViewController *addNewGoodVC = [[GoodViewController alloc] init];
    [self.navigationController pushViewController:addNewGoodVC animated:YES];
}

#pragma mark - UITableViewDelegate / UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 70.0f;
    }
    
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsManagerCell *cell = [GoodsManagerCell cellWithTableView:tableView];
    
    GoodsItem *item = [_dataSource objectAtIndex:indexPath.row];
    
    [cell updateCellWithItem:item];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return [self createFooterView];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsItem *item = [_dataSource objectAtIndex:indexPath.row];
    
    GoodViewController *goodVC = [[GoodViewController alloc] init];
    goodVC.goodViewType = GoodViewTypeLook;
    goodVC.goodItem = item;
    [self.navigationController pushViewController:goodVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
