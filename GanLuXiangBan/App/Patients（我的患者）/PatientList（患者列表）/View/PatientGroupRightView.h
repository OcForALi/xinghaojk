//
//  PatientGroupRightView.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/19.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseTableView.h"

#import "GroupEditorModel.h"

typedef void(^PatientGroupChooseBlock)(BOOL cancel, GroupEditorModel *model);

@interface PatientGroupRightView : UIView

+ (void)show:(NSArray *)groups complete:(PatientGroupChooseBlock)complete;

@end
