//
//  BPTabBarController.m
//  CommonProject
//
//  Created by WyzcWin on 16/10/26.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "BPTabBarController.h"
#import "BPNavigationController.h"

#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MeCenterViewController.h"

@interface BPTabBarController ()

@end

@implementation BPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSMutableArray *imageNormalArray = [NSMutableArray arrayWithObjects:
                                        @"tabBar_index",
                                        @"tabBar_institutesDepartment",
                                        @"tabbar_findNormal",
                                        @"tabBar_my",nil];
    
    NSMutableArray *imageSelectedArray = [NSMutableArray arrayWithObjects:
                                          @"tabBar_indexSelected",
                                          @"tabBar_institutesDepartmentSelected",
                                          @"tabbar_findSelected",
                                          @"tabBar_mySelected",nil];
    
    NSArray *titlesArray = @[@"首页", @"院系", @"发现", @"我"];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChidVc:homeVC title:[titlesArray objectAtIndex:0] normalImage:[imageNormalArray objectAtIndex:0] selectedImage:[imageSelectedArray objectAtIndex:0]];
    
    HomeViewController *categoryVC = [[HomeViewController alloc] init];
    [self addChidVc:categoryVC title:[titlesArray objectAtIndex:1] normalImage:[imageNormalArray objectAtIndex:1] selectedImage:[imageSelectedArray objectAtIndex:1]];
    
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] init];
    [self addChidVc:discoverVC title:[titlesArray objectAtIndex:2] normalImage:[imageNormalArray objectAtIndex:2] selectedImage:[imageSelectedArray objectAtIndex:2]];
    
    MeCenterViewController *meVC = [[MeCenterViewController alloc] init];
    [self addChidVc:meVC title:[titlesArray objectAtIndex:3] normalImage:[imageNormalArray objectAtIndex:3] selectedImage:[imageSelectedArray objectAtIndex:3]];
    
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
}

- (void)addChidVc:(UIViewController *)viewController title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage{
    
    if ([viewController isKindOfClass:[HomeViewController class]]) {
        viewController.tabBarItem.title = title;
    }else {
        viewController.title = title;
    }
    viewController.tabBarItem.image = [UIImage imageNamed:normalImage];
    if (iOS7) {
        viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    // 设置文字样式
//    NSMutableDictionary *profileAttri = [NSMutableDictionary dictionary];
//    profileAttri[NSForegroundColorAttributeName] = kViewTabbarNormal;
//    [viewController.tabBarItem setTitleTextAttributes:profileAttri forState:UIControlStateNormal];
//    profileAttri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
//    [viewController.tabBarItem setTitleTextAttributes:profileAttri forState:UIControlStateNormal];
//    profileAttri[NSForegroundColorAttributeName] = kViewTabbarSelected;
//    [viewController.tabBarItem setTitleTextAttributes:profileAttri forState:UIControlStateSelected];
    
    BPNavigationController *nav = [[BPNavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
