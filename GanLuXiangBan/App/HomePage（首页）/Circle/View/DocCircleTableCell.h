//
//  DocCircleTableCell.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/13.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocCircleTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, assign) BOOL expand;

@end



@interface DocCircleNextTableCell : DocCircleTableCell

@end



@interface DocCircleLastTableCell : DocCircleTableCell

@end
