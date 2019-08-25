//
//  DrugListViewController.h
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchView.h"

@interface DrugListViewController : BaseViewController

@property (nonatomic ,copy) NSString *idString;

@property (nonatomic, copy) NSString *keyString;

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic ,copy) NSString *searchString;

-(void)request:(NSString *)key sort:(NSInteger)sort isDesc:(BOOL)isDesc;

@end
