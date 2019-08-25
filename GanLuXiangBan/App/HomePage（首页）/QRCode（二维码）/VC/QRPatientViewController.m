//
//  QRPatientViewController.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/25.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "QRPatientViewController.h"
#import "InvitationContactViewController.h"

@interface QRPatientViewController ()

@end

@implementation QRPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    
}

-(void)setModel:(HomeModel *)model{
    
    _model = model;
    
}

-(void)initUI{
    
    UIImageView *imageView = [UIImageView new];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.drinfoModel.qrcode]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:imageView];
    
    imageView.sd_layout
    .leftSpaceToView(self.view, 40)
    .rightSpaceToView(self.view, 40)
    .topSpaceToView(self.view, 15)
    .heightEqualToWidth();
    
    UIView * doctView = [UIView new];
    doctView.backgroundColor = RGB(241, 241, 241);
    doctView.layer.borderWidth = 1;
    doctView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:doctView];
    
    doctView.sd_layout
    .topSpaceToView(imageView, -1)
    .widthRatioToView(imageView, 1)
    .centerXEqualToView(self.view)
    .heightIs(60);
    
    UIImageView *headImageView = [UIImageView new];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:GetUserDefault(UserHead)] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
    [doctView addSubview:headImageView];
    
    headImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    
    headImageView.sd_layout
    .leftSpaceToView(doctView, 15)
    .bottomSpaceToView(doctView, 10)
    .topSpaceToView(doctView, 10)
    .widthEqualToHeight();
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = GetUserDefault(UserName);
    nameLabel.font = [UIFont systemFontOfSize:14];
    [doctView addSubview:nameLabel];
    
    nameLabel.sd_layout
    .leftSpaceToView(headImageView, 15)
    .topSpaceToView(doctView, 10)
    .heightIs(14);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = @"微信扫一扫，加我吧！";
    subTitleLabel.textColor = [UIColor lightGrayColor];
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    [doctView addSubview:subTitleLabel];
    
    subTitleLabel.sd_layout
    .leftSpaceToView(headImageView, 15)
    .bottomSpaceToView(doctView, 10)
    .heightIs(12);
    [subTitleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    UILabel *invitationLabel = [UILabel new];
    invitationLabel.text = @"添加手机联系人";
    invitationLabel.textColor = kMainColor;
    invitationLabel.font = [UIFont systemFontOfSize:18];
    invitationLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initation:)];
    [invitationLabel addGestureRecognizer:tap];
    [self.view addSubview:invitationLabel];
    
    invitationLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(doctView, 40)
    .heightIs(18);
    [invitationLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
}

-(void)initation:(UITapGestureRecognizer *)sender{
    
    InvitationContactViewController *invitationView = [[InvitationContactViewController alloc] init];
    [self.navigationController pushViewController:invitationView animated:YES];
    
}

@end
