//
//  HomeAddArticleViewController.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseViewController.h"

#import "HomeArticleSaveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeAddArticleViewController : BaseViewController

@property (nonatomic, strong) HomeArticleSaveModel *model;

@property (nonatomic, assign) BOOL canRemove;

@end

NS_ASSUME_NONNULL_END
