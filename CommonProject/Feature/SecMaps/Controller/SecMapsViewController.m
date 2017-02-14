//
//  SecMapsViewController.m
//  CommonProject
//
//  Created by WyzcWin on 17/2/14.
//  Copyright © 2017年 runlwl. All rights reserved.
//

#import "SecMapsViewController.h"
#import "MQTTManager.h"

@interface SecMapsViewController ()

@end

@implementation SecMapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [[MQTTManager sharedManager] subcriptWithTopic:@"root/123/123"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
