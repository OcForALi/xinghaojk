//
//  PersonalView.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PersonalView.h"
#import "VisitsRelatedCell.h"

#define HeaderHeight 280

@interface PersonalView ()

@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, strong) UIButton *headBgView;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *registerLabel;
@property (nonatomic, strong) UILabel *consultLabel;
@property (nonatomic, strong) UILabel *chargeLabel;
@property (nonatomic, strong) UILabel *prescriptionLabel;

@end

@implementation PersonalView
@synthesize headBgView;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self registerClass:[VisitsRelatedCell class] forCellReuseIdentifier:@"VisitsRelatedCell"];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self insertSubview:self.headBgView atIndex:0];
        
        self.imgs = @[@"PersonalIntegral", @"PersonalSubscribeImg", @"PersonalBankCard", @"PersonalBankCard", @"PersonalBankCard", @"PersonAlassistant", @"PersonSetting"];
        self.dataSources = @[@"工作室业绩", @"我的预约", @"患者心意", @"我开具的处方", @"银行卡", @"医生助理", @"设置"];
    }
    
    return self;
}

- (void)setModel:(PersonalInfoModel *)model {
    
    _model = model;
    
    self.userNameLabel.text = model.Name;
    self.positionLabel.text = [NSString stringWithFormat:@"%@ %@", model.CustName, model.Title];
    if (model.Auth_Status && [model.Auth_Status isEqualToString:@"2"]) {
        self.statusLabel.backgroundColor = kSixColor;
        self.statusLabel.text = @"已认证";
        self.statusLabel.textColor = [UIColor colorWithHexString:@"0xEEEEEE"];
    }
    else {
        self.statusLabel.backgroundColor = kMainColor;
        self.statusLabel.text = @"未认证";
        self.statusLabel.textColor = [UIColor whiteColor];
    }
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.Head] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
    [self reloadData];
}

- (void)setDataModel:(PersonalStaticModel *)dataModel {
    _dataModel = dataModel;
    if (dataModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.registerLabel.text = [NSString stringWithFormat:@"%@", dataModel.reg_count];
            self.consultLabel.text = [NSString stringWithFormat:@"%@", dataModel.zx_count];
            self.chargeLabel.text = [NSString stringWithFormat:@"%@", dataModel.pay_count];
            self.prescriptionLabel.text = [NSString stringWithFormat:@"%@", dataModel.recipe_count];
        });
    }
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
        
        UIView *menu = [[UIView alloc] init];
        menu.backgroundColor = [UIColor whiteColor];
        [headBgView addSubview:menu];
        [menu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(80);
        }];
        self.registerLabel = [self setupLabel:@"0" type:1 view:menu];
        self.consultLabel = [self setupLabel:@"0" type:1 view:menu];
        self.chargeLabel = [self setupLabel:@"0" type:1 view:menu];;
        self.prescriptionLabel = [self setupLabel:@"0" type:1 view:menu];
        [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        [self.consultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.registerLabel.mas_right);
            make.top.height.width.equalTo(self.registerLabel);
        }];
        [self.chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.consultLabel.mas_right);
            make.top.height.width.equalTo(self.registerLabel);
        }];
        [self.prescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.equalTo(self.chargeLabel.mas_right);
            make.top.height.width.equalTo(self.registerLabel);
        }];
        UILabel *reg = [self setupLabel:@"注册" type:0 view:menu];
        UILabel *con = [self setupLabel:@"咨询" type:0 view:menu];
        UILabel *fee = [self setupLabel:@"付费" type:0 view:menu];;
        UILabel *pre = [self setupLabel:@"处方" type:0 view:menu];
        [reg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.registerLabel.mas_bottom);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        [con mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(reg.mas_right);
            make.top.height.width.equalTo(reg);
        }];
        [fee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(con.mas_right);
            make.top.height.width.equalTo(reg);
        }];
        [pre mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.equalTo(fee.mas_right);
            make.top.height.width.equalTo(reg);
        }];
        
        // 用户属性
        self.positionLabel = [UILabel new];
        self.positionLabel.font = [UIFont systemFontOfSize:13];
        self.positionLabel.textAlignment = NSTextAlignmentCenter;
        self.positionLabel.textColor = RGBA(255, 255, 255, 0.6);
        [headBgView addSubview:self.positionLabel];
        
        [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.headBgView);
            make.bottom.equalTo(menu.mas_top).offset(-20);
            make.height.equalTo(@15);
        }];
        
        // 用户昵称
        self.userNameLabel = [UILabel new];
        self.userNameLabel.font = [UIFont boldSystemFontOfSize:17];
        self.userNameLabel.textAlignment = NSTextAlignmentCenter;
        self.userNameLabel.textColor = [UIColor whiteColor];
        self.userNameLabel.text = GetUserDefault(UserName);
        [headBgView addSubview:self.userNameLabel];
        
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.headBgView);
            make.bottom.equalTo(self.positionLabel.mas_top).equalTo(@-10);
            make.height.equalTo(@15);
        }];
        
        // 用户头像
        self.headImgView = [UIImageView new];
        self.headImgView.image = [UIImage imageNamed:@"Home_HeadDefault"];
        self.headImgView.layer.cornerRadius = 40;
        self.headImgView.layer.masksToBounds = YES;
        self.headImgView.userInteractionEnabled = NO;
        [headBgView addSubview:self.headImgView];
        
        [self.headImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headBgView);
            make.height.width.equalTo(@80);
            make.bottom.equalTo(self.userNameLabel.mas_top).equalTo(@-15);
        }];
        
        UIImageView *edit = [[UIImageView alloc] init];
        edit.image = [UIImage imageNamed:@"me_edit"];
        [headBgView addSubview:edit];
        [edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.top.equalTo(self.headImgView.mas_bottom);
            make.left.equalTo(self.headImgView.mas_right);//.offset(-20);
        }];
        
        self.contentInset = UIEdgeInsetsMake(HeaderHeight, 0, 0, 0);
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.backgroundColor = kMainColor;
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        self.statusLabel.font = kFontRegular(15);
        self.statusLabel.layer.masksToBounds = YES;
        self.statusLabel.layer.cornerRadius = 6;
        [headBgView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.right.mas_equalTo(8);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(30);
        }];
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
        
        VisitsRelatedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitsRelatedCell"];
        [cell setGoViewControllerBlock:^(UIViewController *viewController) {
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
        
        NSArray *viewControllers = @[@"MyPointsViewController", @"SubscribeViewController", @"MyGiftController", @"MyPrescriptionController", @"MyCardViewController", @"AssistantViewController", @"SettingViewController"];
        
        BaseViewController *viewController = [NSClassFromString(viewControllers[indexPath.row]) new];
        viewController.title = self.dataSources[indexPath.row];
        self.goViewControllerBlock(viewController);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return VisitsRelatedCellHeight;
    }
    
    return 45;
}

@end
