//
//  PersonalView.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PersonalView.h"
#import "PersonalInfoCell.h"

#define HeaderHeight 200

@interface PersonalView ()

@property (nonatomic, assign) float cellHeight;

@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, strong) UIButton *headBgView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *headImgView;

@end

@implementation PersonalView
@synthesize headBgView;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self registerClass:[PersonalInfoCell class] forCellReuseIdentifier:@"PersonalInfoCell"];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self insertSubview:self.headBgView atIndex:0];
        
        self.imgs = @[@"PersonalBankCard", @"PersonAlassistant", @"PersonSetting"];
        self.dataSources = @[@"银行卡", @"联系客服", @"设置"];
    }
    
    return self;
}


- (void)setModel:(PersonalModel *)model {
    
    _model = model;
    
    [self reloadData];
}

#pragma mark - lazy

- (UILabel *)setupLabel:(NSString *)title type:(NSInteger)type view:(UIView *)view {
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFontRegular(14);
    label.textColor = type == 1 ? kMainTextColor : kSixColor;
    label.text = title;
    [view addSubview:label];
    return label;
}

- (UIView *)headBgView {
    
    if (!headBgView) {
        
        headBgView = [UIButton buttonWithType:UIButtonTypeCustom];
        headBgView.frame = CGRectMake(0, -HeaderHeight, ScreenWidth, HeaderHeight);
        headBgView.backgroundColor = kMainColor;
        
        @weakify(self);
        [[headBgView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            @strongify(self);
            if (self.goViewControllerBlock) {
                self.goViewControllerBlock([NSClassFromString(@"PersonalInfoViewController") new]);
            }
        }];
        
        // 用户头像
        self.headImgView = [UIImageView new];
        self.headImgView.layer.cornerRadius = 40;
        self.headImgView.layer.masksToBounds = YES;
        self.headImgView.userInteractionEnabled = NO;
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:GetUserDefault(UserHead)] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
        [self.headBgView addSubview:self.headImgView];
        [self.headImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headBgView);
            make.centerY.equalTo(self.headBgView);
            make.height.width.equalTo(@80);
        }];

        
        // 用户昵称
        self.userNameLabel = [UILabel new];
        self.userNameLabel.font = [UIFont boldSystemFontOfSize:17];
        self.userNameLabel.textAlignment = NSTextAlignmentCenter;
        self.userNameLabel.textColor = [UIColor whiteColor];
        self.userNameLabel.text = GetUserDefault(UserName);
        [self.headBgView addSubview:self.userNameLabel];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.headBgView);
            make.top.equalTo(self.headImgView.mas_bottom).equalTo(@(25));
            make.height.equalTo(@15);
        }];
        
        UIImageView *edit = [[UIImageView alloc] init];
        edit.image = [UIImage imageNamed:@"me_edit"];
        [headBgView addSubview:edit];
        [edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.bottom.equalTo(self.headImgView.mas_bottom);
            make.left.equalTo(self.headImgView.mas_right);
        }];

        self.contentInset = UIEdgeInsetsMake(HeaderHeight, 0, 0, 0);
    }
    
    return headBgView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    if (point.y < -HeaderHeight) {
        CGRect rect = headBgView.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        headBgView.frame = rect;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalInfoCell"];
        cell.model = self.model;
        self.cellHeight = cell.cellHeight;
        
        // 前往控制器
        [cell setGoViewControllerBlock:^(UIViewController * _Nonnull viewController) {
            self.goViewControllerBlock(viewController);
        }];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.dataSources[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.imageView.image = [UIImage imageNamed:self.imgs[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section != 0) {
        
        NSString *vcname = @"";
        NSString *text = self.dataSources[indexPath.row];
        if ([text containsString:@"银行卡"]) {
            vcname = @"MyCardViewController";
        }
        else if ([text containsString:@"设置"]) {
            vcname = @"SettingViewController";
        }
        else if ([text containsString:@"联系客服"]) {
            
            [self actionSheetWithTitle:@"客服上班时间：7*12小时（09:00-21:00）" titles:@[@"020-81978876"] isCan:YES completeBlock:^(NSInteger index) {
                
                [self reloadData];
            }];
            
            return;
        }
        
        if (vcname.length > 0 && self.goViewControllerBlock) {
            
            UIViewController *vc = [NSClassFromString(vcname) new];
            vc.title = text;
            self.goViewControllerBlock(vc);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return self.cellHeight;
    }
    
    return 45;
}

@end
