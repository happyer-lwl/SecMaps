//
//  GoodViewController.m
//  CommonProject
//
//  Created by WyzcWin on 16/11/1.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "GoodViewController.h"
#import "GoodAddTextFieldCell.h"
#import "VPImageCropperViewController.h"

typedef NS_ENUM(NSUInteger, PhotoSourceType){
    PhotoSourceTypeTakePhoto,   // 拍照
    PhotoSourceTypeLocalPhoto,  // 相册
};

@interface GoodViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, VPImageCropperDelegate>{
    
    NSArray *_titleArr;
}

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImagePickerController *pickerController;
@end

@implementation GoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = (_goodViewType == GoodViewTypeAdd) ? @"添加宝贝" : _goodItem.title;
    _titleArr = @[@"名称", @"地址", @"价格"];
    
    [self createTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveGoodInfo:)];
}

- (void)saveGoodInfo:(UIBarButtonItem *)sender{
    
    GoodsItem *newGoodItem = [GoodsItem new];
    
    for (int i = 0; i < _titleArr.count; i++) {
        
        GoodAddTextFieldCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (i == 0) {
            newGoodItem.title = cell.titleTF.text;
        }else if (i == 1) {
            newGoodItem.position = cell.titleTF.text;
        }else if (i == 2) {
            newGoodItem.price = cell.titleTF.text;
        }
    }
    
    newGoodItem.status = @"";
    newGoodItem.goodId = @"";
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    newGoodItem.time = [df stringFromDate:[NSDate date]];
    
    newGoodItem.goodCover = [NSString stringWithFormat:@"%@%.0lf", newGoodItem.title, [[NSDate date] timeIntervalSince1970]];
    
    if (_goodViewType == GoodViewTypeAdd) {
        [[BPDBManager sharedInstance] insertGoodItem:newGoodItem];
    }else{
        newGoodItem.goodId = _goodItem.goodId;
        [[BPDBManager sharedInstance] updateGoodItem:newGoodItem];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KRefreshHomeDataNotifi" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)createHeaderView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120.0f)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat padding = 5.0f;
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(50.0f, padding, SCREEN_WIDTH - 100.0f, 110.0f)];
    _headerView.backgroundColor = kThemeColor;
    _headerView.layer.cornerRadius = 5.0f;
    _headerView.layer.masksToBounds = YES;
    _headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headerView.layer.borderWidth = 1.0f;
    _headerView.userInteractionEnabled = YES;
    _headerView.contentMode = UIViewContentModeScaleToFill;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePicker:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [_headerView addGestureRecognizer:tapGesture];
    
    // 分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119.5f, SCREEN_WIDTH, 0.5f)];
    lineView.backgroundColor = CellLine_Color;
    
    [headerView addSubview:_headerView];
    [headerView addSubview:lineView];
    
    return headerView;
}

- (void)imagePicker:(UIButton *)sender{
    
    NSString *titleStr = (_goodViewType == GoodViewTypeAdd) ? @"给宝贝拍个照" : @"换一个吧";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleStr message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    WeakSelf
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍 照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf getPhotoWithType:PhotoSourceTypeTakePhoto];
    }];
    [alertController addAction:takePhotoAction];
    
    UIAlertAction *localPhotoAction = [UIAlertAction actionWithTitle:@"相 册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf getPhotoWithType:PhotoSourceTypeLocalPhoto];
    }];
    [alertController addAction:localPhotoAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取 消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)getPhotoWithType:(PhotoSourceType)sourceType{
    
    if (sourceType == PhotoSourceTypeTakePhoto) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.delegate = self;
        _pickerController.allowsEditing = YES;
        _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_pickerController animated:YES completion:nil];
    }else{
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.delegate = self;
        _pickerController.allowsEditing = YES;
        _pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:_pickerController animated:YES completion:nil];
    }
}

- (void)createTableView{
    if (_tableView && [self.view.subviews containsObject:_tableView]) {
        [_tableView removeFromSuperview];
        _tableView = nil;
    }
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCreenWidth, SCreenHegiht  - TABBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = CellLine_Color;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodAddTextFieldCell *cell = [GoodAddTextFieldCell cellWithTableView:tableView];
    
    if (indexPath.row == 0) {
        if (_goodViewType == GoodViewTypeAdd) {
            cell.titleTF.placeholder = @"啥名儿";
        }else {
            cell.titleTF.text = _goodItem.title;
        }
    }else if (indexPath.row == 1) {
        if (_goodViewType == GoodViewTypeAdd) {
            cell.titleTF.placeholder = @"放哪儿";
        }else {
            cell.titleTF.text = _goodItem.position;
        }
    }else if (indexPath.row == 2) {
        if (_goodViewType == GoodViewTypeAdd) {
            cell.titleTF.placeholder = @"多少钱";
        }else {
            cell.titleTF.text = _goodItem.price;
        }
    }
    
    cell.textLabel.text = [_titleArr objectAtIndex:indexPath.row];
        
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self createHeaderView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    WeakSelf
    [_pickerController dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        VPImageCropperViewController *vpImageVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(50, 200, SCREEN_WIDTH - 100, 110.0f) limitScaleRatio:1.0f];
        vpImageVC.delegate = self;
        [weakSelf presentViewController:vpImageVC animated:YES completion:nil];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){

    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

#pragma mark - VPImageCroperDelegate
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
    
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    
    WeakSelf
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        weakSelf.headerView.image = editedImage;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
