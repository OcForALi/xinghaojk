//
//  EditUserInfoViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "EditUserInfoViewController.h"

@interface EditUserInfoViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation EditUserInfoViewController
@synthesize textField;

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupSubviews];
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
     
        @strongify(self);
        [self.view endEditing:YES];
        
        if ([self.title isEqualToString:@"身份证号"]) {
            
            if ([self cly_verifyIDCardString:self.textField.text]) {
                
                [self save];
                
            }
            else {
                [self.view makeToast:@"请输入正确的身份证号"];
            }
            
        }else{
        
            if (self.textField.text.length > 8) {
                
                [self.view makeToast:@"昵称不可超过8位"];
            }
            else {
                
                [self save];
            }
            
        }
        
    }];
}

- (void)setupSubviews {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.y, ScreenWidth, 45)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, bgView.height)];
    textField.font = [UIFont systemFontOfSize:14];
    if ([self.title isEqualToString:@"身份证号"]) {
        textField.placeholder = @"请输入您的身份证号";
    }else{
        textField.placeholder = @"请输入您的真实姓名";
    }
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.text = self.text;
    [bgView addSubview:textField];
    
    if (self.placeholderString.length > 0) {
        self.textField.placeholder = self.placeholderString;
    }

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0.5)];
    line.backgroundColor = kLineColor;
    [bgView addSubview:line];
}

- (void)save {
    
    if (self.completeBlock) {
        self.completeBlock(textField.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)cly_verifyIDCardString:(NSString *)idCardString {
    
    idCardString = [idCardString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:idCardString];
    if (!isRe) {
        //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [idCardString substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [idCardString.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}

@end
