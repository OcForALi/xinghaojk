//
//  PatientsDetailsViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/10.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "PatientsDetailsModel.h"
#import "PatientsVisitDetailsModel.h"

@interface PatientsDetailsViewModel : HttpRequest

- (void)getDetailWithMidString:(NSString *)mid complete:(void (^)(id object))complete;

- (void)getMedicalRcdWithMidString:(NSString *)mid page:(NSString *)page complete:(void (^)(id object))complete;

- (void)chkUnread:(NSString *)mid complete:(void (^)(NSInteger unread))complete;

@end
