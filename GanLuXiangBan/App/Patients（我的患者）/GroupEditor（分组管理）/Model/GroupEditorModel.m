//
//  GroupEditorModel.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupEditorModel.h"

@implementation GroupEditorModel

- (id)copyWithZone:(NSZone *)zone {
    GroupEditorModel *group = [GroupEditorModel allocWithZone:zone];
    group.label = self.label;
    group.name = self.name;
    group.count = self.count;
    return group;
}

@end
