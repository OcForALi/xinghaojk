//
//  FamousTableViewCell.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FamousTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) UILabel *hospitalLabel;

@end


@interface FamouseDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, assign) BOOL expand;

@end

NS_ASSUME_NONNULL_END
