//
//  SULabel.h
//  wyzc
//
//  Created by qingshan on 15/4/21.
//  Copyright (c) 2015年 北京我赢科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SULabel : UILabel

-(void) startLoading;
-(void) stopLoading;
@end

@class SULabelActive;
typedef void(^TMCallback)(SULabelActive *label,long count);
@interface SULabelActive : UILabel
{
    TMCallback   _upCallback;
}
@property(nonatomic,assign) long maxTimes;  //倒计时最大的时间  单位秒
@property(nonatomic,assign) long tmCount;   //计时器运行了多少次
@property(nonatomic,assign) BOOL  isRuning;  //时间到便会停止
-(void) starting;
-(void) stop;
-(void) setTmcCallback:(TMCallback)callback;
@end
