//
//  UIView+ExclusiveTouch.m
//  wyzc
//
//  Created by Liuwl on 16/5/11.
//  Copyright © 2016年 北京我赢科技有限公司. All rights reserved.
//

#import "UIView+ExclusiveTouch.h"

@implementation UIView (ExclusiveTouch)// 所有控件禁止多个同时点击

+ (void)load{
    
    Method oldFrameMethod = class_getInstanceMethod(self, @selector(initWithFrame:));
    Method newFrameMethod = class_getInstanceMethod(self, @selector(initWithFrameForExclusiveView:));
    method_exchangeImplementations(oldFrameMethod, newFrameMethod);
    
    Method oldCoderMethod = class_getInstanceMethod(self, @selector(initWithCoder:));
    Method newCoderMethod = class_getInstanceMethod(self, @selector(initWithCoderForExclusiveView:));
    method_exchangeImplementations(oldCoderMethod, newCoderMethod);
}

- (instancetype)initWithFrameForExclusiveView:(CGRect)frame{
   
    UIView *exclusiveView = [self initWithFrameForExclusiveView:frame];
    [exclusiveView setExclusiveTouch:YES];
    
    return exclusiveView;
}

- (instancetype)initWithCoderForExclusiveView:(NSCoder *)aDecoder{
    
    UIView *exclusiveView = [self initWithCoderForExclusiveView:aDecoder];
    [exclusiveView setExclusiveTouch:YES];
    
    return exclusiveView;
}

@end
