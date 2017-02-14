//
//  BPDBManager.m
//  CommonProject
//
//  Created by WyzcWin on 16/10/27.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "BPDBManager.h"
#import "FMDB.h"

#define dbPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define dbFile [dbPath stringByAppendingPathComponent:@"goods.sqlite"]

@interface BPDBManager(){
    FMDatabase *_db;
}

@end

@implementation BPDBManager

static BPDBManager *dbManager = nil;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[BPDBManager alloc] init];
    });
    
    return dbManager;
}

-(BOOL)initDb{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFile]) {
        
        _db = [FMDatabase databaseWithPath:dbFile];
        if ([_db open]) {
            NSString * sql = @"CREATE TABLE 'Goods' ('goodId' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'title' VARCHAR(30), 'goodCover' VARCHAR(50), 'status' VARCHAR(50), 'time' VARCHAR(50), 'position' VARCHAR(50), 'price' VARCHAR(50))";
            BOOL res = [_db executeUpdate:sql];
            if (!res) {
                DLog(@"error when creating db table");
            } else {
                DLog(@"succ to creating db table");
            }
            [_db close];
            return YES;
        }else{
            return NO;
        }
    }
    
    return YES;
}

- (void)insertGoodItem:(GoodsItem *)item{
    
    _db = [FMDatabase databaseWithPath:dbFile];
    if ([_db open]) {
    
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO Goods ('title', 'goodCover', 'status', 'time', 'position', 'price') VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", item.title, item.goodCover, item.status, item.time, item.position, item.price];
        
        [_db executeUpdate:sql];
        [_db close];
    }
}

- (void)updateGoodItem:(GoodsItem *)item{
    
    _db = [FMDatabase databaseWithPath:dbFile];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE Goods SET 'title' = '%@', 'goodCover' = '%@', 'status' = '%@', 'time' = '%@', 'position' = '%@', 'price' = '%@' where goodId = '%@'", item.title, item.goodCover, item.status, item.time, item.position, item.price, item.goodId];
        [_db executeUpdate:sql];
        [_db close];
    }
}

- (void)deleteGoodItem:(GoodsItem *)item{
    
    _db = [FMDatabase databaseWithPath:dbFile];
    if ([_db open]) {
        
        [_db executeUpdate:@"DELETE Goods where 'goodId' = ?", item.goodId];
        [_db close];
    }
}

- (NSArray *)queryGoodItems{
    
    NSMutableArray *data = [NSMutableArray array];
    
    _db = [FMDatabase databaseWithPath:dbFile];
    if ([_db open]){
        
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM Goods ORDER BY 'goodId' DESC"];
        FMResultSet * rs = [_db executeQuery:sql];
        while ([rs next]) {
            GoodsItem *item = [GoodsItem new];
            item.goodId = [NSString stringWithFormat:@"%d", [rs intForColumn:@"goodId"]];
            
            item.title = [rs stringForColumn:@"title"];
            item.goodCover = [rs stringForColumn:@"goodCover"];
            item.status = [rs stringForColumn:@"status"];
            item.time = [rs stringForColumn:@"time"];
            item.position = [rs stringForColumn:@"position"];
            item.price = [rs stringForColumn:@"price"];
            
            [data addObject:item];
        }
        [_db close];
    }
    
    return data;
}
@end
