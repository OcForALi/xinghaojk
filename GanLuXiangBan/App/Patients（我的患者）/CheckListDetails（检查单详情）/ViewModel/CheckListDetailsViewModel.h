//
//  CheckListDetailsViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "CheckListDetailsModel.h"

@interface CheckListDetailsViewModel : HttpRequest

- (void)getChkTypeListWithChkId:(NSString *)chkId complete:(void (^)(id object))complete;

- (void)getChkListByYearWithTypeId:(NSString *)typeId mid:(NSString *)mid complete:(void (^)(id object))complete;

- (void)getChkFilesWithGroupid:(NSString *)groupid complete:(void (^)(id))complete;

- (void)getChkFilesGroup_id:(NSString *)group_id complete:(void (^)(id object))complete;

- (void)getDemoItems:(NSString *)typeId complete:(void (^)(HttpGeneralBackModel *model))complete;

@end
