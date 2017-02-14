//
//  FileManager.h
//  CommonProject
//
//  Created by WyzcWin on 16/11/3.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (GoodsCacheData *)getCachedData;
+ (void)saveNewstData:(GoodsCacheData *)data;

@end
