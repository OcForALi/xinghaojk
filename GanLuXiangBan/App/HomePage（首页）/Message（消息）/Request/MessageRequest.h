//
//  MessageRequest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "SaveMedicalRcdModel.h"

@interface MessageRequest : HttpRequest

/**
 发起聊天
 */
- (void)getInitiateChatMid:(NSString *)mid complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 重新发起会话
 */
- (void)postRestartMsgMid:(NSString *)mid complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;
/**
 结束会话
 */
- (void)postCloseMsgMid:(NSString *)mid complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;
/**
 患者消息详情(加载最近一天的留言回复记录
 */
- (void)getDetailMid:(NSString *)mid msg_source:(NSString *)msg_source msg_id:(NSString *)msg_id complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 加载更多消息(以天为单位)
 */
- (void)getMoreMsgMid:(NSString *)mid Date:(NSString *)date complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 获取结束状态
 */
- (void)getCurrentMsgIsClosedMid:(NSString *)mid complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 医生发送图片消息给患者 1.添加留言或回复记录 2.调用微信接口发送图片消息给患者
 */
- (void)postSendImgMsgMid:(NSString *)mid file_path:(NSString *)file_path msg_flag:(NSString *)msg_flag complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;
/**
 发送文本消息 1.添加一条留言或回复记录 2.调用微信接口发送客服消息给患者
 */
- (void)postsendTxtMsggMid:(NSString *)mid content:(NSString *)content msg_flag:(NSString *)msg_flag complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;
/**
 上传.amr音频文件并转化为.mp3文件 返回路径
 */
- (void)postUploadAudio:(NSString *)filePath complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;
/**
发送语音消息
 */
- (void)postSendVoiceMsgMid:(NSString *)mid content:(NSString *)content msg_flag:(NSString *)msg_flag complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;
/**
 保存诊疗记录 1.保存诊疗和处方记录 2.(若从咨询)以医生身份推送一条用药建议消息至患者 3.推送一条消息至公众号 4.推送处方信息至商城
 */
-(void)postSaveMedicalRcd:(SaveMedicalRcdModel *)saveModel complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 编辑推荐用药

 @param updateModel 更新数据
 */
-(void)postUpdateMedicalRcd:(UpdateMedicalRcdModel *)updateModel complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 定时获取用药申请弹框消息(取最新的一条)

 @param mid 患者ID
 */
- (void)pharmacyApplyAlert:(NSString *)mid complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 用药弹框确定

 @param recordId 提示消息记录id
 */
- (void)confirmPharmacyAppAlert:(NSString *)recordId complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 患者咨询医生长时间未回复弹框提示:半小时
 */
- (void)noReplyChatAlert:(void(^)(HttpGeneralBackModel *model))complete;

/**
 长时间未回复弹框确定

 @param recordId 提示消息记录id
 */
- (void)confirmNoReplyAlert:(NSString *)recordId complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

/**
 发送出诊时间

 @param mid 患者id
 @param conent 发送内容
 @param msgSource 专科传0，商城1
 */
- (void)sendDocSchedule:(NSString *)mid content:(NSString *)conent msgSource:(NSString *)msgSource complete:(void (^)(HttpGeneralBackModel *genneralBackModel))complete;

@end
