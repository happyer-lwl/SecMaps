//
//  SUAudioPlayerHelper.h
//  wyzc
//
//  Created by sunjun on 14-8-11.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVFoundation.h>
@protocol AudioPlayerHelperDelegate <NSObject>

@optional
- (void)didAudioWillPlay:(AVAudioPlayer *)audioPlay;
- (void)didAudioDidPlay:(AVAudioPlayer *)audioPlay;
- (void)didAudioPlayerBeginPlay:(AVAudioPlayer*)audioPlayer;
- (void)didAudioPlayerStopPlay:(AVAudioPlayer*)audioPlayer;
- (void)didAudioPlayerPausePlay:(AVAudioPlayer*)audioPlayer;

@end

@interface SUAudioPlayerHelper : NSObject <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, copy) NSString *playingFileName;

@property (nonatomic, strong) NSData * playingData;

@property (nonatomic, weak) id <AudioPlayerHelperDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *playingIndexPathInFeedList;//给动态列表用


+ (id)shareInstance;

- (AVAudioPlayer*)player;
- (BOOL)isPlaying;

- (void)managerAudioWithFileName:(NSString*)amrName toPlay:(BOOL)toPlay;

- (void)managerAudioWithURL:(NSString*)url toPlay:(BOOL)toPlay;

- (void)managerAudioWithData:(NSData*)data toPlay:(BOOL)toPlay;

- (void)pausePlayingAudio;//暂停
- (void)stopAudio;//停止



@end


