//
//  Config.m
//  wyzc
//
//  Created by Wayne on 16/2/23.
//  Copyright © 2016年 北京我赢科技有限公司. All rights reserved.
//

#import "Config.h"

@implementation Config

#pragma mark - SINGLETON

static Config *defaultConfig = nil;
static NSNumber *appType = nil;         // 应用类型  0：综合版  1:单独版
static NSDictionary *configDic = nil;   // 单独版的配置字典
static NSDictionary *multipleDic = nil; // 综合版的配置字典

static NSString * appSiteTypeString = nil; //siteType 对应的文字配置文件名称(张)


+ (Config *)defaultConfig {
    @synchronized(self) {
        if (defaultConfig == nil) {
            defaultConfig = [[self alloc] init];
            appType = [[NSBundle mainBundle] infoDictionary][@"App Type"];
            
            NSString *configPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
            configDic = [NSDictionary dictionaryWithContentsOfFile:configPath];
            
            NSString *multiplePath = [[NSBundle mainBundle] pathForResource:@"Multiple" ofType:@"plist"];
            multipleDic = [NSDictionary dictionaryWithContentsOfFile:multiplePath];
        }
    }
    
    return defaultConfig;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (defaultConfig == nil) {
            defaultConfig = [super allocWithZone:zone];
            return defaultConfig;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - getter重写
- (NSNumber *)appType {
    
    return [[NSBundle mainBundle] infoDictionary][@"App Type"];
}

- (NSNumber *)siteType {
    
    return [[NSBundle mainBundle] infoDictionary][@"Site Type"];
}

- (NSString *)baseURL {
    
    if ([appType isEqualToNumber:@0]) {
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        NSString *host = [us objectForKey:@"Config_host"];
        NSString *port = [us objectForKey:@"Config_port"];
        if ([port isEqualToString:@"80"]) {
            NSString *str = [NSString stringWithFormat:@"http://%@/Mobile/", host];
            return str;
        }else {
            NSString *str = [NSString stringWithFormat:@"http://%@:%@/Mobile/", host, port];
            return str;
        }
        
    }
    
    return configDic[@"Base URL"];
}

- (NSString *)baseType {
    
    if ([appType isEqualToNumber:@0]) {
        return @"/?m3u8=1";
    }
    
    return configDic[@"Base Type"];
}

- (NSString *)baseDomain {
    
    if ([appType isEqualToNumber:@0]) {
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        return [us objectForKey:@"Config_webUrl"]; // 此处还关系到二维码的地址
    }
    
    return configDic[@"Base Domain"];
}

- (NSString *)title {
    
    if ([appType isEqualToNumber:@0]) {
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        return [us objectForKey:@"Config_webSimpleName"];
    }
    return configDic[@"Title"];
    //    NSString * title = @"";
    //    switch ([Config defaultConfig].siteType.integerValue) {
    //        case 0:
    //            title = configDic[@"Title"];
    //            break;
    //        case 1:
    //            title = @"企业培训圈";
    //            break;
    //        case 2:
    //            //title = @"机构培训圈";
    //            title = configDic[@"Title"];
    //            break;
    //        case 3:
    //            title = @"人教社书友圈";
    //            break;
    //
    //        default:
    //            break;
    //    }
    //    return title;
}

- (UIColor *)themeColor {
    
    NSString *rgbValue;
    
    if ([appType isEqualToNumber:@0]) {
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        rgbValue = [us objectForKey:@"Config_mainColor"];
        rgbValue = [rgbValue substringFromIndex:1];
        if (!rgbValue || [rgbValue isEqualToString:@""]) {
            rgbValue = @"5baef5";
        }
    }else {
        rgbValue = configDic[@"Theme Color"];
    }
    
    UIColor *color = [UIColor colorWithRed:strtoul([[rgbValue substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16)/255.0
                                     green:strtoul([[rgbValue substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16)/255.0
                                      blue:strtoul([[rgbValue substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16)/255.0
                                     alpha:1.0];
    
    return color;
}

- (UIColor *)matchColor {
    
    NSString *rgbValue;
    
    if ([appType isEqualToNumber:@0]) {
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        rgbValue = [us objectForKey:@"Config_subColor"];
        rgbValue = [rgbValue substringFromIndex:1];
    }else {
        rgbValue = configDic[@"Match Color"];
    }
    
    UIColor *color = [UIColor colorWithRed:strtoul([[rgbValue substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16)/255.0
                                     green:strtoul([[rgbValue substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16)/255.0
                                      blue:strtoul([[rgbValue substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16)/255.0
                                     alpha:1.0];
    
    return color;
}

- (UIColor *)darkColor {
    
    NSString *rgbValue;
    
    if ([appType isEqualToNumber:@0]) {
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        rgbValue = [us objectForKey:@"Config_mainColor"];
        rgbValue = [rgbValue substringFromIndex:1];
        if (!rgbValue || [rgbValue isEqualToString:@""]) {
            rgbValue = @"5baef5";
        }
    }else {
        rgbValue = configDic[@"Theme Color"];
    }
    
    // 此颜色比主题色每种成分少32个值
    long long r;
    long long g;
    long long b;
    r = strtoll([[rgbValue substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16) - 32.0;
    g = strtoll([[rgbValue substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16) - 32.0;
    b = strtoul([[rgbValue substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16) - 32.0;
    if (r < 0) {
        r = 0;
    }
    if (g < 0) {
        g = 0;
    }
    if (b < 0) {
        b = 0;
    }
    
    UIColor *color = [UIColor colorWithRed:r/255.0
                                     green:g/255.0
                                      blue:b/255.0
                                     alpha:1.0];
    
    return color;
}

- (NSString *)t5PlayerAPIKey {
    
    return appType.intValue == 0 ? multipleDic[@"T5Player API Key"] : configDic[@"T5Player API Key"];
}

- (NSString *)t5PlayerSecretKey {
    
    return appType.intValue == 0 ? multipleDic[@"T5Player Secret Key"] : configDic[@"T5Player API Key"];
}

- (NSString *)bPushAPIKey {
    
    return appType.intValue == 0 ? multipleDic[@"BPush API Key"] : configDic[@"BPush API Key"];
}

- (NSString *)bPushSecretKey {
    
    return appType.intValue == 0 ? multipleDic[@"BPush Secret Key"] : configDic[@"BPush Secret Key"];
}

- (NSString *)mtjAPIKey {
    
    return appType.intValue == 0 ? multipleDic[@"Mtj APIKey"] : configDic[@"Mtj APIKey"];
}

- (NSString *)aMapAPIKey {
    
    return appType.intValue == 0 ? multipleDic[@"AMap APIKey"] : configDic[@"AMap APIKey"];
}

- (NSString *)IAPEnv {
    
    NSString *str = [Config defaultConfig].baseURL;
    NSRange range = [str rangeOfString:@"://"];
    str = [str substringFromIndex:range.location + range.length];
    str = [str componentsSeparatedByString:@"."].firstObject;
    
    if ([str isEqualToString:@"test"] || [str isEqualToString:@"192"]) {
        return @"0";
    }
    
    return @"1";
}

- (UIImage *)logoImage {
    
    UIImage *img;
    
    if ([[Config defaultConfig].appType isEqualToNumber:@0]) {
        
        NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
        NSString *logoUrl = [us objectForKey:@"Config_logoUrl"];
        logoUrl = [@"" stringByAppendingFormat:@"http://%@", logoUrl];
        if (logoUrl && ![logoUrl isEqualToString:@""]) {
            img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:logoUrl]]];
            return img;
        }else {
            return nil;
        }
        
    }else {
        img = [UIImage imageNamed:@"center_aboutour"];
        return img;
    }
    
    return nil;
}
@end
