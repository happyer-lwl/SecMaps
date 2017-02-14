//
//  IHttpRequest.h
//  IHttpRequest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestID.h"
#import "NSString+JSONCategories.h"
#import "RequestID.h"
#import "AFNetworking.h"
#import "RSA.h"
@protocol IHttpRequestDelegate;
@interface IHttpRequest : NSObject
{
    NSInteger   _nextId;
}

@property(nonatomic,strong) NSDictionary *userInfo;
@property(nonatomic,weak) id<IHttpRequestDelegate> delegate;;

-(RequestID *) fineRequestId:(AFHTTPRequestOperation *)request;
-(void) analysisResponse:(AFHTTPRequestOperation *)request requestId:(RequestID *)requestId;
-(void) notifySuccess:(id) sucMsg requestId:(RequestID *)requestId;
-(void) notifyError:(NSError *) error requestId:(RequestID *)requestId;

+(id) IhttpRequestWithDelegate:(id<IHttpRequestDelegate>) targets;
-(id) initIHttpRequestWithDelegate:(id<IHttpRequestDelegate>) targets;
-(void) cancel:(RequestID *) requestId;
-(void) cancelAll;
-(void) addRequestId:(RequestID *) requestId;
-(RequestID *) currentRequestId;
-(id) analyProtocol:(NSDictionary *)dic type:(NSUInteger)type;
-(id) checkIsSuccess:(NSDictionary *)dic type:(NSUInteger)type;
-(id) httpRequestAsynPost:(NSUInteger) type data:(NSDictionary *)dic;
-(id) httpRequestAsynGet:(NSUInteger) type data:(NSDictionary *)dic;


- (void)requestFinished:(AFHTTPRequestOperation *)requestObject;
- (void)requestFailed:(AFHTTPRequestOperation *)requestObject;
@end


@protocol IHttpRequestDelegate <NSObject>
@optional
@required
- (void)HttpFinishRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId msg:(id)sucMsg;
- (void)HttpFailedRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId error:(NSError *)error;
@optional
- (void)HttpStartRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId;


@end
