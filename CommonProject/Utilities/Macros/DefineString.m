//
//  DefineString.m
//  MiniSales
//
//  Created by sunjun on 13-7-13.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "DefineString.h"

@implementation DefineString
-(void)asd{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GlobalConfigText" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray * textArray = [dict objectForKey:@"话"];
    if (!textArray || textArray.count >= [Config defaultConfig].siteType.integerValue) {
     [textArray objectAtIndex:[Config defaultConfig].siteType.integerValue];
    }else{
        
    }
}
@end

//开始订购页的字符串
