//
//  PassWordInputViewController.h
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "BPBaseViewController.h"

typedef NS_ENUM(NSUInteger, PWViewType){
    PWViewTypeNew,          // 创建新密码
    PWViewTypeCancel,       // 取消密码
    PWViewTypeFirstIn,      // 登录时验证密码
};

@interface PassWordInputViewController : BPBaseViewController

@property (nonatomic, assign) PWViewType pwViewType;

@end
