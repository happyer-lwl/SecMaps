//
//  NSString+YY.h
//  HisunPay
//
//  Created by sks on 16/3/6.
//  Copyright © 2016年 com.hisuntech. All rights reserved.
//  属性字符串

#import <Foundation/Foundation.h>

#define kTextFont(x)     [UIFont systemFontOfSize:x]
#define kBoldTextFont(x) [UIFont boldSystemFontOfSize:x]




@interface NSString (YY)

/**
 *  属性字符串-设置单个
 *
 *  @param range 属性字符串的范围
 *  @param color 属性字符串颜色
 *  @param font  属性字符串字体大小
 *
 *  @return 返回设置好的属性字符串
 */
- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range color:(UIColor *)color font:(UIFont *)font;


/**
 *  属性字符串-设置单个
 *
 *  @param originalString       字串全串
 *  @param attributedString     需要属性化的字符串
 *  @param color                属性字符串颜色
 *  @param fontSize             属性字符串字体大小
 *
 *  @return 返回设置好的属性字符串
 */
- (NSMutableAttributedString *)attributedString:(NSString *)attributedString color:(UIColor *)color font:(UIFont *)font;

/**
 *  属性字符串-设置多个
 */
- (NSMutableAttributedString *)attributedStrings:(NSArray *)attributedStrings color:(NSArray *)colors textFont:(NSArray *)fonts;
/**
 *  加下划线
 */
- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range font:(UIFont *)font;
@end
