//
//  SubscribeDetailsViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "SubscribeDetailsModel.h"

@interface SubscribeDetailsViewModel : HttpRequest

- (void)getPreOrderDetail:(NSString *)idString complete:(void (^)(id object))complete;

- (void)getHelpComplete:(void (^)(id object))complete;

- (void)closeVisit:(NSString *)visitId complete:(void (^)(id object))complete;

- (void)checkVisit:(NSString *)appid
          pre_type:(NSString *)pre_type
          is_check:(NSString *)is_check
            reason:(NSString *)reason
          pre_date:(NSString *)pre_date
          location:(NSString *)location
          complete:(void (^)(HttpGeneralBackModel *model))complete;;

@end
