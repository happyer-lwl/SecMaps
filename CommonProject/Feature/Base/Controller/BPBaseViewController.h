//
//  BPBaseViewController.h
//  BaseProject
//
//  Created by WyzcWin on 16/10/26.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSBase.h"
#import "MBProgressHUD.h"
#import "MAppHttp.h"
#import "UIImageView+WebCache.h"
#import "DataCenter.h"
//#import "UIViewController+MFSideMenuAdditions.h"
//#import "MFSideMenuContainerViewController.h"
#import "SUAlarmMessage.h"
#import "SUEmptyView.h"
#if BAIDU_MobStat
#import "BaiduMobStat.h"
#endif
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "BPTabBarController.h"
#import "UIControl+AcceptEventInterval.h"

@interface BPBaseViewController : UIViewController<IHttpRequestDelegate>{
    MBProgressHUD   *_mbProgressHud;
    MAppHttp        *_http;
    SMAlerView *_payErrorAlertView;
    SUAlarmMessage  *_alarmMessage;
    NSString   *_orderString;
}

//@property(nonatomic,strong) LoginCallback loginCallback;//登录回调
@property(nonatomic,assign)  BOOL   isPush;  //是否push 进来的
@property(nonatomic,assign)  NSUInteger shareType;
@property(nonatomic,assign)  CGFloat ypos;
@property(nonatomic,strong) id prvData;
@property (nonatomic, strong) MBProgressHUD *mbProgressHud;
-(void) hudShow:(UIView *)inView msg:(NSString *)msgText;
-(void) hudClose;
-(void) backAction:(id)sender;
-(void) httpInit;
-(MAppHttp *) getHttpObject;

-(void) loadAllView;
-(void) afterProFun; //加载完后 延迟调用
-(void) toAppstore;
-(void) willBack;
//检查版本更新
-(void) checkVersion;

//http 的3个通知
-(void) http_finishRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId msg:(id)sucMsg;
- (void)http_failedRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId error:(NSError *)error;
- (void)http_startRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId;

/**
 *  创建没有更多翻页数据View
 *
 *  @return UIView
 */
- (UIView*)createEmptyFooterView;
- (void)creatAllLable:(CGRect )frame addView:(UIView *)view; // 在向右的剪头出添加全部

- (void)setLeftBarButtonItemWithString:(NSString *)title imageName:(NSString *)imageName target:(id)object action:(SEL)action;//导航条左边按钮
- (void)setRightBarbuttonItemWithString:(NSString *)title imageNage:(NSString *)imageName target:(id)object action:(SEL)action;//导航条右边按钮

@end
