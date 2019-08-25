//
//  FamousDetailViewController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/1.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "FamousDetailViewController.h"

#import "FamousRequest.h"
#import "FamousDetailView.h"

@interface FamousDetailViewController ()
@property (nonatomic, strong) FamousDetailView *tableView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *hospitalLabel;
@end

@implementation FamousDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"名医详情";
    [self setupViews];
    
    if (self.model && self.model.name) {
        [self showDoctorInfo];
    }
    [self queryDoctorDetail];
}

- (void)queryDoctorDetail {
    NSString *doctorId = [NSString stringWithFormat:@"%@", @(self.model.drid)];
    WS(weakSelf)
    [[FamousRequest new] detail:doctorId complete:^(HttpGeneralBackModel * _Nonnull generalBackModel) {
        
        if (generalBackModel && generalBackModel.data) {
            FamousModel *model = [FamousModel new];
            [model setValuesForKeysWithDictionary:generalBackModel.data];
            if (model) {
                weakSelf.model = model;
                [weakSelf showDoctorInfo];
            }
        }
        
    }];
}

- (void)showDoctorInfo {
    if (self.model.head) {
        UIImage *place = [UIImage imageNamed:@"userHeader"];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.head] placeholderImage:place];
    }
    self.nameLabel.text = self.model.name;
    NSString *info = self.model.title ? self.model.title : @"";
    if (self.model.cust_name) {
        info = [info stringByAppendingFormat:@"    %@", self.model.cust_name];
    }
    self.infoLabel.text = info;
    self.hospitalLabel.text = self.model.hospital_name;
    
    FamousGroupModel *one = [[FamousGroupModel alloc] init];
    one.name = @"医生擅长";
    one.info = [self stringNotNull:self.model.remark] ? self.model.remark : @"暂无医生擅长";
    one.expand = YES;
    FamousGroupModel *two = [[FamousGroupModel alloc] init];
    two.name = @"医生简介";
    two.info = [self stringNotNull:self.model.introduction] ? self.model.introduction : @"暂无医生简介";
    two.expand = YES;
    self.tableView.dataSources = @[one, two];
}

- (BOOL)stringNotNull:(id)str {
    if (str && [str isKindOfClass:NSString.class]) {
        NSString *ss = (NSString *)str;
        return ss.length > 0;
    }
    return NO;
}

- (void)setupViews {
    self.tableView = [[FamousDetailView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    //initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = kMainColor;
    
    UIImage *place = [UIImage imageNamed:@"userHeader"];
    self.iconView = [[UIImageView alloc] init];
    self.iconView.image = place;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 40;
    [headerView addSubview:self.iconView];
    self.iconView.sd_layout.topSpaceToView(headerView, 20).widthIs(80).heightEqualToWidth().centerXEqualToView(headerView);
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = kFontRegular(18);
    [headerView addSubview:self.nameLabel];
    self.nameLabel.sd_layout.topSpaceToView(self.iconView, 10).widthIs(200).heightIs(30).centerXEqualToView(headerView);
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    self.infoLabel.font = kFontRegular(14);
    [headerView addSubview:self.infoLabel];
    self.infoLabel.sd_layout.topSpaceToView(self.nameLabel, 0).widthIs(200).heightIs(20).centerXEqualToView(headerView);
    
    self.hospitalLabel = [[UILabel alloc] init];
    self.hospitalLabel.textAlignment = NSTextAlignmentCenter;
    self.hospitalLabel.font = kFontRegular(14);
    [headerView addSubview:self.hospitalLabel];
    self.hospitalLabel.sd_layout.topSpaceToView(self.infoLabel, 0).widthIs(200).heightIs(20).centerXEqualToView(headerView);
    
    self.tableView.tableHeaderView = headerView;
    headerView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    [headerView setupAutoHeightWithBottomView:self.hospitalLabel bottomMargin:10];
}

@end
