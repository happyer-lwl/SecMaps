//
//  SUAutoLabel.h
//  wyzc
//
//  Created by sunjun on 14-9-5.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SUAutoLabel;
typedef void(^RunCallback)(SUAutoLabel *object,NSUInteger cnt);

@interface SUAutoLabel : UILabel
@property(nonatomic,copy) RunCallback  runCallback;

-(void) start:(NSTimeInterval)ti;
-(void) stop;
@end
