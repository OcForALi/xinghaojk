//
//  DiseasesView.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseTableView.h"

#import "DiseaseLibraryModel.h"

typedef void(^CollectBlock)(DiseaseLibraryModel *model);

typedef void(^CollectDeleteBlock)(DiseaseLibraryModel *model);

@interface DiseasesView : BaseTableView

@property (nonatomic ,assign) NSInteger typeInteger;

@property (nonatomic ,copy) CollectBlock collectBlock;

@property (nonatomic ,copy) CollectDeleteBlock collecDeleteBlock;

-(void)addData:(NSArray *)array;

@end
