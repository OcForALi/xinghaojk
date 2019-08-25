//
//  VisitsRelatedCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "VisitsRelatedCell.h"

@implementation VisitsRelatedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenWidth / 2 * i, 40, ScreenWidth / 2, VisitsRelatedCellHeight-40);
        button.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:button];
        
        @weakify(self);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         
            @strongify(self);
            
            BaseViewController *viewController = [NSClassFromString(i == 0 ? @"VisitDetailsViewController" : @"PaidConsultingViewController") new];
            viewController.title = i == 0 ? @"出诊计划" : @"付费咨询";
            if (self.goViewControllerBlock) {
                self.goViewControllerBlock(viewController);
            }
        }];
        
        // 图片
        UIImageView *imgView = [UIImageView new];
        imgView.userInteractionEnabled = NO;
        imgView.image = [UIImage imageNamed:i == 0 ? @"PersonalVisits" : @"PersonalConsulting"];
        [button addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button);
            make.top.equalTo(@20);
            make.width.height.equalTo(@25);
        }];
        
        // 文字
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = i == 0 ? @"出诊计划" : @"付费咨询";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.mas_bottom).equalTo(@10);
            make.left.right.equalTo(button);
            make.height.equalTo(@15);
        }];
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(14, 20, 100, 30)];
    title.text = @"工作室";
    title.textColor = kMainTextColor;
    title.font = kFontRegular(16);
    [self.contentView addSubview:title];
    
    UIView *lineView = [UILabel new];
    lineView.backgroundColor = kLineColor;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@55);
        make.bottom.equalTo(@-15);
        make.width.equalTo(@0.5);
        make.centerX.equalTo(self.contentView);
    }];
}

@end
