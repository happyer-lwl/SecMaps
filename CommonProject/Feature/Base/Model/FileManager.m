//
//  FileManager.m
//  CommonProject
//
//  Created by WyzcWin on 16/11/3.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "FileManager.h"

#define kFileDirPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kFileName [kFileDirPath stringByAppendingPathComponent:@"CacheData"]

@implementation FileManager

+ (GoodsCacheData *)getCachedData{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:kFileName]) {
        GoodsCacheData *data = [NSKeyedUnarchiver unarchiveObjectWithFile:kFileName];
        return data;
    }else{
        return nil;
    }
}

+ (void)saveNewstData:(GoodsCacheData *)data{
    
    [NSKeyedArchiver archiveRootObject:data toFile:kFileName];
}

@end
