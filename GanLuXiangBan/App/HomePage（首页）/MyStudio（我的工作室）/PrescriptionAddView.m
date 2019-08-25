//
//  PrescriptionAddView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/24.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PrescriptionAddView.h"

#import "RecDrugsTableViewCell.h"
#import "AddDrugUseController.h"

@implementation PrescriptionAddView
@synthesize headerView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = [NSMutableArray array];
        
        [self initUI];
        
    }
    
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}

-(void)setType:(NSInteger)type{
    _type = type;
    
    if (type == 0) {
        
        self.symptomsView.hidden = YES;
        [self.headerView setFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        UIView *view = [self viewWithTag:300];
        view.hidden = YES;
        
    }else{
        
        self.symptomsView.hidden = NO;
        [self.headerView setFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        UIView *view = [self viewWithTag:300];
        view.hidden = NO;
        
    }
    
}

-(void)setModel:(RecDrugsModel *)model{
    
    _model = model;
    
    if (model.check_result != nil && [model.check_result isKindOfClass:[NSString class]]) {
        self.diagnosisContentLabel.text = model.check_result;
    }
    
    self.labeX = 0;
    
    for (UIView *view in [self.symptomsView subviews]) {
        
        [view removeFromSuperview];
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:model.rcd_result];
    
    for (int f = 0; f < array.count; f++) {
        
        if ([[array[f] objectForKey:@"check_result"] isEqualToString:@"nil"] || [[array[f] objectForKey:@"check_result"] isEqual:[NSNull null]]) {
            
            [array removeObjectAtIndex:f];
            
        }
        
    }
    
    for (int i = 0; i < array.count; i++) {
        
        //CGFloat stringFloat = [self calculateRowWidth:[array[i] objectForKey:@"check_result"]];
        
        UILabel *label = [UILabel new];
        label.text = [array[i] objectForKey:@"check_result"];
        label.font = [UIFont systemFontOfSize:14];
        [self.symptomsView addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(self.symptomsView, 25 + self.labeX + i*(ScreenWidth/4) + i * 25)
        .centerYEqualToView(self.symptomsView)
        .heightIs(14)
        .widthIs(ScreenWidth/4);
        
        UIView *contentBackView = [UIView new];
        contentBackView.layer.cornerRadius = 5;
        contentBackView.layer.masksToBounds = YES;
        contentBackView.layer.borderWidth = 1;
        contentBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        contentBackView.tag = i + 100;
        contentBackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(symptoms:)];
        [contentBackView addGestureRecognizer:tap];
        [self.symptomsView addSubview:contentBackView];
        
        contentBackView.sd_layout
        .leftSpaceToView(label, -label.width - 10)
        .widthIs(label.width+20)
        .centerYEqualToView(self.symptomsView)
        .heightIs(30);
        
        WS(weakSelf)
        label.didFinishAutoLayoutBlock = ^(CGRect frame) {
            
            contentBackView.sd_resetLayout
            .xIs(frame.origin.x - 10)
            .widthIs(frame.size.width + 20)
            .centerYEqualToView(weakSelf.symptomsView)
            .heightIs(30);
            
        };
        
    }
    
}

- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

-(void)setDataSource:(NSMutableArray *)dataSource{
    
    _dataSource = dataSource;
    
    [self.myTable reloadData];
    
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableHeaderView = self.headerView;
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.myTable];
    
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
    
    DrugDosageModel *model = self.dataSource[indexPath.row];
    // 获取cell高度
    return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RecDrugsTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"RecDrugsTableViewCell";
    
    RecDrugsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[RecDrugsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.model = self.dataSource[indexPath.row];
    
    cell.compileLabel.tag = 1000 + indexPath.row;
    cell.compileLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *compileTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(compile:)];
    [cell.compileLabel addGestureRecognizer:compileTap];
    
    return cell;
}

- (UIView *)headerView {
    
    if (!headerView) {
        
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        self.diagnosisLabel = [UILabel new];
        self.diagnosisLabel.text = @"临床诊断：";
        self.diagnosisLabel.font = [UIFont systemFontOfSize:13];
        [headerView addSubview:self.diagnosisLabel];
        
        self.diagnosisLabel.sd_layout
        .leftSpaceToView(headerView, 15)
        .topSpaceToView(headerView, 0)
        .bottomSpaceToView(headerView, 0);
        [self.diagnosisLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        UIView *view = [UIView new];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *diagnosisTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(diagnosisTap:)];
        [view addGestureRecognizer:diagnosisTap];
        [headerView addSubview:view];
        
        view.sd_layout
        .leftSpaceToView(headerView, 0)
        .rightSpaceToView(headerView, 0)
        .centerYEqualToView(self.diagnosisLabel)
        .heightIs(20);
        
        
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"Home_RightArrow"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [headerView addSubview:imageView];
        
        imageView.sd_layout
        .rightSpaceToView(headerView, 15)
        .centerYEqualToView(self.diagnosisLabel)
        .widthIs(13)
        .heightEqualToWidth();
        
        self.diagnosisContentLabel = [UILabel new];
        self.diagnosisContentLabel.font = [UIFont systemFontOfSize:14];
        [headerView addSubview:self.diagnosisContentLabel];
        
        self.diagnosisContentLabel.sd_layout
        .leftSpaceToView(self.diagnosisLabel, 15)
        .centerYEqualToView(self.diagnosisLabel)
        .heightIs(14);
        [self.diagnosisContentLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        UIView *lineView1 = [UIView new];
        lineView1.backgroundColor = RGB(237, 237, 237);
        [headerView addSubview:lineView1];
        
        lineView1.sd_layout
        .leftSpaceToView(headerView, 0)
        .rightSpaceToView(headerView, 0)
        .topSpaceToView(self.diagnosisLabel, 0)
        .heightIs(1);
        
        self.symptomsView = [UIView new];
        [headerView addSubview:self.symptomsView];
        
        self.symptomsView.sd_layout
        .leftSpaceToView(headerView, 0)
        .rightSpaceToView(headerView, 0)
        .heightIs(40)
        .topSpaceToView(lineView1, 10);
        
        UIView *lineView2 = [UIView new];
        lineView2.backgroundColor = RGB(237, 237, 237);
        lineView2.tag = 300;
        [headerView addSubview:lineView2];
        
        lineView2.sd_layout
        .leftSpaceToView(headerView, 0)
        .rightSpaceToView(headerView, 0)
        .topSpaceToView(self.symptomsView, 10)
        .heightIs(1);
        
    }
    
    return headerView;
    
}

-(void)symptoms:(UITapGestureRecognizer *)sender{
    
    NSString *string = [self.model.rcd_result[sender.view.tag - 100] objectForKey:@"check_result"];
    
    self.diagnosisContentLabel.text = string;
    
    self.model.check_result = string;
    
    NSString *check_id = [self.model.rcd_result[sender.view.tag - 100] objectForKey:@"check_id"];
    
    NSString *recipelist_id = [self.model.rcd_result[sender.view.tag - 100] objectForKey:@"recipelist_id"];
    
    if (self.requestBlock) {
        self.requestBlock(check_id, recipelist_id);
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 47)];
    
    UILabel *label = [UILabel new];
    label.text = @"Rp";
    label.font = [UIFont systemFontOfSize:30];
    [view addSubview:label];
    
    label.sd_layout
    .leftSpaceToView(view, 15)
    .centerYEqualToView(view)
    .heightIs(30);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    
    return view;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 47)];
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *addTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTap:)];
    [view addGestureRecognizer:addTap];
    
    UILabel *label = [UILabel new];
    label.text = @"添加药品";
    label.textColor = kMainColor;
    label.font = [UIFont systemFontOfSize:24];
    [view addSubview:label];
    
    label.sd_layout
    .centerXEqualToView(view)
    .centerYEqualToView(view)
    .heightIs(24);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"SortingAreaAddImg"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    imageView.sd_layout
    .rightSpaceToView(label, 5)
    .centerYEqualToView(view)
    .widthIs(30)
    .heightEqualToWidth();
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 47;
}

/**< 每个分组下边预留的空白高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 47;
}

-(void)compile:(UITapGestureRecognizer *)sender{
    
    DrugDosageModel *drugDosageModel = self.dataSource[sender.view.tag - 1000];
    AddDrugUseController *use = [AddDrugUseController new];
    use.model = drugDosageModel;
    use.type = 2;
    if (self.useBlock) {
        self.useBlock(use);
    }
    
//    self.addDrugsView = [AddDrugsView new];
//    self.addDrugsView.type = 2;
//    self.addDrugsView.model = drugDosageModel;
//    [[UIApplication sharedApplication].keyWindow addSubview:self.addDrugsView];
//
//    self.addDrugsView.sd_layout
//    .xIs(0)
//    .yIs(0)
//    .widthIs(ScreenWidth)
//    .heightIs(ScreenHeight);
//
//    WS(weakSelf);
//    self.addDrugsView.addDurgDosageBlock = ^(DrugDosageModel *drugModel) {
//
//        [weakSelf.addDrugsView removeFromSuperview];
//    };
//
//    self.addDrugsView.backBlock = ^(NSString *back) {
//
//        [weakSelf.addDrugsView removeFromSuperview];
//
//    };
    
}

-(void)addTap:(UITapGestureRecognizer *)sender{
    
    if (self.pushBlock) {
        self.pushBlock(self.dataSource);
    }
    
}

-(void)diagnosisTap:(UITapGestureRecognizer *)sender{
    
    if (self.openBlock) {
        self.openBlock(@"临床诊断");
    }
    
}

@end
