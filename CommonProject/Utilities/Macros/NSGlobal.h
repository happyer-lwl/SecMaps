//
//  NSGlobal.h
//  wyzc
//
//  Created by sunjun on 14-7-14.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//
/**
 *  项目中随时都能用到的参数
 *
 */


#import <Foundation/Foundation.h>
#import "UIDevice+Resolutions.h"
#import "OpenUDID.h"
#import "DataCenter.h"

#define LOGIN_DATA_KEY  @"loginData"
#define IS_IOS7          [[NSGlobal sharedMethod] isIos7]
#define SCreenWidth      (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height)?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.width))
#define SCreenHegiht     (([UIScreen mainScreen].bounds.size.height < [UIScreen mainScreen].bounds.size.width)?([UIScreen mainScreen].bounds.size.width):([UIScreen mainScreen].bounds.size.height))
#define DeviceResoultion [[NSGlobal sharedMethod] deviceResoltion]
#define NAVIGATION_BAR_HEIGHT   64.0f
#define inputBarHeight  45.f
#define SearchBtnHeight   40.0f
#define IOS6_7_DELTA(V,X,Y,W,H) if(IS_IOS7) {CGRect f = V.frame;f.origin.x += X;f.origin.y += Y;f.size.width +=W;f.size.height += H;V.frame=f;}
#define MAX_WATCH_DUATION  (3600*7)// 离线观看的时间 7小时

#define IS_PAD ([(NSString *)[[UIDevice currentDevice].model componentsSeparatedByString:@" "].firstObject isEqualToString:@"iPad"])

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

// 主屏幕的高度比例
#define kScreen_H_Scale (SCreenHegiht/667)
// 主屏幕的宽度比例
#define kScreen_W_Scale (SCreenWidth/375)

// 主屏幕的高度比例
#define kScreen_H_Scale4c (SCreenHegiht/568)
// 主屏幕的宽度比例
#define kScreen_W_Scale4c (SCreenWidth/320)

//
#define kScreen_scale    [UIScreen mainScreen].scale/2.0 

#define iOS9  SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define iOS8  SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define iOS7  SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

#define iOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion]floatValue] >= 6.0)
#define iOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion]floatValue] >= 7.0)
#define iOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion]floatValue] >= 8.0)
#define iOS8_OR_BEFORE ([[[UIDevice currentDevice] systemVersion]floatValue] <= 8.0)
#define iOS9_OR_BEFORE ([[[UIDevice currentDevice] systemVersion]floatValue] <= 9.0)
#define iOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion]floatValue] >= 9.0)
#define iOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion]floatValue] >= 10.0)


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//NSUserDefaults 实例化
/**  以key,value存储信息 */
#define kUserDefaultsSet(key,value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
/** 以key取出value */
#define kUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
/** 以key删除value */
#define kUserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
/** 立即同步 */
#define kUserDefaultsSynchronize  [[NSUserDefaults standardUserDefaults] synchronize]


//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

@interface NSGlobal : NSObject

//设备方面的参数
@property(nonatomic,assign) BOOL isIos7;
@property(nonatomic,assign) CGSize mainScreen;
@property(nonatomic,assign) UIDeviceResolution deviceResoltion;
@property(nonatomic,copy) NSString *uuid;
@property(nonatomic,copy) NSString *appId;
@property(nonatomic,copy) NSString *url; //下载地址
@property(nonatomic,assign) UInt64 watchDuration;  //离线观看时长秒  累计7小时
@property(nonatomic,strong) NSMutableArray *notifyInfos;
//@property(nonatomic,assign) BOOL currentAllowDownloading;//当时是否允许下载
//@property(nonatomic,assign) BOOL currentHasNetwork;//当时是否有网络，包括wifi和允许下载的手机网络
+ (BOOL) IsEnableWIFI;
+ (BOOL) IsEnable3G;
+ (BOOL) NetworkNotEnable;//当前是否没有网络
+ (BOOL) checkFreeSpace;
+ (instancetype) sharedMethod;
@end
