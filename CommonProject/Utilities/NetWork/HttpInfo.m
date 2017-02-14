//
//  HttpInfo.m
//  GFMusic
//
//  Created by jiayitang on 13-10-10.
//  Copyright (c) 2013年 jiayitang. All rights reserved.
//

#import "HttpInfo.h"
//#define STRISEMPTY(str) (str==nil || [cn isEqualToString:@""])

#define http_info(c,m,t)  [[HttpInfo alloc] initWithInfo:c method:m type:t]
#define httpinfo_if(c,m,t) if(type==t){info = http_info(c,m,t);}
#define httpinfo_ele_if(c,m,t) else if(type==t){info = http_info(c,m,t);}
//case t:info = http_info(c,m,t);break;
//[[HttpInfo alloc] initWithInfo:@"DJobList" method:@"getDirection" type:type];


@implementation HttpInfo
-(id) initWithInfo:(NSString *)cn method:(NSString *)method type:(HTTPTYPE)htype;
{
    self = [super init];
    if (self) {
        self.className = STRISEMPTY(cn)?nil:cn;
        self.httpMethod = STRISEMPTY(method)?nil:method;
        self.httpType = (htype==HTTP_BEGIN)?[NSNumber numberWithInteger:HTTP_BEGIN]:[NSNumber numberWithInteger:htype];
    }
    return self;
}
-(NSString *) dicKey
{
    return [NSString stringWithFormat:@"khttp%@",self.httpType];
}
@end

@interface HttpMethod()
@property(nonatomic,strong) NSMutableDictionary *dicInfos;
@end

@implementation HttpMethod

+(HttpMethod *) sharedMethod
{
    static HttpMethod *g_httinf = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_httinf = [[HttpMethod alloc] init];
    });
    return g_httinf;
}


- (id)init
{
    self = [super init];
    if (self) {
        self.dicInfos = [[NSMutableDictionary alloc] init];
        for (HTTPTYPE type = Http_globalConfAction; type < HTTPTYPE_END; type++) {
            HttpInfo *info = nil;
            httpinfo_if(@"GlobalConfigData", @"Chip/globalConfAction", Http_globalConfAction);
            if(info){
                NSString *key = [info dicKey];
                NSDictionary *dic = [info toDictionary];
                [self.dicInfos setObject:dic forKey:key];
            }
        }
    }
    return self;
}


-(Class) typeClass:(HTTPTYPE )type
{
    NSString *key = [NSString stringWithFormat:@"khttp%d",type];
    NSDictionary *dic = [self.dicInfos objectForKey:key];
    if(dic){
        HttpInfo *info = [[HttpInfo alloc] initWithDictionary:dic];
        return NSClassFromString(info.className);
    }
    return nil;
}
-(NSString *)typeMethod:(HTTPTYPE)type
{
    NSString *key = [NSString stringWithFormat:@"khttp%d",type];
    NSDictionary *dic = [self.dicInfos objectForKey:key];
    if(dic){
        HttpInfo *info = [[HttpInfo alloc] initWithDictionary:dic];
        return info.httpMethod;
    }
    return nil;
}

@end
