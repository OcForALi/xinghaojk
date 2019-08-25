//
//  TreatmentViewController.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"
#import "PatientsDetailsModel.h"

@interface TreatmentViewController : BaseViewController

@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *pkid;
@property (nonatomic, strong) NSString *mid;

@property (nonatomic ,strong) NSMutableArray *addImas;
@property (nonatomic, strong) void (^refreshBlock)();

@end
