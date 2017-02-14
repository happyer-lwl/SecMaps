//
//  UIButton+EnlargeEdge.h
//  BaseProject
//
//  Created by qingshan on 15/3/23.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import <UIKit/UIKit.h>

/*

原理

利用 objective-c 中的 objc_setAssociatedObject 來記錄要變大的範圍。

objc_setAssociatedObject 是 objective-c runtime library 裡面的 function。

需要#import <objc/runtime.h>

最后，最重要的是去 override - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event

用新设定的 Rect 来当着点击范围。

使用
[enlargeButton setEnlargeEdge:20.0];
或者[enlargeButton setEnlargeEdgeWithTop:20 right:20 bottom:20 left:10];
 
 */

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;


@end
