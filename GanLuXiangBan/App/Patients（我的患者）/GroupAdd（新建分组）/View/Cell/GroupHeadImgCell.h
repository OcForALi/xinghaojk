//
//  GroupHeadImgCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupAddModel.h"

@interface GroupHeadImgCell : UITableViewCell

@property (nonatomic, assign) CGFloat groupHeadImgCellHeight;
@property (nonatomic, strong) NSArray *imgUrls;

@property (nonatomic, assign) BOOL isShowDel;
@property (nonatomic, strong) void (^delImgBlock)(int index);

@end
