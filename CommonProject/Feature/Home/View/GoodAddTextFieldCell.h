//
//  GoodAddTextFieldCell.h
//  CommonProject
//
//  Created by WyzcWin on 16/11/1.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodAddTextFieldCell : UITableViewCell

@property (nonatomic, strong) UITextField *titleTF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)updateCellWithItem:(GoodsItem *)item;

@end
