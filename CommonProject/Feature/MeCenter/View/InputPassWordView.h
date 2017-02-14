//
//  InputPassWordView.h
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputPassWordView : UIView

- (instancetype)initWithFrame:(CGRect)frame passwordLength:(NSInteger)length;

- (void)updateInputViewStatus:(NSString *)password;

@end
