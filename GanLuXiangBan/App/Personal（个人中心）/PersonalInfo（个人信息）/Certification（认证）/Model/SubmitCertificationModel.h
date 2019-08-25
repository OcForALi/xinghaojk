//
//  SubmitCertificationModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface SubmitCertificationModel : BaseModel

/// 默认为0
@property (nonatomic, strong) NSString *pkid;
/// 附件类型 1-身份证正面、2-身份证反面、3-执业资格证、7-工作证、8-医师资格证
@property (nonatomic, strong) NSString *file_type;
/// 附件路径 先上传图片后获取路径
@property (nonatomic, strong) NSString *file_path;
/// 医生id
@property (nonatomic, strong) NSString *drid;

@end
