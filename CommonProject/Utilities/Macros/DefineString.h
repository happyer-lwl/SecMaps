//
//  DefineString.h
//  MiniSales
//
//  Created by sunjun on 13-7-13.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefineString : NSObject

@end

//网络提示
#define NET_ERROR         NSLocalizedString(@"发生一个未知的错误!",nil)
#define NET_TIMEOUT       NSLocalizedString(@"网络异常,请检查您的网络!", nil)
#define NET_LOADING       @"正在加载…"
#define STR_OK            @"确定"
#define STR_DOWN_OK       @"确认下载"
#define STR_hint          @"提示"
#define STTR_ater_on      @"请稍后……"

#define STR_DEPARTENTS   @"院系"
#define MY_NEWS          @"通知"
#define MY_NOTIS         @"站内信"
#define CHICK_LOGIN      @"点击登录"
#define MY_SOURFSE       @"课程"
#define MY_AN            @"我的回答"
#define MY_WaiteAN       @"待我回答"
#define MINE_CLASS       Global_SiteType_String(@"班级")
#define MY_TEACHING      Global_SiteType_String(@"我的授课")
#define MY_COURSE        Global_SiteType_String(@"我的课程")
#define MY_CLASSES       [NSString stringWithFormat:@"我的%@",Global_SiteType_String(@"班级")]
#define MY_NOTBOOK       @"我的笔记"
#define MY_ASK_AN        @"我的提问"
#define MY_POSTER        @"我的海报"
#define MY_TOPIC         @"我的话题"
#define MY_ORDER         @"我的订单"
#define MY_TEST          @"我的评测"
#define SENDED_NOTI      @"已发通知"
#define MY_GLOLD         @"金币中心"
#define MY_replyNotbook  @"我回复的笔记"
#define MY_DOWNLOAD      @"下载中心"
#define MY_CENTER        @"个人中心"
#define STR_SETTING      @"设置"
#define NOTICE_SETTING   @"通知设置"
#define STR_CLASS        [NSString stringWithFormat:@"%@群聊",Global_SiteType_String(@"班级")]
#define COURSE_DIR       @"课程目录"
#define COURSE_LIST      @"课程列表"
#define STR_FRUM_        @"论坛"
#define STR_LOGIN        @"登录"
#define STR_REGISTER     @"注册"
#define STR_MYQUESTION   @"提问"
#define TOPIC_DETAIL     @"话题详情"
#define MY_CLASS_APPLICATIONLIST    @"申请列表"
#define CLASS_SETTING    [NSString stringWithFormat:@"%@设置",Global_SiteType_String(@"班级")]
#define SUBMIT_NOTI      @"发布通知"
#define SELECT_RANGE     @"接收范围"
#define COURSELABARY     @"公开课联盟"
#define MY_SERVICES      Global_SiteType_String(@"我的服务")
#define MY_WALLET        @"我的钱包"

#define STR_Agreement   @"已阅读并同意"
#define STR_WYZCSERVER  @"《我赢职场服务条款》"
#define STR_SERVERT     @"服务条款"
#define STR_PSD_ERROR   @"密码输入不一致"
#define STR_NOTSERVER   @"您未同意"
#define STR_VIDEO_HINT  @"请到网站购买相应的观看权限"

#define STR_NOTE        @"笔记"
#define STR_QUAN        @"问答"
#define STR_DOWNLOAD    @"下载中心"

#define STR_DOWNLOADING @"下载中"
#define STR_COMPTED     @"已完成"


#define STR_SEARCH      @"成功添加至缓存列表"
#define str_cancel      @"取消"
#define cancel_all      @"取消全选"
#define str_all         @"全选"
#define str_pause       @"全部暂停"
#define str_delete      @"删除"
#define str_deleteSuc   @"视频删除成功"
#define str_start       @"全部开始"
#define str_edit        @"编辑"
#define str_done        @"完成"
#define str_allNote     @"全部笔记"
#define str_Nodtedetail @"笔记详情"
#define str_askdetail   @"问答详情"

#define str_down_error  @"下载错误"
#define str_disable_wifi @"当前没有可用的网络"

#define ExamResult      [NSString stringWithFormat:@"%@结果",Global_SiteType_String(@"考试")]
#define ExamSingleChoice @"单选题"
#define ExamUncertainChoice @"不定项选择题"
#define ExamChoice      @"多选题"
#define ExamDetermine   @"判断题"
#define ExamFill        @"填空题"
#define ExamEssay       @"简答题"
#define RecommendCourse @"精品课程"
#define Discover        @"发现"
#define ChatSetting     @"会话设置"
#define CharReport      @"举报"

