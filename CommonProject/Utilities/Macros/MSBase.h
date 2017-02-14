//
//  MSBase.h
//  MiniSales
//
//  Created by sunjun on 13-7-3.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

/**
 *  公用的一些方法
 *
 *
 */

#import <Foundation/Foundation.h>
#import "DefineString.h"

// 沙盒Cache目录，缓存用
#define kCachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#if TARGET_IPHONE_SIMULATOR
#else// if TARGET_OS_IPHONE
#endif

#ifdef DEBUG
#  define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#   define APP_ID   @""
#endif

#define APP_DidBecomeActive  @"APP_DidBecomeActive"
#define Document_path [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define Create_docmentPath(path) {\
    NSString *documentsDirectory = Document_path;\
    NSFileManager *fileManager = [NSFileManager defaultManager];\
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:path];\
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];\
}
#define STR_FONT_SIZE(str,font) [str sizeWithAttributes: @{NSFontAttributeName:font}]

#define CELL_ADD_SUBVIEW(tager,sub_view) (IS_IOS7)?[tager.contentView addSubview:sub_view]:[tager addSubview:sub_view]

static const CGFloat g_menuWidth = 270;

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define SegmentColor UIColorFromRGB(0xd0f0ff)

#define CUSTOMBACKGROUNDCORLOR  UIColorFromRGB(0xeeeeee)
#define CUSTOMBLUECORLOR        UIColorFromRGB(0x008ac9)
#define CUSTOMGRAYTEXTCORLOR    UIColorFromRGB(0xababab)

#define SELECT_NOTTEXT_COLOR  [UIColor colorWithRed:0x52/255.0 green:0x52/255.0 blue:0x52/255.0 alpha:1.0]
#define SELECT_TEXT_COLOR   [UIColor colorWithRed:0x00/255.0 green:0xcc/255.0 blue:0xff/255.0 alpha:1.0]
#define ColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define NAVIGATION_TITLECOLOR UIColorFromRGB(0xFFFFFF)
#define NAVIGATION_BGCOLOR UIColorFromRGB(0xee6325)
#define TABBARTITLECOLOR    [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]
#define CommonColor UIColorFromRGB(0x5baef5)
#define CommonBackgroundColor UIColorFromRGB(0xf0f2f6)//0xeeeeee//f0f2f6//f5f8fe
#define DescTextColor UIColorFromRGB(0x666666)
#define ShowMoreTextCorlor UIColorFromRGB(0x737373)

#define TestPaperGreenColor UIColorFromRGB(0x00B37A)
#define TestPaperRedColor UIColorFromRGB(0xFF0000)
#define TestPaperGrayColor UIColorFromRGB(0x898989)

#define MainSectionTitleColor UIColorFromRGB(0x494949)
#define MainTitleColor UIColorFromRGB(0x313131)
#define MainSubTitleColor  UIColorFromRGB(0xa1a1a1)
#define CoursePriceChargeColor  UIColorFromRGB(0xf55f62)
#define CoursePriceFreeColor  UIColorFromRGB(0x76d387)

//多种状态(不变)
#define StatusWaitingColor UIColorFromRGB(0xf8af75)     //待审核
#define StatusForbiddenColor UIColorFromRGB(0xfc7578)   //禁止加入
#define StatusEnableColor UIColorFromRGB(0x5adfcf)      //授课中、已加入、可加入
#define StatusFullColor UIColorFromRGB(0x5faff2)        //班级人数已满
#define StatusNojoinColor UIColorFromRGB(0xc5c5c5)      //未加入

#define PurchaseColor UIColorFromRGB(0xf55f62)         // 支付相关的红色

#define KMainBlueColor  UIColorRGB(91,174,245)     // 主蓝色
#define KMainTitleColor  UIColorRGB(73,73,73)    //主标题颜色
#define KMainSubTitleColor  UIColorRGB(161,161,161)  // 副标题颜色
#define KMainSeparatorColor  UIColorRGB(227,233,238)  // 分割线颜色

#define NavigationTitleFontSize 16

//分割线
#define CellLine_Color UIColorFromRGB(0xe3e9ee)

#define UIImageDefaultImage [UIImage imageNamed:@"center_head"]
#define CourseDefaultImage [UIImage imageNamed:@"course_default"]

typedef void (^ALertCompletion)(BOOL compliont);
typedef UIAlertView SMAlerView;
#define SMAlerViewDelegate UIAlertViewDelegate

#define STRISEMPTY(str) (str==nil || [str isEqualToString:@""])
#define TABBAR_HEIGHT ([[UITabBarController alloc]init].tabBar.frame.size.height)
#define STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)


#define BLACKBAR_BUTTON [MSBase backButton:self action:@selector(backAction:)]
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APPName [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleDisplayName"]

#define WeakSelf __block __weak typeof(self) weakSelf = self;

NSArray *defaultColorArr(void);

BOOL  strIsContainEmpty(NSString *str);

@interface MSBase : NSObject

+(UIButton *) createButton:(CGRect) frame type:(UIButtonType)buttonType title:(NSString *)title;
+(UILabel *)  createLabel:(CGRect) frame font:(UIFont *)font text:(NSString *)text defaultSizeTxt:(NSString *)sizeDefault color:(UIColor *)txtColor backgroundColor:(UIColor *)backgroundColor;

+(UIBarButtonItem *)MbackBarButtonItem:(id) taget action:(SEL)action title:(NSString *)title fname:(NSString *)fname fsname:(NSString *)fselname;
+(UIBarButtonItem *)createCustomBarButtonItem:(id)target action:(SEL)action title:(NSString *)title;
+(UIButton*)createPeopleButtonWithTitle:(NSString *)title color:(UIColor *)color;
//添加分割线
+(UIView *)createTableViewSeparatorLion: (CGPoint)position;

+ (UIBarButtonItem *) backButton:(id) taget action:(SEL)action;
// 图标可选图片，默认是 X 形的返回UIBarButtonItem tintColor是图标颜色，nil为白色
+ (UIBarButtonItem *) closeButton:(id) taget action:(SEL)action TintColor:(UIColor *)tintColor backImg:(UIImage *)image;
+(void) alertMessage:(NSString*)msg cb:(ALertCompletion) completion;
+(void) alertMessage:(NSString*)msg view:(UIView *)view cb:(ALertCompletion) completion;
+(UINavigationController *) crateNavigateionControler:(UIViewController *)rootController navBackgroundImage:(UIImage *)bgImage;

+(void) setShouldUpdateNetworkActivityIndicator:(BOOL) activity;

/**
 *  全局隐藏键盘
 */
+ (void)hideKeyBoard;

@end


SMAlerView * SMAlert(NSString* message,NSString *title,NSString *buttonTitle1,NSString *buttonTitle2,id<SMAlerViewDelegate>target);
//一下为一下公共c 函数
CGSize getViewSize(BOOL isHindTabBar);

UINavigationController *createNavgationController(UIViewController *rootV);

