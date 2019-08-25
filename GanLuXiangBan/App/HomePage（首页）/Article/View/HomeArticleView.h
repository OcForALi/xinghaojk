//
//  HomeArticleView.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseTableView.h"

#import "HomeArticleModel.h"

@interface HomeArticleView : BaseTableView

@property (nonatomic, strong) void(^articleListTapItemBlock)(HomeArticleModel *model);

@property (nonatomic, assign) BOOL showWaited;

@end
