//
//  DoctorDetailsViewModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"
#import "DoctorDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoctorDetailsViewModel : HttpRequest

- (void)getDetailsWithIdStr:(NSString *)idStr complete:(void (^)(DoctorDetailsModel *))complete;

@end

NS_ASSUME_NONNULL_END
