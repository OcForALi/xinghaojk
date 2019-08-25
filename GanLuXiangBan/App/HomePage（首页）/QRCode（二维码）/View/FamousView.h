//
//  FamousView.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseTableView.h"

#import "FamousModel.h"

typedef void(^FamousViewPushBlock)(UIViewController *vc);

@interface FamousView : BaseTableView

@property (nonatomic, strong) FamousViewPushBlock pushBlock;

@end
