//
//  PWSwitchTableViewCell.h
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwitchChangedBlock)(BOOL on);

@interface PWSwitchTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)updateDateCellWithTitle:(NSString *)title bOpen:(BOOL)bOpen;

@property (nonatomic, copy) SwitchChangedBlock switchBlock;

@end
