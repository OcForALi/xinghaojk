//
//  GroupEditCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupEditCell.h"

@implementation GroupEditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    NSArray *imgs = @[@"SortingAreaAddImg", @"SortingAreaDeleteImg"];
    CGFloat btnWdit = ScreenWidth / 4;
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnWdit * i, 0, btnWdit, 0);
        [self.contentView addSubview:button];
        
        @weakify(self);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.btnClick(i);
        }];
        
        UIImage *img = [UIImage imageNamed:imgs[i]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        imgView.frame = CGRectMake(0, 20, 0, 0);
        imgView.size = img.size;
        imgView.centerX = button.width / 2;
        [button addSubview:imgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button.width, 15)];
        titleLabel.y = CGRectGetMaxY(imgView.frame) + 10;
        titleLabel.text = i == 0 ? @"添加" : @"删除";
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addSubview:titleLabel];
        
        button.height = CGRectGetMaxY(titleLabel.frame) + 20;
        self.editCellHeight = button.height;
    }
}

@end
