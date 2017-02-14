//
//  GoodsManagerCell.h
//  CommonProject
//
//  Created by WyzcWin on 16/11/1.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsManagerCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)updateCellWithItem:(GoodsItem *)item;

@end
