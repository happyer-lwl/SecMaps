//
//  GoodViewController.h
//  CommonProject
//
//  Created by WyzcWin on 16/11/1.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "BPBaseViewController.h"

typedef NS_ENUM(NSUInteger, GoodViewType){
    GoodViewTypeAdd,    // 添加
    GoodViewTypeLook,   // 查看
};

@interface GoodViewController : BPBaseViewController

@property (nonatomic, assign) GoodViewType goodViewType;

@property (nonatomic, strong) GoodsItem *goodItem;
@end
