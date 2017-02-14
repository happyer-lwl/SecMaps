//
//  GoodAddTextFieldCell.m
//  CommonProject
//
//  Created by WyzcWin on 16/11/1.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "GoodAddTextFieldCell.h"

@interface GoodAddTextFieldCell()

@property (nonatomic, strong) UIView      *bgView;

@end

@implementation GoodAddTextFieldCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *const GoodAddTextFieldCellID = @"";
    GoodAddTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodAddTextFieldCellID];
    if (!cell) {
        cell = [[GoodAddTextFieldCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GoodAddTextFieldCellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.bgView];
    }
    return self;
}

- (void)updateCellWithItem:(GoodsItem *)item{
    
    
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        [_bgView addSubview:self.titleTF];
    }
    return _bgView;
}

- (UITextField *)titleTF{
    if (_titleTF == nil) {
        
        _titleTF = [[UITextField alloc] initWithFrame:CGRectMake(_bgView.left + 100.0f, 0, SCreenWidth - 120.0f, 50.0f)];
        _titleTF.textAlignment = NSTextAlignmentRight;
        _titleTF.font = [UIFont systemFontOfSize:14.0f];
        _titleTF.tintColor = UIColorFromRGB(0xcccccc);
    }
    return _titleTF;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
