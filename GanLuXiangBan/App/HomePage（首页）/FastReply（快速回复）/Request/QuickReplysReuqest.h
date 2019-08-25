//
//  QuickReplysReuqest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface QuickReplysReuqest : HttpRequest

/**
 快捷回复列表
 */
- (void)getQuickReplysComplete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 新增/编辑快捷回复
 */
- (void)postSaveQuickReplyContent:(NSString *)content pkid:(NSString *)pkid complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 批量删除快捷回复记录
 */
- (void)postDelQuickReplyPkids:(NSArray *)pkids complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

@end
