//
//  BPNavigationController.m
//  BaseProject
//
//  Created by WyzcWin on 16/10/26.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "BPNavigationController.h"

@interface BPNavigationController ()

@end

@implementation BPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
