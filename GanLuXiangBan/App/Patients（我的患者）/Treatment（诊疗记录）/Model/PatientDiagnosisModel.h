//
//  PatientDiagnosisModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/7/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseModel.h"

@interface PatientDiagnosisModel : BaseModel

@property (nonatomic, strong) NSString *pkid;
@property (nonatomic, strong) NSString *diagnosis_id;
@property (nonatomic, strong) NSString *file_path;
@property (nonatomic, strong) NSString *createtime;

@end
