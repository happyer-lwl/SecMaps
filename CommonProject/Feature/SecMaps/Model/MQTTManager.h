//
//  MQTTManager.h
//  CommonProject
//
//  Created by WyzcWin on 17/2/14.
//  Copyright © 2017年 runlwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTTManager : NSObject

+ (instancetype)sharedManager;

- (void)subcriptWithTopic:(NSString *)topic;

- (void)publishWithMessage:(NSString *)msg;

@end
