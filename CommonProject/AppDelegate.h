//
//  AppDelegate.h
//  CommonProject
//
//  Created by WyzcWin on 16/10/26.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)  BPTabBarController *bpTabBarController;
@property (assign, nonatomic) NSInteger selectedIndex;

- (void)goToMainVC;
- (void)goToSelected:(UIViewController *)viewContorller;

@end

