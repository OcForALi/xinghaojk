//
//  CerImgModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/7/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface CerImgModel : BaseModel

@property (nonatomic, strong) NSString *emp_card;
@property (nonatomic, strong) NSString *practice_card;
@property (nonatomic, strong) NSString *qualification_card;

@property (nonatomic, strong) NSString *id_card_face;
@property (nonatomic, strong) NSString *id_card_con;
@property (nonatomic, strong) NSString *idt_auth_remark;

@property (nonatomic, strong) NSString *auth_status;

/// 是否工作认证
@property (nonatomic, assign) BOOL isDoctorFiles;

@end
