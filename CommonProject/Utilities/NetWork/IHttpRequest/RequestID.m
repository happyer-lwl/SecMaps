//
//  RequestID.m
//  httpTest
//
//  Created by sunjun on 13-6-10.
//  Copyright (c) 2013年 sun. All rights reserved.
//

#import "RequestID.h"

@interface RequestID()
{
}

-(id) initRequestId:(NSUInteger) type object:(id) object andTag:(NSUInteger) atag;

@end
@implementation RequestID

-(id) initRequestId:(NSUInteger) atype object:(id) aobject andTag:(NSUInteger) atag
{
    self = [super init];
    if(self){
        _idTag = [NSNumber numberWithUnsignedInteger:atag];
        _object = aobject;
        _type = atype;
    }
    return self;
}

+(id) requestIdWith:(NSUInteger) type object:(id) object andTag:(NSUInteger) atag
{
    return [[[self class] alloc] initRequestId:type object:object andTag:atag];
}

-(BOOL) isEqual:(RequestID *)theObject
{
    return (self == theObject)||([theObject.idTag isEqual:self.idTag] && theObject.object==self.object && theObject.type == self.type);
}
@end

