//
//  MAppHttp.m
//  MHTTPRequestTest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "MAppHttp.h"
#import "OpenUDID.h"
#import "NSString+JSONCategories.h"
#import "NSDate+Category.h"
#import "DefineString.h"
#import "NSString+category.h"

@implementation MAppHttpJson

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    return data;
}

@end

@interface MAppHttp()
{
    NSString *_uuid;
}

@end

@implementation MAppHttp


-(id) initIHttpRequestWithDelegate:(id<IHttpRequestDelegate>)targets
{
    self = [super initIHttpRequestWithDelegate:targets];
    if(self){
        _uuid = [[NSGlobal sharedMethod] uuid];
    }
    return self;
}

-(id) httpRequestAsynGet:(NSUInteger) type data:(NSDictionary *)dic
{
    NSString *m = [[HttpMethod sharedMethod] typeMethod:(HTTPTYPE)type];
    if(STRISEMPTY(m)){
        return nil;
    }
    
    NSMutableString *strurl;
    //首页模块化相关接口的URL地址都有所改变
    strurl = [NSMutableString stringWithFormat:@"%@%@%@",[Config defaultConfig].baseURL,m,[Config defaultConfig].baseType];
    if ([m containsString:@"Chip/"]) {
        NSRange range = [strurl rangeOfString:@"Index/"];
        NSString *str = [strurl substringToIndex:range.location];
        strurl = [NSMutableString stringWithFormat:@"%@%@%@",str,m,[Config defaultConfig].baseType];
        DLog( @"++++++%@",strurl);
    }
    
    if(dic){
        NSArray *arrkey = [dic allKeys];
        for (NSString *key in arrkey) {
            [strurl appendFormat:@"&%@=%@",key,[dic objectForKey:key]];
        }
    }
    if (!STRISEMPTY(_uuid)) {
        [strurl appendFormat:@"&%@=%@",@"deviceId",_uuid];
    }
    strurl = (NSMutableString *)[strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DLog(@"get消息c=%@,url=%@",m,strurl);
    __block __strong MAppHttp *bSelf = self;
    CGFloat startTime = [[NSDate date] timeIntervalSince1970];
    CGFloat waitSecond = 0.5;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] GET:strurl parameters:nil timeOut:TIMEOUT_Seconds success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CGFloat endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - startTime < waitSecond) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((waitSecond - (endTime - startTime)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [bSelf requestFinished:operation];
            });
        }
        else {
            [bSelf requestFinished:operation];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CGFloat endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - startTime < waitSecond) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((waitSecond - (endTime - startTime)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [bSelf requestFailed:operation];
            });
        }
        else {
            [bSelf requestFailed:operation];
        }
    }];
    operation.responseSerializer = [MAppHttpJson serializer];
    operation.tag = type;
    RequestID *rid = [RequestID requestIdWith:type object:operation andTag:_nextId++];
    [self addRequestId:rid];
    return rid;

    return nil;
}

-(id) httpRequestAsynPost:(NSUInteger) type data:(NSDictionary *)dic
{
    NSString *m = [[HttpMethod sharedMethod] typeMethod:(HTTPTYPE)type];
    if(STRISEMPTY(m)){
        return nil;
    }
    __block __weak __typeof(self)weakSelf = self;
    NSString *strurl;
    if ([m containsString:@"Chip/"]) {
        strurl = [NSString stringWithFormat:@"%@%@%@",[Config defaultConfig].baseURL,m,[Config defaultConfig].baseType];
    }else{
        //首页模块化相关接口的URL地址都有所改变
        strurl = [NSMutableString stringWithFormat:@"%@%@%@",[Config defaultConfig].baseURL,m,[Config defaultConfig].baseType];
        if ([m containsString:@"Chip/"]) {
            NSRange range = [strurl rangeOfString:@"Index/"];
            NSString *str = [strurl substringToIndex:range.location];
            strurl = [NSMutableString stringWithFormat:@"%@%@%@",str,m,[Config defaultConfig].baseType];
            DLog( @"++++++%@",strurl);
        }
//        strurl = [NSString stringWithFormat:@"%@%@%@%@",[Config defaultConfig].baseURL,@"Index/",m,[Config defaultConfig].baseType];
    }
    DLog(@"post消息c=%@,url=%@",m,strurl);
    CGFloat startTime = [[NSDate date] timeIntervalSince1970];
    CGFloat waitSecond = 0.5;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] POST:strurl parameters:nil timeOut:TIMEOUT_Seconds+15 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (dic) {
            NSArray *arr = [dic allKeys];
            for (NSString *key in arr) {
                id  value = [dic valueForKey:key];
                if ([value isKindOfClass:[NSData class]])
                {
                    if ([key hasPrefix:@"im"] || [key hasPrefix:@"img"] || [key hasPrefix:@"image"] || [key hasPrefix:@"original"] || [key hasPrefix:@"picture"] || [key hasPrefix:@"courseTitlePage"]||[key hasPrefix:@"photo"] || [key hasPrefix:@"logo"]||[key hasPrefix:@"idPhoto"]) {
                        [formData appendPartWithFileData:value name:key fileName:@"ap.png" mimeType:@"image/jpeg"];
                    }else{
                        [formData appendPartWithFileData:value name:key fileName:@"caf" mimeType:@"application/octet-stream"];
                    }
                }
                else
                {
                    [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding] name:key];
                }
            }
        }
        if (!STRISEMPTY(_uuid)) {
            [formData appendPartWithFormData:[_uuid dataUsingEncoding:NSUTF8StringEncoding] name:@"deviceId"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CGFloat endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - startTime < waitSecond) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((waitSecond - (endTime - startTime)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf requestFinished:operation];
            });
        }
        else {
            [weakSelf requestFinished:operation];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CGFloat endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - startTime < waitSecond) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((waitSecond - (endTime - startTime)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf requestFailed:operation];
            });
        }
        else {
            [weakSelf requestFailed:operation];
        }
    }];
    operation.responseSerializer = [MAppHttpJson serializer];
    operation.tag = type;
    RequestID *rid = [RequestID requestIdWith:type object:operation andTag:_nextId++];
    [self addRequestId:rid];
    return rid;
}

-(id) checkIsSuccess:(NSDictionary *)dic type:(NSUInteger)type
{
    if(dic==nil) {
        NSString *m = [[HttpMethod sharedMethod] typeMethod:(HTTPTYPE)type];
        NSString *code = [dic objectForKey:@"code"];
        NSString *str = [NSString stringWithFormat:@"%@ %@", m, code?code:@""];
        return [NSError errorWithDomain:str code:0 userInfo:dic];
    }
    NSNumber *code = [dic objectForKey:@"code"];
    if (code == nil) {
        NSString *m = [[HttpMethod sharedMethod] typeMethod:(HTTPTYPE)type];
        NSString *code = [dic objectForKey:@"code"];
        NSString *str = [NSString stringWithFormat:@"%@ %@", m, code?code:@""];
        return [NSError errorWithDomain:str code:0 userInfo:dic];
    }
    if (code.integerValue != 1000) {
        NSString *msg = [dic objectForKey:@"msg"];
        return [NSError errorWithDomain:msg code:code.integerValue userInfo:dic];
    }
    id data = [dic objectForKey:@"data"];
    if (data == nil) {
        NSString *m = [[HttpMethod sharedMethod] typeMethod:(HTTPTYPE)type];
        NSString *code = [dic objectForKey:@"code"];
        NSString *str = [NSString stringWithFormat:@"%@ %@", m, code?code:@""];
        return [NSError errorWithDomain:str code:0 userInfo:dic];
    }
    return nil;
}

- (id)getGlobalConfAction{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"" forKey:@"mid"];
    [dict setObject:@"" forKey:@"oauth_token"];
    [dict setObject:@"" forKey:@"oauth_token_secret"];
    
    return [self httpRequestAsynGet:Http_globalConfAction data:dict];
}

-(id) analyProtocol:(NSDictionary *)dic type:(NSUInteger)type
{
    @autoreleasepool {
        Class c = [[HttpMethod sharedMethod] typeClass:(HTTPTYPE)type];
        id obj = nil;
        if(c){
            switch (type) {
                case Http_globalConfAction:
                {
                    obj =  [[c alloc] initWithDictionary:dic];
                }
                    break;
                default:{
                    id data = [dic objectForKey:@"data"];
                    if (data != [NSNull null] && [data isKindOfClass:[NSDictionary class]]) {
                        obj =  [[c alloc] initWithDictionary:data];
                    }
                    break;
                }
                    break;
            }
        }
        if(obj)
        {
            return obj;
        }
        return dic;
    }
}


@end
