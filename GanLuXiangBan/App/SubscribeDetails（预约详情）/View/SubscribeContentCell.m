//
//  SubscribeContentCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/17.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "SubscribeContentCell.h"
#import "SDPhotoBrowser.h"

@interface SubscribeContentCell () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSArray *tempImgs;

@end

@implementation SubscribeContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, 15, ScreenWidth, 15)];
    self.titleLabel.text = @"病情描述";
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellSpacing, 15, 0, 15)];
    self.contentLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 10;
    self.contentLabel.width = ScreenWidth - self.contentLabel.x * 2;
    self.contentLabel.text = @"内容";
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
}

- (void)setModel:(SubscribeDetailsModel *)model {
    
    if (model == _model) {
        return;
    }
    
    _model = model;
    
    self.contentLabel.text = model.disease_desc;
    self.contentLabel.height = [self.contentLabel getTextHeight];
    self.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 15;

    if ([model.files count] > 0) {
        
        NSMutableArray *imgs = [NSMutableArray array];
        for (NSDictionary *dict in model.files) {
            [imgs addObject:dict[@"file_path"]];
        }
        self.tempImgs = imgs;
        
        CGFloat imgWidth = (ScreenWidth - 40) / 4;
        for (int i = 0; i < imgs.count; i++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (imgWidth + 10) * i, self.cellHeight - 5, imgWidth, imgWidth)];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds = YES;
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgs[i]]];
            [self.contentView addSubview:imgView];
            
            UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
            [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
                
                SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
                photoBrowser.delegate = self;
                photoBrowser.currentImageIndex = 0;
                photoBrowser.imageCount = self.tempImgs.count;
                photoBrowser.sourceImagesContainerView = self.contentView;
                [photoBrowser show];
                
            }];
            [imgView addGestureRecognizer:tap];
        }
        
        self.cellHeight += imgWidth + 10;
    }
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return nil;
}
#pragma mark - SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    return [NSURL URLWithString:self.tempImgs[index]];
}

@end
