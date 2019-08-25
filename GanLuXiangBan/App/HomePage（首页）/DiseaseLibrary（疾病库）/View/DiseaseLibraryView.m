//
//  DiseaseLibraryView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/4.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DiseaseLibraryView.h"
#import "DiseaseLibraryTableViewCell.h"

@interface DiseaseLibraryView()
@property (nonatomic, strong) UIButton *commonButton;
@property (nonatomic, strong) UIButton *allButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation DiseaseLibraryView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = [NSMutableArray array];
        self.showType = DiseaseLibraryTypeCommon;
        [self initUI];
        
    }
    
    return self;
    
}

-(void)addData:(NSArray *)array{
    
    [self.dataSource addObjectsFromArray:array];
    
    [self.myTable reloadData];
    
}

-(void)setTypeInteger:(NSInteger)typeInteger{
    
    _typeInteger = typeInteger;
    
    [self.myTable reloadData];
    
}

- (void)touchMenButton:(UIButton *)button {
    if (![button isSelected]) {
        self.commonButton.selected = NO;
        self.allButton.selected = NO;
        button.selected = YES;
        self.lineView.centerX = button.centerX;
        self.showType = button.tag == 1 ? DiseaseLibraryTypeCommon : DiseaseLibraryTypeAll;
        if (self.changeShowTypeBlock) {
            self.changeShowTypeBlock(self.showType);
        }
    }
}

- (UIButton *)setupButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kSixColor forState:UIControlStateNormal];
    [button setTitleColor:kMainColor forState:UIControlStateSelected];
    [button.titleLabel setFont:kFontMedium(15)];
    [button addTarget:self action:@selector(touchMenButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)initUI{
    self.commonButton = [self setupButton:@"常用疾病"];
    self.commonButton.selected = YES;
    self.commonButton.tag = 1;
    [self addSubview:self.commonButton];
    [self.commonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    self.allButton = [self setupButton:@"全部"];
    self.allButton.tag = 2;
    [self addSubview:self.allButton];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.left.equalTo(self.commonButton.mas_right);
        make.width.height.equalTo(self.commonButton);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kMainColor;
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.commonButton).offset(-2);
        make.centerX.equalTo(self.commonButton);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo((ScreenWidth-80)/2);
    }];
    
    self.searchView = [SearchView new];
    self.searchView.backgroundColor = kPageBgColor;
    [self.searchView.searchBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commonButton.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.myTable];
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.equalTo(self.searchView.mas_bottom);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)cellContentViewWith{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DiseaseLibraryModel *model = self.dataSource[indexPath.row];
    // 获取cell高度
    return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DiseaseLibraryTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"DiseaseLibraryTableViewCell";

    DiseaseLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[DiseaseLibraryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.type = self.typeInteger;
    cell.model = self.dataSource[indexPath.row];
    cell.collectButton.tag = indexPath.row;
    [cell.collectButton addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.collectImage.tag = indexPath.row;
    cell.collectImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *collectTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectTap:)];
    [cell.collectImage addGestureRecognizer:collectTap];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.typeInteger == 1) {
        
        DiseaseLibraryModel *model = self.dataSource[indexPath.row];
        
        if (self.collectBlock) {
            self.collectBlock(model);
        }
        
    }

}

-(void)collect:(UIButton *)sender{
    
    DiseaseLibraryModel *model = self.dataSource[sender.tag];
    
    if (model.disease_id == 0) {
        
        if (self.collectBlock) {
            self.collectBlock(model);
        }
        
    }
    
}

-(void)collectTap:(UITapGestureRecognizer *)sender{
 
    DiseaseLibraryModel *model = self.dataSource[sender.view.tag];
    
    if (self.collecDeleteBlock) {
        self.collecDeleteBlock(model);
    }
    
}

@end
