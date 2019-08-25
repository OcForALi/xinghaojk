//
//  GroupHeadImgCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/9.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "GroupHeadImgCell.h"

@interface GroupHeadImgCell ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGRect imgFrame;
@property (nonatomic, assign) CGRect titleFrame;

@end

@implementation GroupHeadImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = YES;
    [self.contentView addSubview:self.scrollView];

    self.imgFrame = CGRectMake(15, 15, self.scrollView.width / 4 - 30, self.scrollView.width / 4 - 30);
    self.titleFrame = CGRectMake(0, CGRectGetMaxY(self.imgFrame) + 10, self.scrollView.width / 4, 15);
    self.scrollView.height = CGRectGetMaxY(self.titleFrame) + self.imgFrame.origin.y;
    self.groupHeadImgCellHeight = self.scrollView.height;
}

- (void)setIsShowDel:(BOOL)isShowDel {
    
    _isShowDel = isShowDel;
    for (int i = 0; i < self.imgUrls.count; i++) {
        [[self viewWithTag:i + 1000] setHidden:!isShowDel];
    }
}

- (void)setImgUrls:(NSArray *)imgUrls {
    
    if (imgUrls == self.imgUrls) {
        return;
    }
    
    _imgUrls = imgUrls;
    for (UIView *subview in self.scrollView.subviews) {
        [subview removeFromSuperview];
    }
    
    for (int i = 0; i < imgUrls.count; i++) {
        
        GroupAddModel *model = imgUrls[i];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width / 4 * i, 0, self.scrollView.width / 4, self.scrollView.height)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:bgView];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.imgFrame];
        imgView.layer.borderColor = [[UIColor colorWithHexString:@"0xc6c6c6"] CGColor];
        imgView.layer.borderWidth = 0.5;
        imgView.layer.cornerRadius = imgView.height / 2;
        imgView.layer.masksToBounds = YES;
        [bgView addSubview:imgView];
        
        UIImage *place = [UIImage imageNamed:@"userHeader"];
        if (model.head) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:place];
        }
        else {
            imgView.image = place;
        }

        UIImage *delBtnImg = [UIImage imageNamed:@"TreatmentDeleteImg"];
        UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        delBtn.backgroundColor = [UIColor redColor];
        delBtn.frame = CGRectMake(CGRectGetMaxX(imgView.frame) - 7.5, imgView.y - 7.5, 15, 15);
        delBtn.layer.cornerRadius = delBtn.height / 2;
        delBtn.layer.masksToBounds = YES;
        delBtn.hidden = YES;
        delBtn.tag = i + 1000;
        [delBtn setImage:delBtnImg forState:UIControlStateNormal];
        [bgView addSubview:delBtn];
        
        @weakify(self);
        [[delBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            self.delImgBlock(delBtn.tag - 1000);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.titleFrame];
        titleLabel.text = model.patient_name;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:titleLabel];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width / 4 * imgUrls.count, 0);
}



@end
