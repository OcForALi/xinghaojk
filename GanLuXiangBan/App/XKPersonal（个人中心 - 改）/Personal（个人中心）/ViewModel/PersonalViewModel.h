//
//  PersonalViewModel.h
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HttpRequest.h"
#import "PersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalViewModel : HttpRequest

- (void)getDataSource:(void (^)(PersonalModel *))complete;

@end

NS_ASSUME_NONNULL_END
