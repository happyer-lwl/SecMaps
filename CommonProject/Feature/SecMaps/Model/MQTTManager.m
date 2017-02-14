//
//  MQTTManager.m
//  CommonProject
//
//  Created by WyzcWin on 17/2/14.
//  Copyright © 2017年 runlwl. All rights reserved.
//

#import "MQTTManager.h"
#import <MQTTClient.h>
#import <MQTTSessionManager.h>


#define kMQTTHost @"60.205.185.155"
#define kMQTTPort 1883
#define kMQTTUserName @"lwl"
#define kMQTTPassword @"lwl"

#define kMQTTTopic @"root/123/123"

@interface MQTTManager()<MQTTSessionManagerDelegate>

@property (nonatomic, strong) MQTTSessionManager *mySessionManager;

@end

@implementation MQTTManager

+ (instancetype)sharedManager{
    static MQTTManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MQTTManager alloc] init];
        
    });
    return manager;
}

- (void)subcriptWithTopic:(NSString *)topic{
    
    self.mySessionManager.subscriptions = [[NSMutableDictionary alloc] init];
    [self.mySessionManager.subscriptions setValue:[NSNumber numberWithInt:1] forKey:kMQTTTopic];
}

- (void)publishWithMessage:(NSString *)msg{
    [self.mySessionManager sendData:[msg dataUsingEncoding:NSUTF8StringEncoding] topic:kMQTTTopic qos:MQTTQosLevelAtMostOnce retain:NO];
}

- (MQTTSessionManager *)mySessionManager{
    if (_mySessionManager == nil) {
        _mySessionManager = [[MQTTSessionManager alloc] init];
        [_mySessionManager connectTo:kMQTTHost
                                port:kMQTTPort
                                 tls:NO
                           keepalive:60
                               clean:NO
                                auth:YES
                                user:kMQTTUserName
                                pass:kMQTTPassword
                           willTopic:@""
                                will:@""
                             willQos:0
                      willRetainFlag:NO
                        withClientId:@""];
        _mySessionManager.delegate = self;
    }
    return _mySessionManager;
}

//#pragma mark - MQTTSessionManagerDelegate
//- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained{
//    
//    NSString *msgStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    DLog(@"Receive Msg: %@", msgStr);
//}
@end
