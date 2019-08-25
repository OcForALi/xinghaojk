//
//  PatientsDetailsCell.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/12.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "PatientsDetailsCell.h"

@interface PatientsDetailsCell ()

@property (nonatomic, strong) UIImageView *bgImgView;
/// 时间
@property (nonatomic, strong) UILabel *timeLabel;
/// 天数
@property (nonatomic, strong) UILabel *dayLabel;
/// 订单类型
@property (nonatomic, strong) UILabel *orderTypeLabel;
/// 医院
@property (nonatomic, strong) UILabel *hospitalLabel;
/// 科室
@property (nonatomic, strong) UILabel *departmentLabel;
/// 医师
@property (nonatomic, strong) UILabel *doctorLabel;
/// 月份
@property (nonatomic, strong) UILabel *yearLabel;
/// 是否显示月份
@property (nonatomic, strong) NSString *cellState;
// 编辑
@property (nonatomic, strong) UIImageView *editImg;

@property (nonatomic, strong) UIScrollView *scrollView;

#pragma mark 患者发送的
/// 用户发送内容
@property (nonatomic, strong) UILabel *userSendLabel;
/// 是否用户发送
@property (nonatomic, assign) BOOL isUserSend;
/// 图片数量
@property (nonatomic, assign) NSInteger imgCount;

@end

@implementation PatientsDetailsCell
@synthesize bgImgView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWidth);
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.isUserSend = YES;
        self.imgCount = [[reuseIdentifier componentsSeparatedByString:@"imgCount"][1] intValue];

        if ([reuseIdentifier containsString:@"001"]) {
            self.cellState = @"001";
        }
        else if ([reuseIdentifier containsString:@"01"]) {
            self.cellState = @"01";
        }
        
        if ([reuseIdentifier containsString:@"type1"]) {
            self.isUserSend = NO;
        }
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    // 天数
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 15, 12)];
    self.dayLabel.text = @"28日";
    self.dayLabel.font = [UIFont systemFontOfSize:11];
    self.dayLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.dayLabel.width = [self.dayLabel getTextWidth];
    [self.contentView addSubview:self.dayLabel];
    
    // 时间
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.dayLabel.frame) + 10, 40, 15)];
    self.timeLabel.text = @"10:00";
    self.timeLabel.font = [UIFont boldSystemFontOfSize:13];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.timeLabel.height = [self.timeLabel getTextHeight];
    [self.contentView addSubview:self.timeLabel];
    
    // 显示
    if (self.cellState.length > 0) {
        
        // 月份
        self.yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 0, 20)];
        self.yearLabel.text = @"2018年XX月";
        self.yearLabel.font = [UIFont systemFontOfSize:12];
        self.yearLabel.textColor = [UIColor whiteColor];
        self.yearLabel.backgroundColor = kMainColor;
        self.yearLabel.textAlignment = NSTextAlignmentCenter;
        self.yearLabel.layer.cornerRadius = 3;
        self.yearLabel.layer.masksToBounds = YES;
        self.yearLabel.width = [self.yearLabel getTextWidth] + 10;
        self.yearLabel.x = (CGRectGetMaxX(self.timeLabel.frame) + 10) - self.yearLabel.width / 2;
        self.yearLabel.y = [self.cellState isEqualToString:@"001"] ? 15 : 0;
        [self.contentView addSubview:self.yearLabel];
        
        self.dayLabel.y = CGRectGetMaxY(self.yearLabel.frame) + 15;
        self.timeLabel.y = CGRectGetMaxY(self.dayLabel.frame) + 10;
    }
    
    // 背景
    UIImage *bgImg = [UIImage imageNamed:@"msgBgImg"];
    bgImgView = [[UIImageView alloc] initWithImage:bgImg];
    bgImgView.x = CGRectGetMaxX(self.timeLabel.frame) + 20;
    bgImgView.y = self.dayLabel.y - 3;
    bgImgView.width = ScreenWidth - 10 - bgImgView.x;
    bgImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:bgImgView];
    
    // 编辑按钮
    UIImage *editImg = [UIImage imageNamed:@"Patients_Editor"];
    self.editImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
    self.editImg.x = bgImgView.width - editImg.size.width - 10;
    self.editImg.size = editImg.size;
    self.editImg.image = editImg;
    self.editImg.hidden = !self.isUserSend;
    [bgImgView addSubview:self.editImg];
    
    // 按钮类型
    self.orderTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 0, 20)];
    self.orderTypeLabel.text = @"系统保存处方";
    self.orderTypeLabel.font = [UIFont systemFontOfSize:12];
    self.orderTypeLabel.textColor = [UIColor redColor];
    self.orderTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.orderTypeLabel.layer.cornerRadius = 5;
    self.orderTypeLabel.layer.borderColor = [[UIColor redColor] CGColor];
    self.orderTypeLabel.layer.borderWidth = 0.5;
    self.orderTypeLabel.width = [self.orderTypeLabel getTextWidth] + 20;
    [bgImgView addSubview:self.orderTypeLabel];
    
    if (self.isUserSend) {
        self.orderTypeLabel.hidden = YES;
        self.orderTypeLabel.frame = CGRectMake(0, 5, 0, 0);
    }
    
    // 医院
    self.hospitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.orderTypeLabel.frame) + 10, bgImgView.width - 30, 15)];
    self.hospitalLabel.text = @"中山大学附属第三医院";
    self.hospitalLabel.font = [UIFont systemFontOfSize:14];
    self.hospitalLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [bgImgView addSubview:self.hospitalLabel];
    
    // 科室
    self.departmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.hospitalLabel.frame) + 10, bgImgView.width - 30, 15)];
    self.departmentLabel.text = @"科室";
    self.departmentLabel.font = [UIFont systemFontOfSize:14];
    self.departmentLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [bgImgView addSubview:self.departmentLabel];

    // 医师
    self.doctorLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.departmentLabel.frame) + 10, bgImgView.width - 30, 15)];
    self.doctorLabel.text = @"医师";
    self.doctorLabel.font = [UIFont systemFontOfSize:14];
    self.doctorLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [bgImgView addSubview:self.doctorLabel];
    
    
#pragma mark 患者发送的
    // 用户发送的东西
    self.userSendLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.doctorLabel.frame) + 10, bgImgView.width - 30, 15)];
    self.userSendLabel.text = @"用户发送的";
    self.userSendLabel.font = [UIFont systemFontOfSize:14];
    self.userSendLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    self.userSendLabel.numberOfLines = 0;
    self.userSendLabel.hidden = !self.isUserSend;
    self.userSendLabel.height = [self.userSendLabel getTextHeight];
    [bgImgView addSubview:self.userSendLabel];
    
    UIImageView *imgView;
    CGFloat imgWidth = (ScreenWidth - 40) / 4;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.userSendLabel.frame) + 10, bgImgView.width-10, imgWidth)];
    self.scrollView.showsHorizontalScrollIndicator = YES;
    [bgImgView addSubview:self.scrollView];
    for (int i = 0; i < self.imgCount; i++) {
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake((imgWidth + 10) * i, 0, imgWidth, imgWidth)];
        imgView.tag = i + 500;
        imgView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imgView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchShowImage:)];
        [imgView addGestureRecognizer:tap];
    }
    
    // 获取Cell高度
    if (self.isUserSend) {
        
        CGFloat imgHeight = self.imgCount > 0 ? imgWidth + 10 : 0;
        bgImgView.height = CGRectGetMaxY(self.userSendLabel.frame) + 15 + imgHeight;
    }
    else {
        
        bgImgView.height = CGRectGetMaxY(self.doctorLabel.frame) + 15;
    }
    
    self.cellHeight = CGRectGetMaxY(bgImgView.frame) + 15;
}

- (void)drawRect:(CGRect)rect {
    
    int y = 0;
    if ([self.cellState isEqualToString:@"001"]) {
        y = 15;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"0xdadada"].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMaxX(self.timeLabel.frame) + 10, y);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.timeLabel.frame) + 10, self.frame.size.height);
    CGContextStrokePath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + 5, self.dayLabel.y, 10, 10));
    [[UIColor colorWithHexString:@"0xc13a44"] set];
    CGContextFillPath(context);
}

- (void)setDataDict:(NSDictionary *)dataDict {
    
    _dataDict = dataDict;
    
    if (self.cellState.length > 0) {
        self.yearLabel.text = dataDict[@"year_month"];
    }
    
    PatientsVisitDetailsModel *model = dataDict[@"model"];
    NSArray *imgs = (NSArray *)model.files;
    self.imgs = imgs;
    self.hospitalLabel.text = model.hospital_name;
    self.departmentLabel.text = model.cust_name;
    self.doctorLabel.text = model.doctor_name;
    self.dayLabel.text = model.rcd_time_d;
    self.timeLabel.text = model.rcd_time_hm;
    CGFloat imgWidth = (ScreenWidth - 40) / 4;
    self.scrollView.contentSize = CGSizeMake(imgWidth*imgs.count, imgWidth);
    
    if (self.isUserSend) {
        
        UIImageView *imgView;
        for (int i = 0; i < self.imgCount; i++) {
            
            imgView = [self viewWithTag:i + 500];
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgs[i]]];
        }
        
        self.userSendLabel.text = model.content;
        self.userSendLabel.height = [self.userSendLabel getTextHeight];
        
        CGFloat imgHeight = self.imgCount > 0 ? imgView.height + 10 : 0;
        self.bgImgView.height = CGRectGetMaxY(self.userSendLabel.frame) + 15 + imgHeight;
        self.cellHeight = CGRectGetMaxY(self.bgImgView.frame) + 15;
    }
}

- (void)touchShowImage:(UITapGestureRecognizer *)tap {
    if (self.patientsDetailRecordImageBlock) {
        NSInteger index = tap.view.tag - 500;
        PatientsVisitDetailsModel *model = self.dataDict[@"model"];
        self.patientsDetailRecordImageBlock(model, index);
    }
}

@end
