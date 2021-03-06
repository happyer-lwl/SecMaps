//
//  SUVoiceRecordHelper.m
//  wyzc
//
//  Created by sunjun on 14-8-7.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import "SUVoiceRecordHelper.h"
#import <AVFoundation/AVFoundation.h>

#define  if_complteion_toMain_par(complation,par) if(complation){\
dispatch_async(dispatch_get_main_queue(), ^{\
complation(par);\
});\
}

#define  if_complteion_toMain_void(call_block) if(call_block){\
dispatch_async(dispatch_get_main_queue(), ^{\
call_block();\
});}

@interface SUVoiceRecordHelper () <AVAudioRecorderDelegate> {
    NSTimer *_timer;
    
    BOOL _isPause;
    
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
	UIBackgroundTaskIdentifier _backgroundIdentifier;
#endif
}

@property (nonatomic, copy, readwrite) NSString *recordPath;
@property (nonatomic, readwrite) NSTimeInterval currentTimeInterval;
@property (nonatomic, strong) AVAudioRecorder *recorder;

@end


@implementation SUVoiceRecordHelper

- (id)init {
    self = [super init];
    if (self) {
        self.maxRecordTime = 60.0;
        self.recordDuration = @"0";
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
		_backgroundIdentifier = UIBackgroundTaskInvalid;
#endif
    }
    return self;
}

- (void)dealloc {
    [self stopRecord];
    self.recordPath = nil;
    [self stopBackgroundTask];
}

- (void)startBackgroundTask {
	[self stopBackgroundTask];
	
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
	_backgroundIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
		[self stopBackgroundTask];
	}];
#endif
}

- (void)stopBackgroundTask {
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
	if (_backgroundIdentifier != UIBackgroundTaskInvalid) {
		[[UIApplication sharedApplication] endBackgroundTask:_backgroundIdentifier];
		_backgroundIdentifier = UIBackgroundTaskInvalid;
	}
#endif
}

- (void)resetTimer {
    if (!_timer)
        return;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
}

- (void)cancelRecording {
    if (!_recorder)
        return;
    
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
    
    self.recorder = nil;
}

- (void)stopRecord {
    [self cancelRecording];
    [self resetTimer];
}

- (void)startRecordingWithPath:(NSString *)path withSetting:(NSDictionary *)setting StartRecorderCompletion:(StartRecorderCompletion)startRecorderCompletion
{
    _isPause = NO;
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&error];
    if(error) {
        DLog(@"audioSession: %@ %ld %@", [error domain], (long)[error code], [[error userInfo] description]);
        return;
    }
    [audioSession setActive:YES error:&error];
    error = nil;
    if(error) {
        DLog(@"audioSession: %@ %ld %@", [error domain], (long)[error code], [[error userInfo] description]);
        return;
    }
    
    self.recordPath = path;
    
    error = nil;
    
    if (self.recorder) {
        [self cancelRecording];
    } else {
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.recordPath] settings:setting error:&error];
        if(_recorder){
        _recorder.delegate = self;
        [_recorder prepareToRecord];
        _recorder.meteringEnabled = YES;
        [_recorder recordForDuration:(NSTimeInterval) 160];
        [self startBackgroundTask];
        }else{
            if_complteion_toMain_par(startRecorderCompletion,error);
        }
    }
    
    if ([_recorder record]) {
        [self resetTimer];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
        if_complteion_toMain_par(startRecorderCompletion,error);
    }
}

- (void)resumeRecordingWithResumeRecorderCompletion:(ResumeRecorderCompletion)resumeRecorderCompletion {
    _isPause = NO;
    if (_recorder) {
        if ([_recorder record]) {
            if_complteion_toMain_void(resumeRecorderCompletion);
            //dispatch_async(dispatch_get_main_queue(), resumeRecorderCompletion);
        }
    }
}

- (void)pauseRecordingWithPauseRecorderCompletion:(PauseRecorderCompletion)pauseRecorderCompletion {
    _isPause = YES;
    if (_recorder) {
        [_recorder pause];
    }
    if (!_recorder.isRecording){
        if_complteion_toMain_void(pauseRecorderCompletion);
    }
        //dispatch_async(dispatch_get_main_queue(), pauseRecorderCompletion);
}

- (void)stopRecordingWithStopRecorderCompletion:(StopRecorderCompletion)stopRecorderCompletion {
    [self getVoiceDuration:_recordPath];
    
    _isPause = NO;
    [self stopBackgroundTask];
    [self stopRecord];
    if_complteion_toMain_void(stopRecorderCompletion);
   // dispatch_async(dispatch_get_main_queue(), stopRecorderCompletion);
}


- (void)cancelledDeleteWithCompletion:(CancellRecorderDeleteFileCompletion)cancelledDeleteCompletion {
    _isPause = NO;
    [self stopBackgroundTask];
    [self stopRecord];
    if (self.recordPath) {
        // 删除目录下的文件
        NSFileManager *fileManeger = [NSFileManager defaultManager];
        if ([fileManeger fileExistsAtPath:self.recordPath]) {
            NSError *error = nil;
            [fileManeger removeItemAtPath:self.recordPath error:&error];
            if (error) {
                DLog(@"error :%@", error.description);
            }
            if_complteion_toMain_par(cancelledDeleteCompletion, error);
        } else {
            if_complteion_toMain_par(cancelledDeleteCompletion, nil);
        }
    } else {
        if_complteion_toMain_par(cancelledDeleteCompletion, nil);
    }
    
}

- (void)updateMeters {
    if (!_recorder)
        return;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_recorder updateMeters];
        
        self.currentTimeInterval = _recorder.currentTime;
        
        if (!_isPause) {
            float progress = self.currentTimeInterval / self.maxRecordTime * 1.0;
            if (_recordProgress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _recordProgress(progress);
                });
            }
        }
        float peakPower = [_recorder averagePowerForChannel:0];
        double ALPHA = 0.015;
        double peakPowerForChannel = pow(10, (ALPHA * peakPower));
        if(_peakPowerForChannel)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新扬声器
                _peakPowerForChannel(peakPowerForChannel);
            });

            
        }
        if (self.currentTimeInterval > self.maxRecordTime) {
            [self stopRecord];
            if(_maxTimeStopRecorderCompletion){
                dispatch_async(dispatch_get_main_queue(), ^{
                    _maxTimeStopRecorderCompletion();
                });
            }
        }
    });
}

-(void) duration
{

}

- (void)getVoiceDuration:(NSString*)recordPath
{
    DLog(@"时长:%d",(int) self.currentTimeInterval);
    self.recordDuration = [NSString stringWithFormat:@"%.0f", self.currentTimeInterval];
}



@end