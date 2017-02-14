//
//  SUAutoLabel.m
//  wyzc
//
//  Created by sunjun on 14-9-5.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import "SUAutoLabel.h"

@interface SUAutoLabel ()
{
    NSTimer   *_timer;
    NSUInteger count;
}
@end

@implementation SUAutoLabel
- (void)dealloc
{
    [self stop];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        count = 0;
    }
    return self;
}

-(void) start:(NSTimeInterval)ti
{
    if(nil == _timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(changeText:) userInfo:nil repeats:YES];
    }
}
-(void) stop
{
    if(_timer && [_timer isValid]){
        [_timer invalidate];
        _timer = nil;
    }
}


-(void) changeText:(id) sender
{
    count++;
    if (_runCallback) {
        _runCallback(self,count);
    }
}


@end

