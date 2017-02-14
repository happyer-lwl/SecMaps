//
//  DataCenter.h
//  wyzc
//
//  Created by sunjun on 14-7-16.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//
#import <UIKit/UIKit.h>

#define cmd_name(proNmame,key,dic)\
{NSString *cvalue = [dic objectForKey:key];\
if (!STRISEMPTY(cvalue)) {\
self.proNmame = cvalue;\
}else{\
self.proNmame = @"";\
}}

#define cmd_Arr_name(proNmame,key,dic)\
{NSArray *cvalue = [dic objectForKey:key];\
if (cvalue) {\
self.proNmame = cvalue;\
}else{\
self.proNmame = nil;\
}}

#define cmd_Num_name(proNmame,key,dic)\
{NSNumber *cvalue = [dic objectForKey:key];\
if (!proNmame) {\
self.proNmame = cvalue;\
}else{\
self.proNmame = nil;\
}}

#define Over_PROPERTY  1

typedef NS_ENUM(NSInteger, MessageSourceTyoe) {
    message_void = 1,
    message_text,
};

#import "Jastor.h"

@interface DataCenter : Jastor
@property(nonatomic,strong) NSNumber *code;
@property(nonatomic,strong) NSString *msg;
@property(nonatomic,strong) NSString *serverTime;
@end

/** 全局配置详情 */
@interface TabbarConfig : DataCenter
@property (nonatomic, strong) NSString *nameCn;        //中文名字
@property (nonatomic, strong) NSString *nameEn;        //英文名字
@property (nonatomic, strong) NSString *imageDefault;  //默认图片
@property (nonatomic, strong) NSString *imageActive;   //选中图片
@end

@interface HomePageMode : DataCenter
@property (nonatomic, strong) NSString *count;      //该模块有多少条数据
@property (nonatomic, strong) NSString *moduleKey;  //模块的key
@property (nonatomic, strong) NSString *moduleName; //模块名称
@property (nonatomic, strong) NSString *styleKey;   //样式key
@property (nonatomic, strong) NSString *styleName;  //样式名称
@end

@interface HomePageConfig : DataCenter
@property (nonatomic, strong) TabbarConfig   *tabbar;   //APP底部导航配置(大模块对应底部导航配置)
@property (nonatomic, strong) NSArray *modules; //大模块对应子模块配置数组
@end

@interface CategoryPageConfig : DataCenter
@property (nonatomic, strong) TabbarConfig   *tabbar;   //APP底部导航配置(大模块对应底部导航配置)
@property (nonatomic, strong) NSArray        *modules;  //大模块对应子模块配置数组
@end
@interface DiscoveryPageConfig : DataCenter
@property (nonatomic, strong) TabbarConfig   *tabbar;   //APP底部导航配置(大模块对应底部导航配置)
@property (nonatomic, strong) NSArray        *modules;  //大模块对应子模块配置数组
@end
@interface MePageConfig : DataCenter
@property (nonatomic, strong) TabbarConfig   *tabbar;   //APP底部导航配置(大模块对应底部导航配置)
@property (nonatomic, strong) NSArray        *modules;  //大模块对应子模块配置数组
@end

@interface GlobalConfigData : DataCenter
@property (nonatomic, strong) NSNumber *version;
@property (nonatomic, strong) HomePageConfig     *homePageConfig;
@property (nonatomic, strong) CategoryPageConfig *categoryPageConfig;
@property (nonatomic, strong) DiscoveryPageConfig *discoverPageConfig;
@property (nonatomic, strong) MePageConfig        *mePageConfig;
@end

@interface GoodsItem : DataCenter
@property (nonatomic, strong) NSString *goodId;     // id
@property (nonatomic, strong) NSString *goodCover;  // 物品封面
@property (nonatomic, strong) NSString *title;      // 标题
@property (nonatomic, strong) NSString *status;     // 当前状态
@property (nonatomic, strong) NSString *time;       // 最后更新时间
@property (nonatomic, strong) NSString *position;   // 当前保存位置
@property (nonatomic, strong) NSString *price;      // 价格
@end

@interface GoodsCacheData : DataCenter
@property (nonatomic, strong) NSArray *cacheData;
@end
