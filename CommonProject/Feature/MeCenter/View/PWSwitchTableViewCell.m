//
//  PWSwitchTableViewCell.m
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "PWSwitchTableViewCell.h"

@interface PWSwitchTableViewCell()

@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation PWSwitchTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *const PASSWORD_SWITCH_CELL = @"PASSWORD_SWITCH_CELL";
    
    PWSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PASSWORD_SWITCH_CELL];
    if (cell == nil) {
        cell = [[PWSwitchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PASSWORD_SWITCH_CELL];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.switchView];
    }
    
    return self;
}

- (void)updateDateCellWithTitle:(NSString *)title bOpen:(BOOL)bOpen{
    
    self.textLabel.text = title;
    _switchView.on = bOpen;
}

- (UISwitch *)switchView{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60.0f, 5.0f, 50.0f, 30.0f)];
        _switchView.tintColor = CellLine_Color;
        _switchView.backgroundColor = [UIColor whiteColor];
        _switchView.onTintColor = kThemeColor;
        [_switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)switchChanged:(UISwitch *)sw{
    
    if (_switchBlock) {
        _switchBlock(sw.on);
    }
}

@end
