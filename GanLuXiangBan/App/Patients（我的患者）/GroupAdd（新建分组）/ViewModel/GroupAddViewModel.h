//
//  GroupAddViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "GroupAddModel.h"

@interface GroupAddViewModel : HttpRequest

/**
     获取分组详情

     @param idString ID
     @param complete 成功回调
 */
- (void)getLabelLabelDetailWithId:(NSString *)idString complete:(void (^)(id object))complete;

/**
     保存分组列表

     @param addIds 添加的ID
     @param delIds 删除的ID
     @param model 分组模型
     @param complete 成功回调
 */
- (void)savePatientLabelWithAddIds:(NSArray *)addIds
                            delIds:(NSArray *)delIds
                             moedl:(GroupAddModel *)model
                          complete:(void (^)(id object))complete;

/**
     添加分组

     @param addIds 添加的ID
     @param nameString 分组名
     @param complete 成功回调
 */
- (void)addLabelWithAddIds:(NSArray *)addIds name:(NSString *)nameString complete:(void (^)(id))complete;

/**
     删除分组

     @param idString ID
     @param complete 成功回调
 */
- (void)delPatientLabelWithId:(NSString *)idString complete:(void (^)(id))complete;

@end
