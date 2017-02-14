//
//  UIImage+ChangeColor.m
//  wyzc
//
//  Created by Wayne on 16/2/26.
//  Copyright © 2016年 北京我赢科技有限公司. All rights reserved.
//

#import "UIImage+ChangeColor.h"

@implementation UIImage (ChangeColor)

- (UIImage *)imageWithColor:(UIColor *)color {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
