//
//  UINavigationBar+JTDropShadow.m
// 
//
//  Created by DDK on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+JTDropShadow.h"
#import <QuartzCore/QuartzCore.h>
@implementation UINavigationBar (JTDropShadow)
-(void)dropShadowWithOffset:(CGSize)offset
                     radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}

@end
