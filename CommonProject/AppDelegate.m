//
//  AppDelegate.m
//  BaseProject
//
//  Created by WyzcWin on 16/10/26.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "AppDelegate.h"
#import "BPTouchIdViewController.h"
#import "PassWordInputViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self checkPassword];
    
    [[BPDBManager sharedInstance] initDb];
    
    return YES;
}


#pragma mark - CustomMethods
- (void)goToMainVC{
    
    [self updateTabBar];
}

- (void)goToSelected:(UIViewController *)viewContorller{
    
}

- (void)checkPassword{
    
    NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"];
    if (!STRISEMPTY(pw)) {
        NSNumber *touchIdOpen = [[NSUserDefaults standardUserDefaults] objectForKey:@"TouchID"];
        if (touchIdOpen.boolValue) {
            BPTouchIdViewController *touchidVC = [[BPTouchIdViewController alloc] init];
            self.window.rootViewController = touchidVC;
            [self.window makeKeyAndVisible];
        }else{
            PassWordInputViewController *pwInput = [[PassWordInputViewController alloc] init];
            pwInput.pwViewType = PWViewTypeFirstIn;
            self.window.rootViewController = pwInput;
            [self.window makeKeyAndVisible];
        }
    }else{
        [self goToMainVC];
    }
}

- (void)updateTabBar{
    
    self.bpTabBarController = [[BPTabBarController alloc] init];
    
    self.window.rootViewController = _bpTabBarController;
    [self.window makeKeyAndVisible];
}

#pragma mark - AppDelegate
- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self checkPassword];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
