//
//  GroupOfMessageViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

typedef NS_ENUM(NSInteger, GroupMessageReceiveType) {
    GroupMessageReceiveTypeAll = 0,
    GroupMessageReceiveTypePart,
    GroupMessageReceiveTypeExcept
};

@interface GroupOfMessageViewModel : HttpRequest

/**
 群发消息

 @param content 内容
 @param reciveType 0-所有患者  1-部分收到  2-部分不可见
 @param labels 已选择分组ID数组
 @param mids 已选择患者id数组
 @param isAttention 特别关注
 */
- (void)sendMessageWithContent:(NSString *)content
                    reciveType:(GroupMessageReceiveType)reciveType
                        labels:(NSArray *)labels
                          mids:(NSArray *)mids
                   isAttention:(BOOL)isAttention
                      complete:(void (^)(NSInteger code, NSString *msg))complete;

- (void)getCountComplete:(void (^)(id object))complete;;

@end
