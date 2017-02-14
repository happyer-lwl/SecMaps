//
//  InputPassWordView.m
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "InputPassWordView.h"

@interface InputPassWordView(){
    
    NSInteger _passwordLength;
}

@property (nonatomic, strong) NSMutableArray *subViewArray;

@end

@implementation InputPassWordView

- (instancetype)initWithFrame:(CGRect)frame passwordLength:(NSInteger)length{
    
    if (self = [super initWithFrame:frame]) {
        
        
        _passwordLength = length;
        
        [self imageViewArray];
        [self initSubViews];
    }
    
    return self;
}

- (NSMutableArray *)imageViewArray{
    if (_subViewArray == nil) {
        _subViewArray = [NSMutableArray array];
    }
    return _subViewArray;
}

- (void)initSubViews{
    
    for (int i = 0; i < _passwordLength; i++) {
        
        CGFloat subViewWidth = (self.width - 30.0f) / _passwordLength;
        CGFloat subViewX = i * (subViewWidth + 10.0f);
        
        UIView *subView = [[UIImageView alloc] initWithFrame:CGRectMake(subViewX, 0, subViewWidth, subViewWidth)];
        subView.layer.borderColor = kThemeColor.CGColor;
        subView.layer.borderWidth = 1.0f;
        subView.layer.cornerRadius = subViewWidth * 0.5;
        subView.backgroundColor = CommonBackgroundColor;
        [self addSubview:subView];
        
        [_subViewArray addObject:subView];
    }
}

- (void)updateInputViewStatus:(NSString *)password{
    
    NSInteger realPasswordLen = password.length;
    for (int i = 0; i < _passwordLength; i++) {
        UIView *subView = [_subViewArray objectAtIndex:i];
        if (i < realPasswordLen) {
            subView.backgroundColor = kThemeColor;
        }else{
            subView.backgroundColor = CommonBackgroundColor;
        }
    }
}
@end
