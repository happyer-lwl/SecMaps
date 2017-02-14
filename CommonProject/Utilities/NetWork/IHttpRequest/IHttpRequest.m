//
//  IHttpRequest.m
//  IHttpRequest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "IHttpRequest.h"
#import "DefineString.h"
#import "HttpInfo.h"
#import "GTMBase64.h"
#import "MAppHttp.h"
@interface IHttpRequest()
{
    NSMutableArray *_requestObjs;
    NSLock         *_reLock;
    dispatch_queue_t  _queue;
}

@end

@implementation IHttpRequest
#pragma maket request moneth

- (void)dealloc
{
    [self cancelAll];
    if(_queue){
        _queue=nil;
    }
}
-(void) addRequestId:(RequestID *) requestId
{
    [_reLock lock];
    [_requestObjs addObject:requestId];
    [_reLock unlock];
}


-(RequestID *) currentRequestId
{
    RequestID *rid = nil;
    [_reLock lock];
    if(_requestObjs.count > 0)
    {
        rid = [_requestObjs lastObject];
    }
    [_reLock unlock];
    return rid;
}

+(id) IhttpRequestWithDelegate:(id<IHttpRequestDelegate>) targets
{
    return [[[self class] alloc] initIHttpRequestWithDelegate:targets];
}

-(id) initIHttpRequestWithDelegate:(id<IHttpRequestDelegate>) targets
{
    self = [super init];
    if(self){
        _nextId = 0;
        _requestObjs = [[NSMutableArray alloc] init];
        _reLock = [[NSLock alloc] init];
        _delegate = targets;
    }
    return self;
}

-(void) cancel:(RequestID *) requestId
{
    if(requestId==nil) return;
    [_reLock lock];
    AFHTTPRequestOperation *afrequest = requestId.object;
    [afrequest setCompletionBlockWithSuccess:nil failure:nil];
    [afrequest cancel];
    [_requestObjs removeObject:requestId];
    [_reLock unlock];
}

-(RequestID *) fineRequestId:(AFHTTPRequestOperation *)request
{
    for (RequestID *rid in _requestObjs) {
        AFHTTPRequestOperation *asi = rid.object;
#if 1
        if([asi isEqual:request] || request.tag == rid.type){//if([asi isEqual:request] || asi.tag == rid.type){
            return rid;
        }
#endif
//        if (asi.tag == rid.type) {
//            return rid;
//        }
    }
    return nil;
}

-(void) cancelAll
{
    [_reLock lock];
    for (RequestID *rid in _requestObjs) {
        AFHTTPRequestOperation *afrequest = rid.object;
        [afrequest setCompletionBlockWithSuccess:nil failure:nil];
        [afrequest cancel];
    }
    _delegate = nil;
    [_requestObjs removeAllObjects];
    [_reLock unlock];
}

-(id) httpRequestAsynPost:(NSUInteger) type data:(NSDictionary *)dic
{
    return dic;
}

-(id) httpRequestAsynGet:(NSUInteger) type data:(NSDictionary *)dic
{
    return dic;
}

- (void)requestFinished:(AFHTTPRequestOperation *)requestObject
{
    if(_queue == nil){
        _queue = dispatch_queue_create("httpQueue", nil);
    }
    
    RequestID *rid = [self fineRequestId:requestObject];
    if (rid == nil) {
        return;
    }
    __block __strong  IHttpRequest *bself = self;
    dispatch_async(_queue, ^{
        [bself analysisResponse:requestObject requestId:rid];
    });
    [self cancel:rid];
}

- (void)requestFailed:(AFHTTPRequestOperation *)requestObject
{
    RequestID *rid = [self fineRequestId:requestObject];
    if(self.delegate && [self.delegate respondsToSelector:@selector(HttpFailedRequest:requestId:error:)]){
        NSError *error = [requestObject error];
        NSError *arr = [[NSError alloc] initWithDomain:NET_TIMEOUT code:error.code userInfo:nil];
        [self.delegate HttpFailedRequest:self requestId:rid error:arr];
    }
    [self cancel:rid];
}

- (void)requestStarted:(AFHTTPRequestOperation *)requestObject
{
    if(_delegate && [_delegate respondsToSelector:@selector(HttpStartRequest:requestId:)])
    {
        RequestID *rid = [self fineRequestId:requestObject];
        [_delegate HttpStartRequest:self requestId:rid];
    }
}

-(void) analysisResponse:(AFHTTPRequestOperation *)request requestId:(RequestID *)requestId
{
    //NSString *strValue = (requestId.type != Http_GetVirsionInfo)?[RSA decryptWithText:[request responseString]]:[request responseString];
    NSString *strValue = [RSA decryptWithText:[request responseString]];
    NSData* data = [strValue dataUsingEncoding:request.responseStringEncoding];
    //避免发生奔溃（张）
    if (!data) {
        data = [NSData data];
    }
    id dict = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
    DLog(@"接收消息[%@]---json = \n%@",[[HttpMethod sharedMethod] typeMethod:(HTTPTYPE)requestId.type],strValue);

    NSError *err = [self checkIsSuccess:dict type:requestId.type];
    if(nil == err){
        [self notifySuccess:[self analyProtocol:dict type:requestId.type] requestId:requestId];
    }else{
        [self notifyError:err requestId:requestId];
//        NSString *m = [[HttpMethod sharedMethod] typeMethod:(HTTPTYPE)requestId.type];
//        NSLog(@"method:%@", m);
    }
}
-(void) notifySuccess:(id) sucMsg requestId:(RequestID *)requestId
{
    __block __weak  IHttpRequest *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(HttpFinishRequest:requestId:msg:)]){
            [weakSelf.delegate HttpFinishRequest:weakSelf requestId:requestId msg:sucMsg];
        }
    });
}

-(void) notifyError:(NSError *) error requestId:(RequestID *)requestId
{
    __block __weak  IHttpRequest *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(HttpFailedRequest:requestId:error:)]){
            if(error.code==1 || error.code==2){
                NSError *arr = [[NSError alloc] initWithDomain:NET_TIMEOUT code:error.code userInfo:nil];
                [weakSelf.delegate HttpFailedRequest:weakSelf requestId:requestId error:arr];
            }else{
                [weakSelf.delegate HttpFailedRequest:weakSelf requestId:requestId error:error];
            }
        }
    });
}


-(id) analyProtocol:(NSDictionary *)dic type:(NSUInteger)type
{
    return dic;
}

-(id) checkIsSuccess:(NSDictionary *)dic type:(NSUInteger)type
{
    return [NSError errorWithDomain:@"" code:0 userInfo:nil];
}


@end
