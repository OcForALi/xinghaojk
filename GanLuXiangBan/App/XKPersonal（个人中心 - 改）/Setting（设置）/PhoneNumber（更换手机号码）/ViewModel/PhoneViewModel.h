//
//  PhoneViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface PhoneViewModel : HttpRequest


/**
     获取验证码

     @param phone 手机号
     @param complete 成功回调
 */
- (void)getMobileCodeWithPhone:(NSString *)phone complete:(void (^)(HttpGeneralBackModel *obj))complete;;


/**
     更换手机号

     @param mobileno 手机号
     @param code 验证码
     @param complete 成功回调
 */
- (void)updateWithMobileno:(NSString *)mobileno code:(NSString *)code  complete:(void (^)(id))complete;

@end
