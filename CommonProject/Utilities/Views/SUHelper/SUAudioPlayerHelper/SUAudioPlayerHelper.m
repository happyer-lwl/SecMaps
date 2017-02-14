//
//  SUAudioPlayerHelper.m
//  wyzc
//
//  Created by sunjun on 14-8-11.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import "SUAudioPlayerHelper.h"

@interface SUAudioPlayerHelper ()
{
    dispatch_queue_t  _playQueue;
}
@end

@implementation SUAudioPlayerHelper
#pragma mark - Public Methed
- (void)managerAudioWithFileName:(NSString*)amrName toPlay:(BOOL)toPlay {
    if (toPlay) {
        [self playAudioWithFileName:amrName];
    } else {
        [self pausePlayingAudio];
    }
}


- (void)managerAudioWithURL:(NSString*)url toPlay:(BOOL)toPlay
{
    if (toPlay) {
        [self playAudioWithURL:url];
    } else {
        [self pausePlayingAudio];
    }
}

//暂停
- (void)pausePlayingAudio {
    if (_player) {
        [_player pause];
        if ([self.delegate respondsToSelector:@selector(didAudioPlayerPausePlay:)]) {
            [self.delegate didAudioPlayerPausePlay:_player];
        }
    }
}

- (void)stopAudio {
    [self setPlayingFileName:@""];
    [self setPlayingIndexPathInFeedList:nil];
    if (_player && _player.isPlaying) {
        [_player stop];
    }
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    if ([self.delegate respondsToSelector:@selector(didAudioPlayerStopPlay:)]) {
        [self.delegate didAudioPlayerStopPlay:_player];
    }
}

#pragma mark - action

//播放转换后wav
- (void)playAudioWithURL:(NSString*)url {
    if (url.length > 0) {
        
        //不随着静音键和屏幕关闭而静音。code by Aevit
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        if (_playingFileName && [url isEqualToString:_playingFileName]) {//上次播放的录音
            if (_player) {
                [_player play];
                [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
                if ([self.delegate respondsToSelector:@selector(didAudioPlayerBeginPlay:)]) {
                    [self.delegate didAudioPlayerBeginPlay:_player];
                }
            }
        } else {//不是上次播放的录音
            if (_player) {
                [_player stop];
                self.player = nil;
            }
            /*
             [self convertAmrToWav:amrName];
             NSString *wavName = [amrName stringByReplacingOccurrencesOfString:@"wavToAmr" withString:@"amrToWav"];
             AVAudioPlayer *pl = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[XHVoiceCommonHelper getPathByFileName:fileName ofType:@"wav"]] error:nil];
             */
            __block __weak typeof(self) weakSelf = self;
            dispatch_async(_playQueue, ^{
                if (_delegate && [_delegate respondsToSelector:@selector(didAudioWillPlay:)]) {
                    [_delegate didAudioWillPlay:_player];
                }
                NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                if (_delegate && [_delegate respondsToSelector:@selector(didAudioDidPlay:)]) {
                    [_delegate didAudioDidPlay:_player];
                }
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [weakSelf mainPlayer:audioData];
                 });
             });
        }
        self.playingFileName = url;
    }
}

-(void) mainPlayer:(NSData *)audioData
{
    if (audioData != nil) {
        AVAudioPlayer *pl = [[AVAudioPlayer alloc] initWithData:audioData error:nil];
        pl.delegate = self;
        if (![pl play]) {
            
        }
        self.player = pl;
        [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didAudioPlayerBeginPlay:)]) {
            [self.delegate didAudioPlayerBeginPlay:_player];
        }
    }
}


//播放转换后wav
- (void)playAudioWithFileName:(NSString*)fileName {
    if (fileName.length > 0) {
        
        //不随着静音键和屏幕关闭而静音。code by Aevit
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        if (_playingFileName && [fileName isEqualToString:_playingFileName]) {//上次播放的录音
            if (_player) {
                [_player play];
                [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
                if ([self.delegate respondsToSelector:@selector(didAudioPlayerBeginPlay:)]) {
                    [self.delegate didAudioPlayerBeginPlay:_player];
                }
            }
        } else {//不是上次播放的录音
            if (_player) {
                [_player stop];
                self.player = nil;
            }
            /*
             [self convertAmrToWav:amrName];
             NSString *wavName = [amrName stringByReplacingOccurrencesOfString:@"wavToAmr" withString:@"amrToWav"];
             AVAudioPlayer *pl = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[XHVoiceCommonHelper getPathByFileName:fileName ofType:@"wav"]] error:nil];
             */
            AVAudioPlayer *pl = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fileName] error:nil];
            pl.delegate = self;
            [pl play];
            self.player = pl;
            [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
            if ([self.delegate respondsToSelector:@selector(didAudioPlayerBeginPlay:)]) {
                [self.delegate didAudioPlayerBeginPlay:_player];
            }
        }
        self.playingFileName = fileName;
    }
}
- (void)managerAudioWithData:(NSData*)data toPlay:(BOOL)toPlay{
    if (data.length > 0) {
        
        //不随着静音键和屏幕关闭而静音。code by Aevit
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        if (_playingData && [data isEqualToData:_playingData]) {//上次播放的录音
            if (_player) {
                [_player play];
                [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
                if ([self.delegate respondsToSelector:@selector(didAudioPlayerBeginPlay:)]) {
                    [self.delegate didAudioPlayerBeginPlay:_player];
                }
            }
        } else {//不是上次播放的录音
            if (_player) {
                [_player stop];
                self.player = nil;
            }
            AVAudioPlayer *pl = [[AVAudioPlayer alloc] initWithData:data error:nil];
            pl.delegate = self;
            [pl play];
            self.player = pl;
            [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
            if ([self.delegate respondsToSelector:@selector(didAudioPlayerBeginPlay:)]) {
                [self.delegate didAudioPlayerBeginPlay:_player];
            }
        }
        self.playingData = data;
    }

}
/*
 #pragma mark - amr转wav
 
 - (void)convertAmrToWav:(NSString*)amrName {
 if (amrName.length > 0){
 NSString *wavName = [amrName stringByReplacingOccurrencesOfString:@"wavToAmr" withString:@"amrToWav"];// [amrName stringByAppendingString:@"amrToWav"];
 
 //转格式
 [VoiceConverter amrToWav:[SCAudioRecordManager getPathByFileName:amrName ofType:@"amr"] wavSavePath:[SCAudioRecordManager getPathByFileName:wavName ofType:@"wav"]];
 
 }
 }
 */

#pragma mark - Getter

- (AVAudioPlayer*)player {
    return _player;
}

- (BOOL)isPlaying {
    if (!_player) {
        return NO;
    }
    return _player.isPlaying;
}

#pragma mark - Setter

- (void)setDelegate:(id<AudioPlayerHelperDelegate>)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
        
        if (_delegate == nil) {
            [self stopAudio];
        }
    }
}

#pragma mark - Life Cycle

+ (id)shareInstance {
    static SUAudioPlayerHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SUAudioPlayerHelper alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _playQueue = dispatch_queue_create("dispatch_palyer", nil);
        [self changeProximityMonitorEnableState:YES];
        [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    }
    return self;
}

- (void)dealloc {
    [self changeProximityMonitorEnableState:NO];
}

#pragma mark - audio delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self stopAudio];
    if ([self.delegate respondsToSelector:@selector(didAudioPlayerStopPlay:)]) {
        [self.delegate didAudioPlayerStopPlay:_player];
    }
}

#pragma mark - 近距离传感器

- (void)changeProximityMonitorEnableState:(BOOL)enable {
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    if ([UIDevice currentDevice].proximityMonitoringEnabled == YES) {
        if (enable) {
            
            //添加近距离事件监听，添加前先设置为YES，如果设置完后还是NO的读话，说明当前设备没有近距离传感器
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
            
        } else {
            
            //删除近距离事件监听
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
            [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        }
    }
}

- (void)sensorStateChange:(NSNotificationCenter *)notification {
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗
    if ([[UIDevice currentDevice] proximityState] == YES) {
        //黑屏
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
    } else {
        //没黑屏幕
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (!_player || !_player.isPlaying) {
            //没有播放了，也没有在黑屏状态下，就可以把距离传感器关了
            [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
        }
    }
}

@end