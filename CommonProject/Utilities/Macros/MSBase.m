//
//  MSBase.m
//  MiniSales
//
//  Created by sunjun on 13-7-3.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "MSBase.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UIImage+load.h"
#import "FRDLivelyButton.h"

NSArray *defaultColorArr(void){
    NSArray *colorArr = @[UIColorFromRGB(0xFFFFFF),
                          UIColorFromRGB(0x9DBAB0),
                          UIColorFromRGB(0x9AAC95),
                          UIColorFromRGB(0xB9BA9D),
                          UIColorFromRGB(0xACA095),
                          UIColorFromRGB(0xC1A7B7),
                          UIColorFromRGB(0xB0B9C7),
                          UIColorFromRGB(0x9EA3BC),
                          UIColorFromRGB(0xADA0C0)];
    return colorArr;
}

BOOL strIsContainEmpty(NSString *str){
    if (!str) {
        return true;
    } else {
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

@interface MSBase ()<UIApplicationDelegate>

@end

@implementation MSBase

+(UIButton *) createButton:(CGRect) frame type:(UIButtonType)buttonType title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:buttonType];
    if(!STRISEMPTY(title)){
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.frame = frame;
    return button;
}

+(UILabel *)  createLabel:(CGRect) frame font:(UIFont *)font text:(NSString *)text defaultSizeTxt:(NSString *)sizeDefault color:(UIColor *)txtColor backgroundColor:(UIColor *)backgroundColor{
    CGRect lr = frame;
    CGSize fsize = CGSizeMake(0, 0);
    fsize = [sizeDefault sizeWithAttributes: @{NSFontAttributeName:font}];
    CGSize labelSize = (STRISEMPTY(sizeDefault))?frame.size:fsize;
    lr.size = labelSize;
    UILabel *label = [[UILabel alloc] initWithFrame:lr];
    label.font = font;
    label.textColor = txtColor;
    label.backgroundColor = backgroundColor;
  //  label.textAlignment = 0;
    [label setTextAlignment:NSTextAlignmentLeft];
    label.text = (STRISEMPTY(text))?@"":text;
    return label;
}

+(UIBarButtonItem *)MbackBarButtonItem:(id) taget action:(SEL)action title:(NSString *)title fname:(NSString *)fname fsname:(NSString *)fselname
{
    UIImage *image = [UIImage imageNamed:fname];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnHeight = 32;
    CGFloat btnWidth = 50;
    if (image) {
        btnWidth = image.size.width * btnHeight / image.size.height;
    }
    button.frame = CGRectMake(0, 0, btnWidth , btnHeight);
    //104  G：29  B：0
    if(!STRISEMPTY(title)){
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
        CGSize size = STR_FONT_SIZE(title, button.titleLabel.font);
        button.frame=CGRectMake(0, 0, size.width+20.f, size.height+10.f);
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
    }
    if(image){
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    UIImage *selImage = [UIImage imageNamed:fselname];
    if(selImage){
        [button setBackgroundImage:selImage forState:UIControlStateSelected];
        [button setBackgroundImage:selImage forState:UIControlStateHighlighted];
    }
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UIBarButtonItem *)createCustomBarButtonItem:(id)target action:(SEL)action title:(NSString *)title
{
    if (STRISEMPTY(title)) {
        return nil;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
    CGSize size = STR_FONT_SIZE(title, button.titleLabel.font);
    button.frame=CGRectMake(0, 0, size.width, size.height+10.f);
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIButton*)createPeopleButtonWithTitle:(NSString *)title color:(UIColor *)color
{
    UIButton *numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    numBtn.frame = CGRectMake(0, 0, 0, 15);
    numBtn.layer.cornerRadius = numBtn.height/2;
    numBtn.layer.borderColor = color.CGColor;
    numBtn.layer.borderWidth = 0.5f;
    UIImage *numImage = [UIImage imageNamed:@"number_white"];
    if ([color isEqual:[UIColor whiteColor]] == NO) {
        numImage = [UIImage imageNamed:@"number_gray"];
    }
    [numBtn setImage:numImage forState:UIControlStateNormal];
    NSString *numStr = [NSString stringWithFormat:@" %@人",title];
    [numBtn setTitle:numStr forState:UIControlStateNormal];
    [numBtn setTitleColor:color forState:UIControlStateNormal];
    numBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    CGSize size = [numStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    numBtn.width = size.width + numImage.size.width + 12;
    
    return numBtn;
}

+ (UIBarButtonItem *) backButton:(id) taget action:(SEL)action
{
    FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0, 0,22.f,28.f)];
    [button setStyle:kFRDLivelyButtonStyleCaretLeft animated:NO];
    [button setOptions:@{kFRDLivelyButtonLineWidth:@(1.50f),kFRDLivelyButtonHighlightedColor:[UIColor whiteColor],kFRDLivelyButtonColor:[UIColor whiteColor]}];
    
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *) closeButton:(id) taget action:(SEL)action TintColor:(UIColor *)tintColor backImg:(UIImage *)image{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 28, 28);
    button.tintColor = tintColor ? tintColor : [UIColor whiteColor];
    if (image) {
        button.frame = CGRectMake(0, 0, 28, 28);
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }else{
        image = [[UIImage imageNamed:@"closePage"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setImage:image forState:UIControlStateSelected];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UINavigationController *) crateNavigateionControler:(UIViewController *)rootController navBackgroundImage:(UIImage *)bgImage
{
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:rootController];
    CGSize size  = nav.navigationBar.frame.size;
    if (IS_IOS7) {
        size.height += ([[UIApplication sharedApplication] statusBarFrame].size.height);
    }
    
    nav.navigationBar.barStyle = UIBarStyleBlack;
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [dict setObject:[UIColor lightGrayColor] forKey:NSForegroundColorAttributeName];
    
    if(!IS_IOS7){
        [nav.navigationBar setTintColor:[UIColor whiteColor]];
    }else{
        [nav.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
    [dict setObject:[UIFont systemFontOfSize:NavigationTitleFontSize] forKey:NSFontAttributeName];
    nav.navigationBar.titleTextAttributes = dict;
    [nav.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    return nav;
}

+(void) alertMessage:(NSString*)msg cb:(ALertCompletion) completion
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *win = app.window;
    MBProgressHUD *HUD = (MBProgressHUD *)[win viewWithTag:8012];
    if(HUD==nil){
        HUD =  [[MBProgressHUD alloc] initWithView:win];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        HUD.tag = 8012;
        HUD.mode = MBProgressHUDModeCustomView;
        [win addSubview:HUD];
        HUD.removeFromSuperViewOnHide = YES;
    }
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD setAfterCallBack:^(MBProgressHUD *huself) {
        if(completion){
            completion(YES);
        }
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUD hide:YES afterDelay:1.5f];
    });
    
}

+(void) alertMessage:(NSString*)msg view:(UIView *)view cb:(ALertCompletion) completion
{
    if (!view) {
        return;
    }
    MBProgressHUD *HUD;
    if(HUD==nil){
        HUD =  [[MBProgressHUD alloc] initWithView:view];
        //HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        HUD.mode = MBProgressHUDModeCustomView;
        [view addSubview:HUD];
        HUD.removeFromSuperViewOnHide = YES;
    }
    HUD.labelText = msg;
    [HUD show:YES];
    [HUD setAfterCallBack:^(MBProgressHUD *huself) {
        if(completion){
            completion(YES);
        }
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUD hide:YES afterDelay:2.0f];
    });
}


+(void) setShouldUpdateNetworkActivityIndicator:(BOOL) activity
{
#if TARGET_OS_IPHONE
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:activity];
#endif
}

+(void) baiduEventPost
{
#if BAIDU_MobStat
    NSString *sysString = [NSString stringWithFormat:@"%@ - %@",[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] systemVersion]];
    NSString *deviceName = @"OtherDevice";
    switch (DeviceResoultion) {
        case UIDevice_iPhoneStandardRes:
            deviceName = @"iPhoneStandardRes";
            break;
        case UIDevice_iPhoneHiRes:
            deviceName = @"iPhoneHiRes";
            break;
        case UIDevice_iPhoneTallerHiRes:
            deviceName = @"iPhoneTallerHiRes";
            break;
        case UIDevice_iPadHiRes:
            deviceName = @"iPadHiRes";
            break;
        case UIDevice_iPadStandardRes:
            deviceName = @"iPadStandardRes";
            break;
        default:
            break;
    }
    
    [[BaiduMobStat defaultStat] logEvent:@"device_type" eventLabel:deviceName];
    [[BaiduMobStat defaultStat] logEvent:@"system_version" eventLabel:sysString];
#endif
}

+ (void)hideKeyBoard
{
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        for (UIView* view in window.subviews)
        {
            [self dismissAllKeyBoardInView:view];
        }
    }
}

+(BOOL) dismissAllKeyBoardInView:(UIView *)view
{
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoardInView:subView])
        {
            return YES;
        }
    }
    return NO;
}
+(UIView *)createTableViewSeparatorLion: (CGPoint)position{
    UIView * seplion = [[UIView alloc]initWithFrame:CGRectMake(position.x, position.y, SCreenWidth-position.x, 0.5f)];
    seplion.backgroundColor = CellLine_Color;
    return seplion;
}

@end

CGSize getViewSize(BOOL isHindTabBar)
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGSize result = CGSizeMake(screen.size.width, screen.size.height-20.f-49.f);
    CGFloat Height = result.height;
    if(!isHindTabBar){
        Height = screen.size.height-TABBAR_HEIGHT-STATUSBAR_HEIGHT;
    }else{
        Height =  screen.size.height-STATUSBAR_HEIGHT;
    }
    result.height = Height;
    return result;
}

SMAlerView * SMAlert(NSString* message,NSString *title,NSString *buttonTitle1,NSString *buttonTitle2,id<SMAlerViewDelegate>target)
{
    UIAlertView* alert = nil;
    if(!STRISEMPTY(message)){
        alert  = [[UIAlertView alloc] initWithTitle:title                                                         message:message delegate:target cancelButtonTitle:buttonTitle1 otherButtonTitles:buttonTitle2,nil];
        [alert show];
    }
    return alert;
}


UINavigationController *createNavgationController(UIViewController *rootV)
{
    return nil;
}


