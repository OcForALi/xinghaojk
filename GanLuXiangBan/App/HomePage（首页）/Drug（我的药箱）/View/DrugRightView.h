//
//  DrugRightView.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/29.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrugRightView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;

#pragma mark - Block
@property (nonatomic, strong) void (^didSelectBlock)(NSString *idString, NSString *name);

@end
