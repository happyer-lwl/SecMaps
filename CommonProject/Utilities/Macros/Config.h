//
//  Config.h
//  wyzc
//
//  Created by Wayne on 16/2/23.
//  Copyright © 2016年 北京我赢科技有限公司. All rights reserved.
//
//  全局配置文件

#import <UIKit/UIKit.h>

@interface Config : NSObject

@property (nonatomic, strong) NSNumber *appType;            // 0:综合版 1:单独版
@property (nonatomic, strong) NSNumber *siteType;           // 0:高校 1:企业 2:机构
@property (nonatomic, strong) NSString *baseURL;            //
@property (nonatomic, strong) NSString *baseType;           //
@property (nonatomic, strong) NSString *baseDomain;         //
@property (nonatomic, strong) NSString *title;              // 首页标题(简称)
@property (nonatomic, strong) UIColor *themeColor;          // 主题色
@property (nonatomic, strong) UIColor *matchColor;          // 配色
@property (nonatomic, strong) UIColor *darkColor;           // 根据主题色，颜色加深所变化出来的颜色
@property (nonatomic, strong) NSString *t5PlayerAPIKey;     // 百度T5播放器-APIKey
@property (nonatomic, strong) NSString *t5PlayerSecretKey;  // 百度T5播放器-SecretKey
@property (nonatomic, strong) NSString *bPushAPIKey;        // 百度推送-APIKey
@property (nonatomic, strong) NSString *bPushSecretKey;     // 百度推送-SecretKey
@property (nonatomic, strong) NSString *mtjAPIKey;          // 百度统计-APIKey
@property (nonatomic, strong) NSString *aMapAPIKey;         // 高德地图-APIKey

@property (nonatomic, strong) NSString *IAPEnv;             // IAP支付环境参数（根据baseURL获得）
@property (nonatomic, strong) UIImage *logoImage;           // logo图标

+ (Config *)defaultConfig; // 单例方法

@end
