//
//  NSGlobal.m
//  wyzc
//
//  Created by sunjun on 14-7-14.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import "NSGlobal.h"
#import "AppDelegate.h"

@interface NSGlobal()
{
    NSTimer  *_netWorking;
}
@end


@implementation NSGlobal
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isIos7 = [[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0;
        self.mainScreen = [UIScreen mainScreen].bounds.size;
        self.deviceResoltion = [UIDevice currentResolution];
        self.uuid = [OpenUDID value];
        self.appId = @"";
        self.notifyInfos = [NSMutableArray array];
    }
    return self;
}

-(void) startNetNotify
{
    if(nil == _netWorking){
        // _netWorking = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(monitorNetwoking) userInfo:nil repeats:YES];
    }
}

-(void) monitorNetwoking
{
    [[Wyzc_Reachability reachabilityWithHostName:@"www.apple.com"] startNotifier];
}

// 是否wifi
+ (BOOL) IsEnableWIFI {
    return ([[Wyzc_Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+ (BOOL) IsEnable3G {
    return ([[Wyzc_Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

+ (BOOL) NetworkNotEnable
{
    return ([[Wyzc_Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable &&
            [[Wyzc_Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == NotReachable);
}

+(instancetype) sharedMethod
{
    static NSGlobal *g_global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_global = [[NSGlobal alloc] init];
        g_global.watchDuration = [g_global watch_duration];
    });
    return g_global;
}

-(void) setWatchDuration:(UInt64) watchDurations
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *br = [NSNumber numberWithLongLong:watchDurations];
    [userDefaults setObject:br forKey:@"watchDuration"];
    [userDefaults synchronize];
    _watchDuration = watchDurations;
}

-(UInt64) watch_duration
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *log =  [userDefaults objectForKey:@"watchDuration"];
    return (log)?log.unsignedLongLongValue:0;
}
@end
