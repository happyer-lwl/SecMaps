//
//  BPBaseViewController.m
//  BaseProject
//
//  Created by WyzcWin on 16/10/26.
//  Copyright © 2016年 runlwl. All rights reserved.
//

#import "BPBaseViewController.h"

@interface BPBaseViewController ()<UIGestureRecognizerDelegate>{
    NSString  *_contentText;
    UIImage  *_sharedImage;
    SMAlerView *_payAlertView;
}

@end

@implementation BPBaseViewController

- (void)dealloc
{
    [_http cancelAll];
    [[SDImageCache sharedImageCache] clearMemory];
    
    DLog(@"dealloc [%@]",NSStringFromClass([self class]));
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isPush = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
    [self httpInit];
    _ypos = 0;
    self.view.backgroundColor = CommonBackgroundColor;
    
    // StatusBar
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // Nav
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor whiteColor],[UIFont systemFontOfSize:18.0f], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:91.0 / 255.0f green:174.0 / 255.0f blue:245.0 / 255.0f alpha:1.0]];
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:91.0 / 255.0f green:174.0 / 255.0f blue:245.0 / 255.0f alpha:1.0].CGColor);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UINavigationBar appearance] setBackgroundImage:theImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    if (iOS7) {
        self.navigationController.navigationBar.translucent = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    CGFloat h = self.view.frame.size.height;
    if(self.navigationController &&
       self.navigationController.viewControllers.count > 1){
        CGRect viewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        h = self.view.frame.size.height- self.navigationController.navigationBar.frame.size.height;
        if (IS_IOS7) {
            h -= [[UIApplication  sharedApplication] statusBarFrame].size.height;
        }
        viewFrame.size = CGSizeMake(self.view.frame.size.width,h);
        self.view.frame = viewFrame;
        self.navigationItem.leftBarButtonItem = BLACKBAR_BUTTON;
    }
    [self loadAllView];
    [self performSelector:@selector(afterProFun) withObject:nil afterDelay:0.3];
}

-(void) loadAllView{}
-(void) afterProFun{}

-(void) viewDidAppear:(BOOL)animated
{
#if BAIDU_MobStat
    [[BaiduMobStat defaultStat] pageviewStartWithName:NSStringFromClass([self class])];
#endif
}

//http://www.itools.cn
-(void) viewWillDisappear:(BOOL)animated
{
#if BAIDU_MobStat
    [[BaiduMobStat defaultStat] pageviewEndWithName:NSStringFromClass([self class])];
#endif
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - 打开app store
-(void) toAppstore
{
    NSString *appid = [NSGlobal sharedMethod].appId;
    NSString * url = [NSGlobal sharedMethod].url;
    if ([url hasPrefix:@"itms-services:"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        NSRange range = [url rangeOfString:@"/id"];
        if (range.location != NSNotFound) {
            appid = [url substringWithRange:NSMakeRange(range.location + range.length, 10)];
            [NSGlobal sharedMethod].appId = appid;
            NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@",appid];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else {
            return;
        }
    }
}
-(void) willBack{
    
}

//检查版本更新
-(void) checkVersion
{
    NSString *type = @"2";
    if(DeviceResoultion == UIDevice_iPadStandardRes || DeviceResoultion == UIDevice_iPadHiRes){
        type = @"1";
    }
//    [_http reuest_checkUpdate:type];
    
}

//处理更新结果
//-(void) proVersion:(DCheckUpdagte *)dupdate
//{
//    if (dupdate &&[dupdate isKindOfClass:[DCheckUpdagte class]] && !STRISEMPTY(dupdate.appId)) {
//        [NSGlobal sharedMethod].appId =  dupdate.appId;
//        [NSGlobal sharedMethod].url = dupdate.url;
//    }
//    if (![dupdate isKindOfClass:[DCheckUpdagte class]]) {
//        return;
//    }
//    
//    BOOL flag = [self needUpdateVersion:dupdate.version];
//    if (!flag) {
//        if (![self isKindOfClass:[ModuleHomeViewController class]]) {
//            [MSBase alertMessage:@"已是最新版本" cb:nil];
//        }
////        [self checkCancel:dupdate];
//    }
//    else
//    {
//        if (!_alarmMessage) {
//            _alarmMessage = [[SUAlarmMessage alloc] init];
//        }
//        __block __weak typeof(self) bself = self;
//        [_alarmMessage showAlarm:@"更新提示" msg:STRISEMPTY(dupdate.function)?@"发现新版本":dupdate.function  cancelButtonTitle:@"取消" otherButtonTitle:@"更新" callBack:^(int buttonIndex) {
//            if (buttonIndex == 1) {
//                [bself toAppstore];
//                if ([dupdate.isForceUpdate isEqualToString:@"1"]) {
//                    exit(0);
//                }
//            }else{
//                if ([dupdate.isForceUpdate isEqualToString:@"1"]) {
//                    exit(0);
//                }else{
//                    [bself checkCancel:dupdate];
//                }
//            }
//        }];
//    }
//}

-(NSInteger)toInteger:(NSString *)str
{
    NSInteger result = 0;
    NSInteger versionLength = 4;//代表支持的最多分割位数
    NSMutableArray *strArray = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"."]];
    NSInteger count = strArray.count;
    for (int i = 0; i < versionLength - count; i++) {
        [strArray addObject:@"0"];
    }
    for (int i = 0; i < strArray.count; i++) {
        NSInteger num = [[strArray objectAtIndex:i] integerValue];
        num *= [self getNumber:strArray.count-i-1];
        result += num;
    }
    return result;
}

-(NSInteger)getNumber:(NSInteger)length
{
    NSInteger result = 1;
    for (int i = 0; i < length; i++) {
        result *= 10;
    }
    return result;
}

//如果当前版本小于系统返回版本，则需要提示升级
-(BOOL)needUpdateVersion:(NSString *)nowVersion
{
    NSInteger clientV = [self toInteger:APP_VERSION];
    NSInteger systemV = [self toInteger:nowVersion];
    if (clientV < systemV) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
//    [[XHCacheManager shareCacheManager] removeCacheDirectory]; ??
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
//    if ([self isKindOfClass:[ChatWebViewController class]]) {
//        return  UIInterfaceOrientationMaskAll;
//    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    if ([self isKindOfClass:[ChatWebViewController class]]) {
//        return  UIInterfaceOrientationPortrait |
//        UIInterfaceOrientationLandscapeLeft |
//        UIInterfaceOrientationLandscapeRight;
//    }
    return UIInterfaceOrientationPortrait;
}

-(void) backAction:(id)sender{
    
    [_http cancelAll];
    [self willBack];
    _payErrorAlertView = nil;
    if(_isPush){
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(MAppHttp *) getHttpObject{
    return _http;
}

-(void) httpInit
{
    _http = [[MAppHttp alloc] initIHttpRequestWithDelegate:self];
}

-(void) hudShow:(UIView *)inView msg:(NSString *)msgText
{
    
    if(!_mbProgressHud){
        _mbProgressHud = [[MBProgressHUD alloc] initWithView:inView];
        CGSize imageSize = [UIImage imageNamed:@"1_00000"].size;
        UIImageView * _statusimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageSize.width/2, imageSize.height/2)];
        //这两行代码不能颠倒
        _mbProgressHud.customView = _statusimageView;
        _mbProgressHud.mode = MBProgressHUDModeCustomView;
        NSMutableArray * imagesArray=[NSMutableArray array];
        for(int i=0;i<=39;i++)
        {
            UIImage * image=[UIImage imageNamed:[NSString stringWithFormat:@"1_000%02d",i]];
            [imagesArray addObject:image];
        }
        _statusimageView.animationImages=imagesArray;
        [_statusimageView startAnimating];
        if(msgText && msgText.length > 0){
            [_mbProgressHud setLabelText:msgText];
        }
        _mbProgressHud.isChangeBackgroud = YES;
        [inView addSubview:_mbProgressHud];
    }
    [_mbProgressHud show:YES];
}

-(void) hudClose
{
    if(_mbProgressHud){
        [_mbProgressHud removeFromSuperview];
        [_mbProgressHud hide:NO];
        _mbProgressHud = nil;
    }
}

-(void) http_finishRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId msg:(id)sucMsg
{
    
}
- (void)http_failedRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId error:(NSError *)error
{
    
}
- (void)http_startRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId{}


#pragma mark -
#pragma mark MApphtt delegate
- (void)HttpFinishRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId msg:(id)sucMsg
{
    // 下面的几种网络请求，成功回调后还要请求，所以不能关闭HUD，其他类型都需要关闭HUD
    if (requestId.type != Http_globalConfAction) {
        
        [self hudClose];
    }
    [self http_finishRequest:requestObject requestId:requestId msg:sucMsg];
}

- (void)HttpFailedRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId error:(NSError *)error
{
    [self hudClose];
    // 错误监听，暂时注释
    if(requestId.type != HTTP_BEGIN)
    {
        if (error.code != 2004 && error.code != 2001) {
            [MSBase alertMessage:error.domain cb:nil];
        }
    }

//    if (error && error.code == 2001) {
//        //退出当前账号的通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:exit_current_user object:nil];
//        [LocalLoginViewController OpenLogin:self callback:^(BOOL compliont) {
//            if (_loginCallback) {
//                _loginCallback(compliont);
//            }
//            [self.view layoutIfNeeded];
//        }];
//    }
//    if (error && error.code == 2004) {
//        //账号在另一台设备登录
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:exit_current_user object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:Other_Device_Login object:nil];
//        if (!_alarmMessage) {
//            _alarmMessage = [[SUAlarmMessage alloc] init];
//        }
//        [_alarmMessage showAlarm:nil msg:@"您的账号在另一台设备登录。如非本人操作，则密码可能已泄漏，建议请重新登录修改密码。" cancelButtonTitle:@"退出" otherButtonTitle:@"重新登录" callBack:^(int buttonIndex) {
//            if (buttonIndex == 0) {
//                //退出登录
//                //                [[NSNotificationCenter defaultCenter] postNotificationName:exit_current_user object:nil];
//            }
//            if (buttonIndex == 1) {
//                //重新登录
//                [LocalLoginViewController OpenLogin:self callback:^(BOOL compliont) {
//                    if (_loginCallback) {
//                        _loginCallback(compliont);
//                    }
//                    [self.view layoutIfNeeded];
//                }];
//            }
//        }];
//    }
    [self http_failedRequest:requestObject requestId:requestId error:error];
}

- (void)HttpStartRequest:(IHttpRequest *)requestObject requestId:(RequestID *) requestId
{
    [self http_startRequest:requestObject requestId:requestId];
}

- (UIView*)createEmptyFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCreenWidth, 1)];
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCreenWidth, 50)];
    desc.text = @"没有更多数据了";
    desc.textAlignment = NSTextAlignmentCenter;
    desc.font = [UIFont systemFontOfSize:14];
    desc.textColor = DescTextColor;
    desc.backgroundColor = [UIColor clearColor];
    [view addSubview:desc];
    return view;
}

- (void)creatAllLable:(CGRect )frame addView:(UIView *)view
{
    UILabel *allLable = [[UILabel alloc] initWithFrame:frame];
    allLable.font = [UIFont systemFontOfSize:10.0f];
    allLable.text = @"查看全部";
    allLable.textAlignment = NSTextAlignmentRight;
    allLable.textColor = MainSectionTitleColor;
    [view addSubview:allLable];
}

//导航条左边按钮
- (void)setLeftBarButtonItemWithString:(NSString *)title imageName:(NSString *)imageName target:(id)object action:(SEL)action
{
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
    //  CGSize size = [UIImage imageNamed:imageName].size; //根据image大小设置frame
    [leftBut setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftBut setFrame:CGRectMake(0, 0, 30, 30)];
    [leftBut setTitle:title forState:UIControlStateNormal];
    [leftBut.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [leftBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBut addTarget:object action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBut];
}

//导航条右边按钮
- (void)setRightBarbuttonItemWithString:(NSString *)title imageNage:(NSString *)imageName target:(id)object action:(SEL)action
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // CGSize size = [UIImage imageNamed:imageName].size;
    //    [rightBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 35, 35)];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [rightBtn addTarget:object action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

@end
