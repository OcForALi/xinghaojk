//
//  AddCardViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AddCardViewController.h"
#import "AddCardView.h"
#import "MyCardViewModel.h"

@interface AddCardViewController ()

@property (nonatomic, strong) AddCardView *addCardView;

@end

@implementation AddCardViewController
@synthesize addCardView;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"添加银行卡";
    [self getBankList];
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
        
        @strongify(self);
        [self addBankCard];
    }];
}

#pragma mark - request
- (void)getBankList {
    
    [[MyCardViewModel new] getAllBankComplete:^(id object) {
        self.addCardView.bankList = object;
    }];
}

- (void)addBankCard {
    
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 3; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        AddCardCell *cell = [self.addCardView cellForRowAtIndexPath:indexPath];
        if (cell.textFieldText.text.length > 0 && ![cell.textFieldText.text isEqualToString:@"请选择对应的银行"]) {
            [arr addObject:cell.textFieldText.text];
        }
        else {
            
            if (i == 1) {
                return [self.view makeToast:@"请选择银行"];
            }
            else if (i == 2) {
                return [self.view makeToast:@"请填写银行卡"];
            }
        }
    }
    
    if (![self deptNumInputShouldNumber:arr[2]]) {
        return [self.view makeToast:@"不可输入数字以外的字段"];
    }
    
    @weakify(self);
    [[MyCardViewModel new] addBankWithCardperson:arr[0] bank:arr[1] cardNumber:arr[2] complete:^(id object) {
     
        @strongify(self);
        [[UIApplication sharedApplication].keyWindow makeToast:object];
        if ([object isEqualToString:@"添加成功"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (BOOL)deptNumInputShouldNumber:(NSString *)str {
    
    if (str.length == 0) {
        return NO;
    }
    
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

#pragma makr - lazy
- (AddCardView *)addCardView {
    
    if (!addCardView) {
        
        addCardView = [[AddCardView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:addCardView];
    }
    
    return addCardView;
}

@end
