//
//  HomeMessgeView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/7.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HomeMessgeView.h"
#import "HomeMessgeTableViewCell.h"

@implementation HomeMessgeView
//@synthesize headerView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = [NSMutableArray array];
        
        [self initUI];
        
    }
    
    return self;
    
}

-(void)addData:(NSArray *)array{
    
    [self.dataSource addObjectsFromArray:array];
    
    [self.myTable reloadData];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTable.backgroundColor = [UIColor clearColor];
//    self.myTable.tableHeaderView = self.headerView;
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
    
    
    HomeNewModel *model = self.dataSource[indexPath.row];
        // 获取cell高度
    return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HomeMessgeTableViewCell class]  contentViewWidth:[self cellContentViewWith]];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"HomeMessgeTableViewCell";
    
    HomeMessgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[HomeMessgeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    cell.model = self.dataSource[indexPath.row];
    cell.serialNumberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    
    return cell;
}
/*
- (UIView *)headerView {
    
    if (!headerView) {
        
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        headerView.backgroundColor = RGB(69, 118, 255);
        
        UILabel *label = [UILabel new];
        label.text = @"消息列表";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        [headerView addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(headerView, 20)
        .centerYEqualToView(headerView)
        .heightIs(16);
        [label setSingleLineAutoResizeWithMaxWidth:200];
        
//        UIView *view = [UIView new];
//        view.backgroundColor = kMainColor;
//        [headerView addSubview:view];
//
//        view.sd_layout
//        .leftSpaceToView(headerView, 0)
//        .topSpaceToView(headerView, 5)
//        .bottomSpaceToView(headerView, 5)
//        .widthIs(5);
        
    }
    
    return headerView;
    
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
