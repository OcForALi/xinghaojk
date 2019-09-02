//
//  PersonalInfoViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "PersonalInfoModel.h"

@interface PersonalInfoViewModel : HttpRequest


/**
 上传用户信息

 @param model 模型
 @param complete 完成回调
 */
- (void)uploadUserInfoWithModel:(PersonalInfoModel *)model complete:(void (^)(id object))complete;


/**
 获取医生个人信息

 @param idString 用户ID
 @param complete 完成回调
 */
- (void)getDoctorInfoWithId:(NSString *)idString complete:(void (^)(PersonalInfoModel *model))complete;


/**
 身份认证信息

 @param idString 用户ID
 @param complete 完成回调
 */
- (void)getDoctorFilesInfoWithId:(NSString *)idString complete:(void (^)(PersonalInfoModel *model))complete;

/**
 获取医生统计数据
 */
- (void)getDoctorStaticData:(void (^)(PersonalStaticModel *model))complete;

@end
