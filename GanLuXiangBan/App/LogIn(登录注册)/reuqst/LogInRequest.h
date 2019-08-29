//
//  LonInRequest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "LogInModel.h"
#import "FillInDataRequestModel.h"

@interface LogInRequest : HttpRequest

/**
 账号登录
 
 @param loginname 账号
 @param loginpwd 密码
 */
- (void)getLogInfoWithloginname:(NSString *)loginname loginpwd:(NSString *)loginpwd complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 获取bear-token
 */
- (void)getBearToken;

/**
 账号登录
 
 @param cid 应该传pkid？
 */
- (void)postSaveClientCid:(NSString *)cid complete:(void (^)(LogInModel *model))complete;

/**
 查询当前医生的终端信息记录
 */
- (void)getClientInfoComplete:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 获取验证码
 
 @param mobileno 手机号
 */
- (void)getCaptchaWithmobileno:(NSString *)mobileno type:(NSInteger)type complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete;
/**
 忘记密码
 
 @param mobileno 手机号
 */
- (void)getMasterDataCaptchaWithmobileno:(NSString *)mobileno type:(NSInteger)type complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 用户注册
 
 @param MobileNo 手机号
 @param Password 密码
 @param Code 验证码
 */
- (void)postLogOnWithMobileNo:(NSString *)MobileNo Password:(NSString *)Password Code:(NSString *)Code complete:(void (^)(HttpGeneralBackModel *generalBackModel))complete;

/**
 填写资料

 */

-(void)postSaveBasicInfo:(FillInDataRequestModel *)model complete:(void (^)(HttpGeneralBackModel *model))complete;

/**
 忘记密码
 
 @param MobileNo 手机号
 @param Password 密码
 @param Code 验证码
 */
- (void)postForgetPwdMobileNo:(NSString *)MobileNo Password:(NSString *)Password Code:(NSString *)Code complete:(void (^)(HttpGeneralBackModel *model))complete;

/**
 服务协议
 */
- (void)getProtocolComplete:(void (^)(HttpGeneralBackModel *model))complete;

/**
 版本更新信息
 */
- (void)getVersionUpdateInfoComplete:(void (^)(HttpGeneralBackModel *model))complete;


@end
