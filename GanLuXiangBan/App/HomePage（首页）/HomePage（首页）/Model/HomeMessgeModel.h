//
//  HomeMessgeModel.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface HomeMessgeModel : BaseModel
///mid
@property (nonatomic ,copy) NSString *mid;
///msg_id
@property (nonatomic ,copy) NSString *msg_id;
///名字
@property (nonatomic ,copy) NSString *name;
///内容
@property (nonatomic ,copy) NSString *content;
///头像
@property (nonatomic ,copy) NSString *logo;
///消息时间
@property (nonatomic ,copy) NSString *create_time;
///消息类型
@property (nonatomic ,copy) NSString *msg_type;
///消息来源
@property (nonatomic ,copy) NSString *msg_source;
///未读
@property (nonatomic ,copy) NSString *unread;

@end


@interface HomeAssistantModel : BaseModel
@property (nonatomic ,copy) NSString *clerkId;// "118_clerk";
@property (nonatomic ,copy) NSString *clerkMemo;// "\U8bf7\U7ed9\U60a3\U8005\U5f00\U836f";
@property (nonatomic ,copy) NSString *clerkName;// "\U5c0f\U5f20";
@property (nonatomic ,copy) NSString *clerkPic;// "<null>";
@property (nonatomic, assign) NSInteger historyFlag;// 0;
@property (nonatomic ,copy) NSString *memberAge;// "<null>";
@property (nonatomic ,copy) NSString *memberId;// "<null>";
@property (nonatomic ,copy) NSString *memberName;// "<null>";
@property (nonatomic ,copy) NSString *memberSex;// "<null>";
@property (nonatomic ,copy) NSString *msg;// "";
@property (nonatomic ,copy) NSString *msgDate;// "20181224 181636";
@property (nonatomic, assign) NSInteger msgType;// 0;
@property (nonatomic ,copy) NSString *patientDescribe;// "\U4e70\U611f\U5192\U836f";
@property (nonatomic ,copy) NSString *receiveId;// "67_doc";
@property (nonatomic ,copy) NSString *senderId;// "118_clerk";
@property (nonatomic ,copy) NSString *type;// send;
@end
