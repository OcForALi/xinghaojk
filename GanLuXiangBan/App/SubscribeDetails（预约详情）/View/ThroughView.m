

//
//  ThroughView.m
//  GanLuXiangBan
//
//  Created by M on 2018/7/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ThroughView.h"
#import "ZHPickView.h"

@interface ThroughView () <ZHPickViewDelegate>
@property (nonatomic, strong) ZHPickView *pickerView;
@property (nonatomic, strong) UITextField *addressBox;
@end

@implementation ThroughView
@synthesize pickerView;


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    UIView *tipBgview = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 0)];
    tipBgview.backgroundColor = [UIColor colorWithHexString:@"0xf3f3f3"];
    tipBgview.clipsToBounds = YES;
    tipBgview.layer.cornerRadius = 5;
    tipBgview.layer.masksToBounds = YES;
    [self addSubview:tipBgview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, tipBgview.width, 15)];
    titleLabel.text = @"通过预约";
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [tipBgview addSubview:titleLabel];
    
    NSArray *titles = @[@"出诊时间: ", @"咨询方式: "];
    
    UIButton *bgBtn;
    for (int i = 0; i < 2; i++) {
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        NSString *currentTimeString = [formatter stringFromDate:[NSDate date]];
        
        bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(15, 0, tipBgview.width - 30, 45);
        bgBtn.y = CGRectGetMaxY(titleLabel.frame) + 15 + (bgBtn.height + 1) * i;
        [tipBgview addSubview:bgBtn];
        
        @weakify(self);
        [[bgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         
            @strongify(self);
            if (self.pickerView == nil) {
                
                self.pickerView = [[ZHPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
                self.pickerView.delegate = self;
                self.pickerView.origin = CGPointMake(0, ScreenHeight);
                self.pickerView.isShow = YES;
                [self.pickerView show];
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    [UIView setAnimationBeginsFromCurrentState:YES];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                    
                    self.pickerView.origin = CGPointMake(0, self.size.height - self.pickerView.height + 60);
                }];
            }
        }];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgBtn.width, bgBtn.height)];
        titleLabel.text = titles[i];
        titleLabel.tag = 100 + i;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x3c3c3c"];
        [bgBtn addSubview:titleLabel];
        
        if (i == 1) {
            
            UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(bgBtn.width-100, 0, 100, bgBtn.height)];
            typeLabel.font = [UIFont systemFontOfSize:13];
            typeLabel.textColor = [UIColor colorWithHexString:@"0x3c3c3c"];
            typeLabel.tag = 10001;
            typeLabel.textAlignment = NSTextAlignmentRight;
            if (self.typeString && self.typeString.length > 0) {
                typeLabel.text = self.typeString;
            }
            [bgBtn addSubview:typeLabel];
        }
        else {
            
            UIImage *img = [UIImage imageNamed:@"goTime"];
            UIImageView *rightImgView = [[UIImageView alloc] initWithImage:img];
            rightImgView.size = img.size;
            rightImgView.centerY = titleLabel.centerY;
            rightImgView.x = bgBtn.width - rightImgView.width;
            [bgBtn addSubview:rightImgView];
            
            titleLabel.text = [NSString stringWithFormat:@"%@%@", titles[i], currentTimeString];
            self.dateLabel = titleLabel;
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, bgBtn.height - 0.5, bgBtn.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
        [bgBtn insertSubview:lineView atIndex:0];
    }
    
    CGFloat y = CGRectGetMaxY(bgBtn.frame);
    if (self.throughType == 3) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"出诊地点: ";
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor colorWithHexString:@"0x3c3c3c"];
        [tipBgview addSubview:titleLabel];
        titleLabel.sd_layout.topSpaceToView(bgBtn, 0).leftEqualToView(bgBtn).rightEqualToView(bgBtn).heightRatioToView(bgBtn, 1);
        
        self.addressBox = [[UITextField alloc] init];
        self.addressBox.borderStyle = UITextBorderStyleNone;
        self.addressBox.backgroundColor = tipBgview.backgroundColor;
        self.addressBox.font = kFontRegular(14);
        self.addressBox.placeholder = @"请输入";
        self.addressBox.textColor = kMainTextColor;
        self.addressBox.textAlignment = NSTextAlignmentRight;
        [tipBgview addSubview:self.addressBox];
        self.addressBox.sd_layout.topEqualToView(titleLabel).rightEqualToView(titleLabel).heightRatioToView(titleLabel, 1.0).widthRatioToView(titleLabel, 0.6);
        
        y = CGRectGetMaxY(bgBtn.frame) + bgBtn.height;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(bgBtn.left, y - 0.5, bgBtn.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
        [tipBgview addSubview:lineView];
    }
    
    // 审核按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, y + 40, tipBgview.width, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"审核" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:kMainColor];
    [tipBgview addSubview:button];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        NSString *address = self.addressBox.text;
        if (self.throughType == 3) {
            if (address && address.length > 0)
            {
                [self removeFromSuperview];
                if (self.textBlock) {
                    self.textBlock([(UILabel *)[self viewWithTag:100] text], address);
                }
            }
            else {
                [self makeToast:@"请输入出诊地点"];
            }
        }
        else {
            [self removeFromSuperview];
            if (self.textBlock) {
                self.textBlock([(UILabel *)[self viewWithTag:100] text], nil);
            }
        }
        
    }];
    
    tipBgview.height = CGRectGetMaxY(button.frame);
    tipBgview.centerY = self.centerY;
}

- (void)setTypeString:(NSString *)typeString {
    
    _typeString = typeString;
    
    UILabel *typeLabel = [self viewWithTag:10001];
    typeLabel.text = typeString;
    typeLabel.width = [typeLabel getTextWidth];
    typeLabel.x = typeLabel.superview.width - typeLabel.width;
}

- (void)setThroughType:(NSInteger)throughType {
    _throughType = throughType;
    if (throughType == 3) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self setupSubviews];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    [self toobarDonBtnHaveClick];
}


#pragma mark - ZHPickView.delegate.确认按钮
- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {
    
    UILabel *titleLabel = [self viewWithTag:100];
    resultString = [resultString substringWithRange:NSMakeRange(0, resultString.length - 3)];
    titleLabel.text = [NSString stringWithFormat:@"出诊时间: %@", resultString];

    // 关闭pickView 动画
    [UIView animateWithDuration:0.3 animations:^{
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        self.pickerView.origin = CGPointMake(0, self.size.height);
        
    } completion:^(BOOL finished) {
        
        [self.pickerView removeFromSuperview];
        self.pickerView = nil;
    }];
}

#pragma mark - ZHPickView.delegate.取消按钮
- (void)toobarDonBtnHaveClick {
    
    //关闭pickView 动画
    [UIView animateWithDuration:0.3 animations:^{
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        self.pickerView.origin = CGPointMake(0, self.size.height);
        
    } completion:^(BOOL finished) {
        
        [self.pickerView removeFromSuperview];
        self.pickerView = nil;
    }];
    
}

@end
