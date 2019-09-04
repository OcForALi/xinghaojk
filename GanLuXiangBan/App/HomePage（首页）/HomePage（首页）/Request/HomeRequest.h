//
//  HomeRequest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/15.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "BannerModel.h"
#import "HomeModel.h"
#import "HomeMessgeModel.h"

@interface HomeRequest : HttpRequest

/**
 首页轮播图

 */
- (void)getBanner:(void (^)(HttpGeneralBackModel *model))complete;

/**
 首页相关信息
 
 */
- (void)getIndexInfo:(void (^)(HomeModel *model))complete;

/**
 获取代理个人中心统计 (首页 医生数、开单金额 使用)
 
 */
- (void)getPersonalStatics:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 获取开单排行榜
 
 */
- (void)getRankingLstPage:(NSString *)page size:(NSString *)size :(void (^)(HttpGeneralBackModel *generalBackModel))complete;


/**
 获取医生
 */
- (void)getMyDoctor:(void (^)(HomeModel *model))complete;


/**
 医生头像上传路径
 
 */
- (void)postUpdateDrHeadUrl:(NSString *)urlString :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
消息列表
 
 */
- (void)getMsgListLoad_type:(NSString *)Load_type :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 获取当天是否签到
 
 */
- (void)getIsSign:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 我的患者 底部导航红点提示
 
 */
- (void)getUnreadForMyPatient:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 系统消息列表
 */
- (void)getNoticeList:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 清零app推送条数
 */
- (void)getZeroPushNum:(NSString *)client_id :(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 获取医生助理消息
 */
+ (void)getAssistantList:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 转发医生
 */
+ (void)transferDoctor:(HomeAssistantModel *)model complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

@end
