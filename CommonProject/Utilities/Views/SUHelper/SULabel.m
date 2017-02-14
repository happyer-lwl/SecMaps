//
//  SULabel.m
//  wyzc
//
//  Created by qingshan on 15/4/21.
//  Copyright (c) 2015年 北京我赢科技有限公司. All rights reserved.
//

#import "SULabel.h"
#import "AFURLConnectionOperation.h"

@interface SULabel()
{
    NSTimer   *_timer;
}
@end


@implementation SULabel
- (void)dealloc
{
    [self stopLoading];
}

-(void) loadingText
{
    unsigned long byte = [AFURLConnectionOperation averageBandwidthUsedPerSecond];
    NSString *strKpbs = nil;
    if (byte < 1024) {
        strKpbs = [NSString stringWithFormat:@"%lu B/S",byte];
    }else if(byte/1024 < 1024){
        strKpbs = [NSString stringWithFormat:@"%lu KB/S",byte/1024];
    }else{
        strKpbs = [NSString stringWithFormat:@"%lu MB/S",byte/1024/1024];
    }
    if (strKpbs) {
        self.text = [NSString stringWithFormat:@"正在加载:%@",strKpbs];
    }
}

-(void) startLoading
{
    if(nil == _timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(loadingText) userInfo:nil repeats:YES];
    }
    [self loadingText];
}

-(void) stopLoading
{
    if(_timer && [_timer isValid]){
        [_timer invalidate];
        _timer = nil;
    }
}
@end

@interface SULabelActive()
{
    NSTimer   *_timer;
}
@end

#define max_time_secend  (1*60*60)
@implementation SULabelActive
- (void)dealloc{
    [self stop];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxTimes = max_time_secend;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSNumber *number = [userDefaults objectForKey:@"sctms"];
        if (number) {
            _tmCount = [number longValue];
        }else{
            self.tmCount = 0;
            //self.maxTimes = max_time_secend;  //默认一小时
        }
        self.isRuning = NO;
    }
    return self;
}

-(void) stop
{
    if(_timer && [_timer isValid]){
        [_timer invalidate];
        _timer = nil;
        _tmCount = 0;
        self.isRuning = NO;
    }
}

-(void) starting
{
    if(nil == _timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(loadingText) userInfo:nil repeats:YES];
        self.isRuning = YES;
    }
    [self loadingText];
}

-(void) setTmcCallback:(TMCallback)callback
{
    _upCallback = callback;
}

-(void) loadingText
{
    if (_upCallback){
        _upCallback(self,_tmCount);
    }
    if (_tmCount >= self.maxTimes) {
        [self stop];
        self.tmCount = 0;
        self.maxTimes = max_time_secend;
    }
}

-(void) setTmCount:(long)tmCount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *br = [NSNumber numberWithLong:tmCount];
    [userDefaults setObject:br forKey:@"sctms"];
    [userDefaults synchronize];
    _tmCount = tmCount;
}
@end
