//
//  SearchView.m
//  AFNetworking
//
//  Created by M on 2018/5/5.
//

#import "SearchView.h"

@interface SearchView ()

@property (nonatomic, strong) NSString *searchTextString;

@end

@implementation SearchView
@synthesize textField;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    
    self.backgroundColor = [UIColor whiteColor];

    // 搜索按钮
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(@80);
    }];
    
    // 搜索按钮点击事件
    @weakify(self);
    [[self.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        
        if (self.searchConfirm) {
            self.searchConfirm(textField.text);
        }
        
        [self.textField resignFirstResponder];
    }];
    
    // 搜索背景
    UIView *searchBgView = [UIView new];
    searchBgView.backgroundColor = kPageBgColor;
    searchBgView.layer.cornerRadius = 5;
    searchBgView.layer.masksToBounds = YES;
    searchBgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    searchBgView.layer.borderWidth = 0.5;
    [self addSubview:searchBgView];
    
    [searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kCellSpacing));
        make.right.equalTo(self.searchBtn.mas_left);
        make.top.equalTo(@10);
        make.bottom.equalTo(@-10);
    }];
    
    // 图标
    UIImageView *iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchImg"]];
    [searchBgView addSubview:iconImgView];
    [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchBgView);
        make.left.equalTo(@10);
        make.width.height.equalTo(@15);
    }];
    
    // 输入框
    textField = [UITextField new];
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = @"搜索关键词";
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [searchBgView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImgView.mas_right).equalTo(@10);
        make.right.equalTo(searchBgView).equalTo(@-10);
        make.top.bottom.equalTo(searchBgView);
    }];
    
    [[textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        self.searchTextString = x;
        if (self.searchBlock) {
            self.searchBlock(self.searchTextString);
        }
    }];
}

- (void)setupSearchWord:(NSString *)word {
    if (word && word.length > 0) {
        textField.text = word;
        self.searchTextString = word;
    }
}

@end
