//
//  SUVoiceRecordHelper.h
//  wyzc
//
//  Created by sunjun on 14-8-7.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


typedef void(^StartRecorderCompletion)(NSError *error);
typedef void(^StopRecorderCompletion)();
typedef void(^PauseRecorderCompletion)();
typedef void(^ResumeRecorderCompletion)();
typedef void(^CancellRecorderDeleteFileCompletion)(id info);
typedef void(^RecordProgress)(float progress);
typedef void(^PeakPowerForChannel)(float peakPowerForChannel);

@interface SUVoiceRecordHelper : NSObject

@property (nonatomic, copy) StopRecorderCompletion maxTimeStopRecorderCompletion;
@property (nonatomic, copy) RecordProgress recordProgress;
@property (nonatomic, copy) PeakPowerForChannel peakPowerForChannel;
@property (nonatomic, copy, readonly) NSString *recordPath;
@property (nonatomic, copy) NSString *recordDuration;
@property (nonatomic) float maxRecordTime; // 默认 60秒为最大
@property (nonatomic, readonly) NSTimeInterval currentTimeInterval;

- (void)startRecordingWithPath:(NSString *)path withSetting:(NSDictionary *)setting StartRecorderCompletion:(StartRecorderCompletion)startRecorderCompletion;
- (void)pauseRecordingWithPauseRecorderCompletion:(PauseRecorderCompletion)pauseRecorderCompletion;
- (void)resumeRecordingWithResumeRecorderCompletion:(ResumeRecorderCompletion)resumeRecorderCompletion;
- (void)stopRecordingWithStopRecorderCompletion:(StopRecorderCompletion)stopRecorderCompletion;
- (void)cancelledDeleteWithCompletion:(CancellRecorderDeleteFileCompletion)cancelledDeleteCompletion;

@end
