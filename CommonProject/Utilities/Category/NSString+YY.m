//
//  NSString+YY.m
//  HisunPay
//
//  Created by sks on 16/3/6.
//  Copyright © 2016年 com.hisuntech. All rights reserved.
//  属性字符串

#import "NSString+YY.h"

@implementation NSString (YY)

#pragma mark - 属性字符串
- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range color:(UIColor *)color font:(UIFont *)font {
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attriDic = @{NSForegroundColorAttributeName:color, NSFontAttributeName : font};
    [attriString setAttributes:attriDic range:range];
    
    return attriString;
}


- (NSMutableAttributedString *)attributedString:(NSString *)attributedString color:(UIColor *)color font:(UIFont *)font {
    
    NSRange range = [self rangeOfString:attributedString];
    return [self attributedStringWithRange:range color:color font:font];
}


- (NSMutableAttributedString *)attributedStrings:(NSArray *)attributedStrings color:(NSArray *)colors textFont:(NSArray *)fonts {
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self];
    for (NSInteger i = 0; i < attributedStrings.count; i++) {
        
        NSRange range = [self rangeOfString:attributedStrings[i]];
        NSDictionary *attriDic = @{NSForegroundColorAttributeName:colors[i], NSFontAttributeName:fonts[i]};
        [attriString setAttributes:attriDic range:range];
    }
    return attriString;
}


- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range font:(UIFont *)font
{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attriDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleSingle],NSStrokeColorAttributeName:[UIColor blackColor],NSFontAttributeName:font};
    [attriString setAttributes:attriDic range:range];
    return attriString;
}


@end
