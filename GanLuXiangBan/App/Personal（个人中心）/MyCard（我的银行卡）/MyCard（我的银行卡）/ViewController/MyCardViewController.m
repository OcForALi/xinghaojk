//
//  MyCardViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MyCardViewController.h"
#import "MyCardView.h"
#import "MyCardViewModel.h"

@interface MyCardViewController ()

@property (nonatomic, strong) MyCardViewModel *viewModel;
@property (nonatomic, strong) MyCardView *myCardView;
@property (nonatomic, strong) UIButton *addCardBtn;

@end

@implementation MyCardViewController
@synthesize myCardView;
@synthesize addCardBtn;
@synthesize viewModel;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"我的银行卡";
    
    [self setEditRightTitle];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getList];
}

- (void)setEditRightTitle {
    
    @weakify(self);
    [self addNavRightTitle:@"编辑" complete:^{
        
        @strongify(self);
        [self setSaveRightTitle];
        [self.myCardView setIsEdit:YES];
        
        [UIView animateWithDuration:0.3 animations:^{
           
            [self.addCardBtn setTitle:@"删除" forState:UIControlStateNormal];
            [self.addCardBtn setBackgroundColor:[UIColor colorWithHexString:@"0xc6c6c6"]];
        }];
    }];
}

- (void)setSaveRightTitle {
    
    @weakify(self);
    [self addNavRightTitle:@"保存" complete:^{
        
        @strongify(self);
        [self setEditRightTitle];
        [self.myCardView setIsEdit:NO];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.addCardBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
            [self.addCardBtn setBackgroundColor:kMainColor];
        }];
    }];
}

#pragma mark - lazy
- (MyCardViewModel *)viewModel {
    
    if (!viewModel) {
        
        viewModel = [MyCardViewModel new];
    }
    
    return viewModel;
}

- (MyCardView *)myCardView {
    
    if (!myCardView) {
        
        myCardView = [[MyCardView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.navHeight - 50) style:UITableViewStyleGrouped];
        [self.view addSubview:myCardView];
        
        // 选中银行卡
        @weakify(self);
        [self.myCardView setSelectCardBlock:^(MyCardModel *model) {
           
            @strongify(self);
            if (self.selectBackCard) {
                self.selectBackCard(model);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
        // 设为默认卡
        [self.myCardView setDefaultCardBlock:^(NSString *cardNumber) {
           
            @strongify(self);
            [self setDefaultWithId:cardNumber];
        }];
        
        // 监听
        [RACObserve(myCardView, selectArray) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [UIView animateWithDuration:0.3 animations:^{
                
                if ([self.addCardBtn.titleLabel.text isEqualToString:@"删除"]) {
                    
                    if (self.myCardView.selectArray.count > 0) {
                        [self.addCardBtn setBackgroundColor:[UIColor redColor]];
                    }
                    else {
                        [self.addCardBtn setBackgroundColor:[UIColor colorWithHexString:@"0xc6c6c6"]];
                    }
                }
            }];
        }];
        
        self.addCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addCardBtn.frame = CGRectMake(0, CGRectGetMaxY(myCardView.frame), ScreenWidth, 50);
        self.addCardBtn.backgroundColor = kMainColor;
        self.addCardBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.addCardBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [self.addCardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:self.addCardBtn];
        
        [[self.addCardBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
            NSString *titleString = self.addCardBtn.titleLabel.text;
            if ([titleString isEqualToString:@"添加银行卡"]) {
                
                [self.navigationController pushViewController:[NSClassFromString(@"AddCardViewController") new] animated:YES];
            }
            else if (self.myCardView.selectArray.count > 0) {
                
                NSMutableArray *ids = [NSMutableArray array];
                for (int i = 0; i < self.myCardView.selectArray.count; i++) {
                    
                    MyCardModel *cardModel = self.myCardView.selectArray[i];
                    [ids addObject:cardModel.pkid];
                }
                
                [self deleteBackWithIds:ids];
            }
        }];
    }
    
    return myCardView;
}

#pragma mark - request
- (void)getList {
    
    [self.viewModel getUserBankListComplete:^(id object) {
        
        if (![object isKindOfClass:[NSError class]]) {
            self.myCardView.dataSources = object;
        }
    }];
}

- (void)deleteBackWithIds:(NSArray *)ids {
    
    [self.viewModel deleteBankWithIds:ids complete:^(id object) {
        
        if (![object isKindOfClass:[NSError class]]) {
            
            self.myCardView.selectArray = @[];
            [self getList];
        }
    }];
}

- (void)setDefaultWithId:(NSString *)idString {
    
    @weakify(self);
    [self.viewModel setDefaultWithId:idString Complete:^(id object) {
    
        @strongify(self);
        [self.view makeToast:object];
        [self getList];
    }];
}

@end
