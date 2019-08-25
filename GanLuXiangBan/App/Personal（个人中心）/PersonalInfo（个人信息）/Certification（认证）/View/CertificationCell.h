//
//  CertificationCell.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificationCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userImgView;
@property (nonatomic, strong) NSString *text;

#pragma mark - Block
@property (nonatomic, strong) void (^selectImgBlock)();

@end
