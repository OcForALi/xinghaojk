//
//  ChatModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/14.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface ChatModel : BaseModel

@property (nonatomic ,copy) NSString *createuser;
///头像
@property (nonatomic ,copy) NSString *head;
///确认
@property (nonatomic ,copy) NSString *is_confirm;
///医疗 ID
@property (nonatomic ,copy) NSString *medical_id;
///MsgID
@property (nonatomic ,copy) NSString *msg_id;
///Msg类型 0 = 文字信息 1 = 图片信息 2 = 药品消息 3 = 提醒消息 4 = 语音消息
@property (nonatomic ,copy) NSString *msg_type;
///内容
@property (nonatomic ,copy) NSString *rcd_contents;
///文件
@property (nonatomic ,copy) NSString *rcd_files;
///用户类型 患者 = 0 医生 = 1
@property (nonatomic ,copy) NSString *user_type;
///用户名
@property (nonatomic ,copy) NSString *username;
///zx_no 位置
@property (nonatomic ,copy) NSString *zx_no;
///药品
@property (nonatomic ,copy) NSArray *druguse;

@end
