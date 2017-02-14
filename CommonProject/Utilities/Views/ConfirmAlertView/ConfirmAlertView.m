//
//  ConfirmAlertView.m
//  wyzc
//
//  Created by Liuwl on 16/4/18.
//  Copyright © 2016年 北京我赢科技有限公司. All rights reserved.
//

#import "ConfirmAlertView.h"
#import "AppDelegate.h"

#define kAlertViewWidth     SCreenWidth - 60.0
#define kAlertViewHeight    150.0
#define kConfirmHeight      50.0

@interface ConfirmAlertView()

@property (nonatomic, weak) UIView   *alertView;    // 白色背景图
@property (nonatomic, weak) UILabel  *msgTitle;     // 消息内容
@property (nonatomic, weak) UIView   *lineView;     // 分割线
@property (nonatomic, weak) UIButton *confirmBtn;   // 确定按键

@end

@implementation ConfirmAlertView

- (instancetype)init{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, SCreenWidth, SCreenHegiht)]) {
        
        [self initSubElements];
    }
    
    return self;
}

- (void)initSubElements{
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    
    if (_alertView == nil) {
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(30, (SCreenHegiht - kAlertViewHeight) * 0.5, kAlertViewWidth, kAlertViewHeight)];
        alertView.backgroundColor = [UIColor whiteColor];
        [self addSubview:alertView];
        _alertView = alertView;
    }
    
    // View圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_alertView.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft |
                                                                      UIRectCornerTopRight |
                                                                      UIRectCornerBottomLeft |
                                                                      UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _alertView.bounds;
    maskLayer.path = maskPath.CGPath;
    _alertView.layer.mask = maskLayer;
    
    if (_msgTitle == nil) {
        UILabel *msgTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, _alertView.width - 40.0, kAlertViewHeight - kConfirmHeight)];
        msgTitle.font = [UIFont systemFontOfSize:16.0f];
        msgTitle.textColor = MainSectionTitleColor;
        msgTitle.textAlignment = NSTextAlignmentCenter;
        msgTitle.numberOfLines = 0;
        [_alertView addSubview:msgTitle];
        _msgTitle = msgTitle;
    }
    
    if (_lineView == nil) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_msgTitle.frame), kAlertViewWidth, 0.5)];
        lineView.backgroundColor = MainSectionTitleColor;
        [_alertView addSubview:lineView];
        _lineView = lineView;
    }
    
    if (_confirmBtn == nil) {
        UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_lineView.frame), kAlertViewWidth - 40, kConfirmHeight)];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [confirmBtn setTitleColor:[Config defaultConfig].themeColor forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:confirmBtn];
        _confirmBtn = confirmBtn;
    }
}

- (void)confirmClick:(UIButton *)sender{
    [self removeFromSuperview];
}

+ (void)showAlertWithMessage:(NSString *)msg{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *win = app.window;
    
    ConfirmAlertView *alertView = [[ConfirmAlertView alloc] init];
    alertView.msgTitle.text = msg;
    
    [win addSubview:alertView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
@end
