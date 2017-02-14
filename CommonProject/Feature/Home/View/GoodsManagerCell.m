//
//  GoodsManagerCell.m
//  CommonProject
//
//  Created by WyzcWin on 16/11/1.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "GoodsManagerCell.h"

@interface GoodsManagerCell()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *coverImg;

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation GoodsManagerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *const GoodsManagerCellID = @"GoodsManagerCellID";
    
    GoodsManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsManagerCellID];
    if (!cell) {
        cell = [[GoodsManagerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoodsManagerCellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        [self.contentView addSubview:self.bgView];
    }
    
    return self;
}

- (void)updateCellWithItem:(GoodsItem *)item{
    
    self.titleLable.text = item.title;
    self.timeLabel.text = item.time;
    self.statusLabel.text = [NSString stringWithFormat:@"状态:%@", item.position];
}

#pragma mark - UI 懒加载初始化
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70.0f)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        [_bgView addSubview:self.coverImg];
        [_bgView addSubview:self.titleLable];
        [_bgView addSubview:self.statusLabel];
        [_bgView addSubview:self.timeLabel];
    }
    
    return _bgView;
}

- (UIImageView *)coverImg{
    if (_coverImg == nil) {
        CGFloat padding = 10.0f;
        _coverImg = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, 50.0f, 50.0f)];
        _coverImg.layer.cornerRadius = 25.0f;
        _coverImg.layer.masksToBounds = YES;
        _coverImg.image = [UIImage imageNamed:@""];
        _coverImg.backgroundColor = kThemeColor;
    }
    return _coverImg;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        CGFloat padding = 10.0f;
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_coverImg.right + padding, _coverImg.top, _bgView.width - _coverImg.right - 2 * padding, 20.0f)];
        _titleLable.font = [UIFont systemFontOfSize:18.0f];
        _titleLable.textColor = MainTitleColor;
    }
    return _titleLable;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLable.left, 40.0f, _titleLable.width / 2, 20.0f)];
        _statusLabel.font = [UIFont systemFontOfSize:12.0f];
        _statusLabel.textColor = MainSubTitleColor;
    }
    return _statusLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.right - 150.0f, _statusLabel.top, 120, 20.0f)];
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.textColor = MainSubTitleColor;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
