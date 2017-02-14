//
//  BPTouchIdViewController.m
//  CommonProject
//
//  Created by WyzcWin on 16/11/1.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "BPTouchIdViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "PassWordInputViewController.h"
#import "AppDelegate.h"

@interface BPTouchIdViewController ()

@end

@implementation BPTouchIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CommonBackgroundColor;
    
    LAContext *context = [LAContext new];
    
    NSError *error;
    context.localizedFallbackTitle = @"";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        WeakSelf
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:NSLocalizedString(@"使用Touch ID登录小管家", nil)
                          reply:^(BOOL success, NSError *error) {
                              if (success) {
                                  
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                      [delegate goToMainVC];
                                      [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                  });
                              } else {
                                  if (error.code == kLAErrorUserFallback) {
                                      PassWordInputViewController *pwInput = [[PassWordInputViewController alloc] init];
                                      pwInput.pwViewType = PWViewTypeFirstIn;
                                      [weakSelf presentViewController:pwInput animated:YES completion:^{
                                          [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                      }];
                                  } else if (error.code == kLAErrorUserCancel) {
                                      PassWordInputViewController *pwInput = [[PassWordInputViewController alloc] init];
                                      pwInput.pwViewType = PWViewTypeFirstIn;
                                      [weakSelf presentViewController:pwInput animated:YES completion:^{
                                          [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                      }];
                                  } else {
                                      PassWordInputViewController *pwInput = [[PassWordInputViewController alloc] init];
                                      pwInput.pwViewType = PWViewTypeFirstIn;
                                      [weakSelf presentViewController:pwInput animated:YES completion:^{
                                          [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                      }];
                                  }
                              }
                          }];
    } else {
        NSLog(@"Touch ID is not available: %@", error);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
