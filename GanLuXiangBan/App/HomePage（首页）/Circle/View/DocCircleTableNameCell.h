//
//  DocCircleTableNameCell.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/13.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseCircleView.h"

@interface DocCircleTableNameCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, assign) BOOL expand;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) BaseCircleView *dotView;

@end



@interface DocCircleTableNextNameCell : DocCircleTableNameCell

@end



@interface DocCircleTableLastNameCell : DocCircleTableNameCell

@end
