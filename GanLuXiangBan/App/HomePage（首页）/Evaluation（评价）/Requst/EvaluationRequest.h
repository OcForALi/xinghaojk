//
//  Evaluation.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface EvaluationRequest : HttpRequest

/**
 评论列表
 */
- (void)getEvaluatesPageindex:(NSInteger)pageindex complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 根据评价id获取最近的赞赏详情
 */
- (void)getDdmirationDetailID:(NSString *)id complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

@end
