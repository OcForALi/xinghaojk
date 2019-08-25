//
//  TipCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipCell : UITableViewCell

@property (nonatomic, strong) UILabel *tipLabel;
/// 提示内容
@property (nonatomic, strong) NSString *tipContent;
/// 总高度
@property (nonatomic, assign) CGFloat tipCellHeight;

@end
