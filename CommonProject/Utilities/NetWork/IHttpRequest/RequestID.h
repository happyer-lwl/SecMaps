//
//  RequestID.h
//  httpTest
//
//  Created by sunjun on 13-6-10.
//  Copyright (c) 2013年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RequestID : NSObject
@property(nonatomic,assign,readonly) NSUInteger type;
@property(nonatomic,strong,readonly) id object;
@property(nonatomic,strong,readonly) NSNumber *idTag;
@property(nonatomic,strong) id userInfo;
+(id) requestIdWith:(NSUInteger) type object:(id) object andTag:(NSUInteger) atag;
@end

