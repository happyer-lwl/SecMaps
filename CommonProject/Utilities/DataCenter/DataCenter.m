//
//  DataCenter.m
//  wyzc
//
//  Created by sunjun on 14-7-16.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import "DataCenter.h"
#import "MSBase.h"


@implementation DataCenter

@end

@implementation TabbarConfig
@end

@implementation HomePageConfig
-(Class)tabbar_class{
    return [TabbarConfig class];
}
-(Class)modules_class{
    return [HomePageMode class];
}
@end

@implementation HomePageMode
@end

@implementation CategoryPageConfig
-(Class)tabbar_class{
    return [TabbarConfig class];
}
-(Class)modules_class{
    return [HomePageMode class];
}
@end

@implementation DiscoveryPageConfig
-(Class)tabbar_class{
    return [TabbarConfig class];
}
-(Class)modules_class{
    return [HomePageMode class];
}
@end

@implementation MePageConfig
-(Class)tabbar_class{
    return [TabbarConfig class];
}
-(Class)modules_class{
    return [HomePageMode class];
}
@end

@implementation GlobalConfigData
-(Class)homePageConfig_class{
    return [HomePageConfig class];
}
-(Class)categoryPageConfig_class{
    return [CategoryPageConfig class];
}
-(Class)discoveryPageConfig_class{
    return [DiscoveryPageConfig class];
}
-(Class)mePageConfig_class{
    return [MePageConfig class];
}
@end

@implementation GoodsItem
@end

@implementation GoodsCacheData
-(Class)cacheData_class{
    return [GoodsItem class];
}
@end
