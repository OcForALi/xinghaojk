//
//  CheckListDetailsModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface CheckItemsModel : BaseModel

/// 指标id
@property (nonatomic, strong) NSString *chk_demo_id;
/// 检查项目
@property (nonatomic, strong) NSString *chk_item;
/// 项目代码
@property (nonatomic, strong) NSString *chk_item_code;
/// 单位
@property (nonatomic, strong) NSString *unti;
/// 检查结果
@property (nonatomic, strong) NSString *chk_value;

@end

@interface CheckListDetailsModel : BaseModel

/// 病情ID
@property (nonatomic, strong) NSString *chk_id;
/// 科院ID
@property (nonatomic, strong) NSString *hospital_id;
/// 医院
@property (nonatomic, strong) NSString *hospital_name;
/// 结论
@property (nonatomic, strong) NSString *chk_remark;
/// 时间
@property (nonatomic, strong) NSString *chk_time;
/// 类型
@property (nonatomic, strong) NSArray *items;
/// 分组ID
@property (nonatomic, strong) NSString *group_id;

@end


@interface CheckDemoModel : BaseModel
@property (nonatomic, strong) NSString *pkid;
@property (nonatomic, strong) NSString *chk_item_code;
@property (nonatomic, strong) NSString *chk_item;
@property (nonatomic, assign) BOOL isSelect;
@end
