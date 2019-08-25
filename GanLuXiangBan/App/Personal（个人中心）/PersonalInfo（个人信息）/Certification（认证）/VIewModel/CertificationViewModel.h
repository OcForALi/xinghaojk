//
//  CertificationViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "SubmitCertificationModel.h"

@interface CertificationViewModel : HttpRequest

/**
     上传图片

     @param imgData 图片
     @param complete 成功回调
 */
- (void)uploadImageWithImgs:(NSData *)imgData complete:(void (^)(id object))complete;


/**
     获取身份验证信息
 
     @param complete 未认证 = 0,认证中 = 1,已认证 = 2,认证失败 = 3
 */
- (void)getIdtAuthDetailWithComplete:(void (^)(id object))complete;


/**
     获取资格认证信息

     @param complete 未认证 = 0,认证中 = 1,已认证 = 2,认证失败 = 3
 */
- (void)getDoctorFilesWithComplete:(void (^)(id object))complete;


/**
     提交身份认证申请

     @param model model
     @param complete 成功回调
 */
- (void)setIdtAuthFilesWithModel:(SubmitCertificationModel *)model complete:(void (^)(id))complete;


/**
     提交资格认证申请

     @param model model
     @param complete 成功回调
 */
- (void)setCertFicateFilesWithModel:(SubmitCertificationModel *)model complete:(void (^)(id))complete;

@end
