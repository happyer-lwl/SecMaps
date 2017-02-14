//
//  UINavigationBar+JTDropShadow.h
//  蜀国演义
//
//  Created by DDK on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (JTDropShadow)
-(void)dropShadowWithOffset:(CGSize)offset
                     radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity;
@end
