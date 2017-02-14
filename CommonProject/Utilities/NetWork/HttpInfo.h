//
//  HttpInfo.h
//  GFMusic
//
//  Created by jiayitang on 13-10-10.
//  Copyright (c) 2013年 jiayitang. All rights reserved.
//

#import "Jastor.h"

typedef enum {
    HTTP_BEGIN = -1,
    Http_globalConfAction,  //获取首页配置
    HTTPTYPE_END,
    
}HTTPTYPE;


@interface HttpInfo : Jastor
@property(nonatomic,strong) NSString *className;
@property(nonatomic,strong) NSString *httpMethod;
@property(nonatomic,strong) NSNumber *httpType;
-(id) initWithInfo:(NSString *)cn method:(NSString *)method type:(HTTPTYPE)htype;
@end

@interface HttpMethod : NSObject
+(HttpMethod *) sharedMethod;
-(Class) typeClass:(HTTPTYPE )type;
-(NSString *)typeMethod:(HTTPTYPE)type;
@end
