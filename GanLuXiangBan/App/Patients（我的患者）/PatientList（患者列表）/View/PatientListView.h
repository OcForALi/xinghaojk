//
//  PatientListView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"

#import "GroupEditorModel.h"

@interface PatientListView : BaseTableView

@property (nonatomic, strong) GroupEditorModel *currentGroup;

@property (nonatomic, strong) NSDictionary *dictDataSource;

@property (nonatomic, assign) BOOL showFee;

@property (nonatomic, strong) void(^didSelectPatientGroupBlock)(GroupEditorModel *model);

@property (nonatomic, strong) void(^didSelectPatientBlock)(NSDictionary *dic);

@end
