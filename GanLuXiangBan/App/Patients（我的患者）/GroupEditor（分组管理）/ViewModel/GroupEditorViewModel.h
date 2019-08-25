//
//  GroupEditorViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "GroupEditorModel.h"

@interface GroupEditorViewModel : HttpRequest

- (void)getLabelListComplete:(void (^)(NSArray *list))complete;

- (void)saveLabelWithIds:(NSArray *)ids
                     mid:(NSString *)midString
                complete:(void (^)(id object))complete;

@end
