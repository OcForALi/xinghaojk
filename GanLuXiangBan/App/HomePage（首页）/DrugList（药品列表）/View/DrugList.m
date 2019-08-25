//
//  DrugList.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/1.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugList.h"
#import "DrugListTableViewCell.h"

@implementation DrugList

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = [NSMutableArray array];
        
        self.pkids = [NSMutableArray array];
        
        [self initUI];
        
    }
    
    return self;
    
}

-(void)addData:(NSArray *)array{
    
    [self.dataSource addObjectsFromArray:array];
    
    [self.myTable reloadData];
    
}

-(void)setType:(NSInteger)Type{
    
    _Type = Type;
    
    [self.pkids removeAllObjects];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (DrugListModel *model in self.dataSource) {
        model.isSelected = NO;
        [array addObject:model];
    }
    
    [self.dataSource removeAllObjects];
    
    self.dataSource = array;
    
    [self.myTable reloadData];
    
}

-(void)setDrug_idArray:(NSArray *)drug_idArray{
    
    _drug_idArray = drug_idArray;
    
    [self.myTable reloadData];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}

-(void)initUI{
    
    self.myTable = [[BaseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.myTable];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = self.dataSource.count;
    self.myTable.defaultImgView.hidden = count > 0;
    return count;
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
    
    DrugListModel *model = self.dataSource[indexPath.row];
    // 获取cell高度
    return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DrugListTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"DrugListTableViewCell";
    
    DrugListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[DrugListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.type = self.Type;
    cell.drug_idArray = self.drug_idArray;
    cell.model = self.dataSource[indexPath.row];
    if (self.Type == 1 || self.Type == 3) {
        cell.collectButton.hidden = YES;
    }
    else {
        cell.collectButton.hidden = NO;
        cell.collectButton.tag = indexPath.row;
        [cell.collectButton addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectedButton.tag = indexPath.row;
    [cell.selectedButton addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DrugListModel *model = self.dataSource[indexPath.row];

    if (self.pushBlock) {
        self.pushBlock(model.drug_id);
    }
    
}

-(void)collect:(UIButton *)sender{
    
//    if ([sender.titleLabel.text isEqualToString:@"收藏"] || [sender.titleLabel.text isEqualToString:@"添加"]) {
    
        DrugListModel *model = self.dataSource[sender.tag];
        
        if (self.collectBlock && !model.isAdded) {
            self.collectBlock(model);
        }
        
//    }

}

-(void)selected:(UIButton *)sender{
    
    DrugListModel *model = self.dataSource[sender.tag];
    
    if (sender.selected == NO) {
        
        model.isSelected = YES;

    }else{
        
        model.isSelected = NO;

    }
    
    BOOL isbool = [self.pkids containsObject: [NSString stringWithFormat:@"%ld",model.fav_id]];
    
    if (isbool == YES) {
        
        NSInteger index = [self.pkids indexOfObject:[NSString stringWithFormat:@"%ld",model.fav_id]];
        
        [self.pkids removeObjectAtIndex:index];
        
    }else{
        
        [self.pkids addObject:[NSString stringWithFormat:@"%ld",model.fav_id]];
        
    }
    
    if (self.selectedDeleteBlock) {
        self.selectedDeleteBlock(self.pkids);
    }
    
    [self.myTable reloadData];
    
}

@end
