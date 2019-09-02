//
//  CertificationCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CertificationCell.h"

@interface CertificationCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CertificationCell
@synthesize titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    // 图片
    self.userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, ScreenWidth - 50, 0)];
    self.userImgView.backgroundColor = [UIColor colorWithHexString:@"0xd5eafa"];
    self.userImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.userImgView.clipsToBounds = YES;
    self.userImgView.userInteractionEnabled = YES;
    self.userImgView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.userImgView];
    
    @weakify(self);
    [RACObserve(self.userImgView, image) subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        if (self.userImgView.image != nil) {
            
            for (UIView *subview in self.userImgView.subviews) {
                subview.hidden = YES;
            }
        }
    }];
    
    // 相机图标
    UIImage *cameraImg = [UIImage imageNamed:@"UserInfoCameraImg"];
    UIImageView *cameraImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, cameraImg.size.width, cameraImg.size.height)];
    cameraImgView.centerX = self.userImgView.width / 2;
    cameraImgView.image = cameraImg;
    [self.userImgView addSubview:cameraImgView];
    
    // 提示
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cameraImgView.frame) + 25, self.userImgView.width, 0)];
    titleLabel.text = @"添加工作证";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = kMainColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.height = [titleLabel getTextHeight];
    [self.userImgView addSubview:titleLabel];
    
    UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 15, titleLabel.width, 0)];
    instructionsLabel.text = @"请提供有效的工作证照片";
    instructionsLabel.font = [UIFont systemFontOfSize:14];
    instructionsLabel.textColor = [UIColor colorWithHexString:@"0x919191"];
    instructionsLabel.textAlignment = NSTextAlignmentCenter;
    instructionsLabel.height = [titleLabel getTextHeight];
    [self.userImgView addSubview:instructionsLabel];
    
    self.userImgView.height = CGRectGetMaxY(instructionsLabel.frame) + 15;
}

- (void)setText:(NSString *)text {
    
    _text = text;
    self.titleLabel.text = text;
}

@end
