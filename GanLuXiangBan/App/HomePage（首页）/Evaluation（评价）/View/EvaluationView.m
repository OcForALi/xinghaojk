//
//  EvaluationView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/11.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "EvaluationView.h"
#import "EvaluationTableViewCell.h"
#import "EvaluationModel.h"

@implementation EvaluationView

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
    self.myTable.separatorColor = [UIColor whiteColor];
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
    
    EvaluationModel *model = self.dataSource[indexPath.row];
    // 获取cell高度
    return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[EvaluationTableViewCell class]  contentViewWidth:[self cellContentViewWith]];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"EvaluationTableViewCell";

    EvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[EvaluationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    cell.model = self.dataSource[indexPath.row];
    
    return cell;
    
}

@end
