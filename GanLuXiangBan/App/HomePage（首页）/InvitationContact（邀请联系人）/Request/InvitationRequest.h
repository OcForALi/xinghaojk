//
//  InvitationRequest.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/9/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface InvitationRequest : HttpRequest

- (void)getK780AppKey:(NSString *)AppKey Sign:(NSString *)Sign :(void (^)(HttpGeneralBackModel *model))complete;

@end

