//
//  CheckListModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/16.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface CheckListModel : BaseModel

/// 患者ID
@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *chk_id;
@property (nonatomic, strong) NSString *chk_type_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *last_time;
@property (nonatomic, assign) BOOL unread;
@property (nonatomic, strong) NSString *chk_count;
@property (nonatomic, strong) NSString *read_count;
@property (nonatomic ,strong) NSString *group_id;

@end
