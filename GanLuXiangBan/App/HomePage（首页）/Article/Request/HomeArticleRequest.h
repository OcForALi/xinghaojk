//
//  HomeArticleRequest.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/1.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"

#import "HomeArticleSaveModel.h"

@interface HomeArticleRequest : HttpRequest

/**
 GET /api/news/NewsList
 患教文章列表

 @param status 0 未发布，1已发布
 @param pageNo 页码
 @param word 搜索关键词
 */
- (void)articles:(NSInteger)status pageNo:(NSInteger)pageNo word:(NSString *)word complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 GET /api/news/NewsDetail
 患教文章明细查询（文章详情）

 @param articleId 资讯主表ID
 */
- (void)detail:(NSInteger)articleId complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 POST /api/news/AddNews
 保存资讯主表及段落
 */
- (void)save:(HomeArticleSaveModel *)model complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 更新文章
 /api/news/saveNewsPage 保存资讯主表及段落
 */
//- (void)update:(HomeArticleSaveModel *)model complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 POST /api/news/publishNews
 医生发布患教文章

 @param articleId 资讯主表ID
 */
//- (void)publish:(NSInteger)articleId complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 POST /api/news/delNews
 医生删除患教文章

 @param articleId 资讯主表ID
 */
- (void)remove:(NSInteger)articleId complete:(void(^)(HttpGeneralBackModel *model))complete;

/**
 GET /api/news/getDrPatient
 获取医生绑定患者人数
 */
- (void)patientCount:(void(^)(HttpGeneralBackModel *model))complete;

/**
 POST /api/news/SendDrNewsNotice
 医生-群发消息 资讯发送给患者

 @param articleId 资讯ID
 @param type 收件人方式 0 所有人 1 部分可见 2 部分不可见
 @param label 标签分组id集
 @param mids 患者id集
 @param attention 是否特别关注
 */
- (void)send:(NSInteger)articleId type:(NSInteger)type label:(NSArray *)label mids:(NSArray *)mids attention:(BOOL)attention complete:(void(^)(HttpGeneralBackModel *model))complete;

@end
