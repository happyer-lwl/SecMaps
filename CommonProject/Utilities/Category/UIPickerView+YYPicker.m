//
//  UIPickerView+YYPicker.m
//  wyzc
//
//  Created by Wayne on 16/9/12.
//  Copyright © 2016年 北京我赢科技有限公司. All rights reserved.
//

#import "UIPickerView+YYPicker.h"
#import <objc/runtime.h>


@implementation UIPickerView (YYPicker)

- (void)clearSpearatorLine
{
    if (!self.mal_lineisHidden)//该方法会被多次调用，加一个标示让它只调用一次
    {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.height < 1)
            {
                obj.backgroundColor = [UIColor clearColor];
            }
        }];
    }
    self.mal_lineisHidden = YES;
}
- (BOOL)mal_lineisHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setMal_lineisHidden:(BOOL)mal_lineisHidden
{
    objc_setAssociatedObject(self, @selector(mal_lineisHidden), @(mal_lineisHidden), OBJC_ASSOCIATION_ASSIGN);
}

@end
