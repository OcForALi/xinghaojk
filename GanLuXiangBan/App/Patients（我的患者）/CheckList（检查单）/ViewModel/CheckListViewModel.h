//
//  CheckListViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"

@interface CheckListViewModel : HttpRequest

- (void)getChkTypeListWithMid:(NSString *)mid complete:(void (^)(id object))complete;

@end
