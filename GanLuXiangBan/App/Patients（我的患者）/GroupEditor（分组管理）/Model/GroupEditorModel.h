//
//  GroupEditorModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface GroupEditorModel : BaseModel <NSCopying>

@property (nonatomic, copy) NSString *label;
/// 名字
@property (nonatomic, copy) NSString *name;
/// 数量
@property (nonatomic, copy) NSString *count;
/// 是否选中
@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) NSArray *list;

@end
