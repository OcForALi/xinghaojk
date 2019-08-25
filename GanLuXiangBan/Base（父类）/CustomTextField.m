//
//  CustomTextField.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/8.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField ()

@property (nonatomic, strong) UIButton *captchaBtn;

@end

@implementation CustomTextField
@synthesize textField;
@synthesize imgView;

- (instancetype)initWithFrame:(CGRect)frame leftImg:(NSString *)imgString isCaptcha:(BOOL)isCaptcha {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor colorWithHexString:@"0xdfdfdf"] CGColor];
        
        // 图标
        imgView = [UIImageView new];
        [self addSubview:imgView];
        
        if (imgString.length > 0) {
            imgView.image = [UIImage imageNamed:imgString];
        }
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@10);
            make.width.height.equalTo(@20);
        }];
        
        // 验证码按钮
        self.captchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.captchaBtn.hidden = !isCaptcha;
        self.captchaBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.captchaBtn.layer setMasksToBounds:YES];
        [self.captchaBtn.layer setCornerRadius:5.0];
        [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.captchaBtn setBackgroundColor:RGB(255, 145, 0)];
        [self addSubview:self.captchaBtn];
        
        [self.captchaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@-10);
            make.height.equalTo(@35);
            make.width.equalTo(@100);
        }];
        
        // 发送验证码
        WS(weakSelf);
        [[self.captchaBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
            if (weakSelf.captchaBlock) {
                weakSelf.captchaBlock();
            }
        }];
        
        // 文本框
        textField = [UITextField new];
        textField.font = [UIFont systemFontOfSize:14];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.keyboardType = isCaptcha ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
        [self addSubview:textField];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.bottom.equalTo(self);
            
            if (imgString.length > 0) {
                make.left.equalTo(self.imgView.mas_right).equalTo(@5);
            }
            else {
                make.left.equalTo(@10);
            }
            
            if (isCaptcha) {
                make.right.equalTo(self.captchaBtn.mas_left).equalTo(@-5);
            }
            else {
                make.right.equalTo(@-5);
            }
        }];
        
        [[textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
           
            if (isCaptcha) {
                
                if (x.length > 6) {
                    
                    weakSelf.textField.text = [x substringToIndex:6];
                    [weakSelf makeToast:@"验证码不得超过6位"];
                }
            }
            
            weakSelf.text = weakSelf.textField.text;
        }];
    }
    
    return self;
}

// 开启倒计时效果
- (void)openCountdown {
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(timer, ^{
        
        if (time <= 0) {
            
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.captchaBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self.captchaBtn.userInteractionEnabled = YES;
                [self.captchaBtn setBackgroundColor: RGB(255, 145, 0)];
                
            });
            
        }
        else {
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.captchaBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                self.captchaBtn.userInteractionEnabled = NO;
                [self.captchaBtn setBackgroundColor: [UIColor lightGrayColor]];
            });
            
            time--;
        }
    });
    
    dispatch_resume(timer);
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    textField.placeholder = placeholder;
}

- (void)setFont:(UIFont *)font {
    
    _font = font;
    textField.font = font;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    
    _keyboardType = keyboardType;
    textField.keyboardType = keyboardType;
}

- (void)setCaptchaBgColor:(UIColor *)captchaBgColor {
    [self.captchaBtn setBackgroundColor:captchaBgColor];
}

@end
