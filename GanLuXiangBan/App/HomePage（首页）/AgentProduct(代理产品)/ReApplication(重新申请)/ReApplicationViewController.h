//
//  ReApplicationViewController.h
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseViewController.h"
#import "DrugListModel.h"
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReApplicationViewController : BaseViewController
/// 0 = 添加申请 1 = 重新申请
@property (nonatomic ,assign) NSInteger type;

@property (nonatomic ,copy) DrugListModel *addModel;

@property (nonatomic ,copy) ProductModel *noPassModel;

@property (nonatomic ,assign) NSInteger appID;

//@property (nonatomic ,copy)

@end

NS_ASSUME_NONNULL_END
