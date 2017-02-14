//
//  MAppHttp.h
//  MHTTPRequestTest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IHttpRequest.h"
#import "MSBase.h"
#import "HttpInfo.h"

#define TIMEOUT_Seconds  35.f

/*
 2001 => '请重新登录',
 2002 => '方法%s不存在',
 2003 => '缺少参数deviceId',
 2004 => '已经在另一设备上登录了',
 2005 => '非法课程类别',
 */

@interface MAppHttpJson : AFHTTPResponseSerializer

@end


@interface MAppHttp : IHttpRequest

-(id) getGlobalConfAction;  //获取首页配置

@end

