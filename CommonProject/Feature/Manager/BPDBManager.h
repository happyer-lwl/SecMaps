//
//  BPDBManager.h
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPDBManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)initDb;

- (void)insertGoodItem:(GoodsItem *)item;

- (void)updateGoodItem:(GoodsItem *)item;

- (void)deleteGoodItem:(GoodsItem *)item;

- (NSArray *)queryGoodItems;
@end
