//
//  CertificationView.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseTableView.h"
#import "CerImgModel.h"

@interface CertificationView : BaseTableView

@property (nonatomic, strong) CerImgModel *cerImgModel;
@property (nonatomic, strong) void (^goImgBlock)(UIViewController *viewController);
@property (nonatomic, strong) void (^uploadImg)(NSInteger index, UIImage *img);

@end
