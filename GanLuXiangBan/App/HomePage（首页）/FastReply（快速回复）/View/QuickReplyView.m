//
//  QuickReplyView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/18.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "QuickReplyView.h"
#import "QuickReplyModel.h"
#import "QuickReplyTableViewCell.h"
@implementation QuickReplyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = [NSMutableArray array];
        
        self.pkids = [NSMutableArray array];
        
        [self initUI];
        
    }
    
    return self;
    
}

-(void)addData:(NSArray *)array{
    
    [self.dataSource removeAllObjects];
    
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
    [self addSubview:self.myTable];
    
}

-(void)setTypeInteger:(NSInteger)typeInteger{
    
    _typeInteger = typeInteger;
    
    [self.myTable reloadData];
    
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
    
    return 40;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"QuickReplyTableViewCell";
    
    QuickReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[QuickReplyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    QuickReplyModel *model = self.dataSource[indexPath.row];

    cell.typeInteger = self.typeInteger;
    
    cell.model = model;
    
    cell.button.tag = indexPath.row + 100;
    [cell.button addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.typeInteger == 1) {
        [self toggleSelectedReply:indexPath.row];
    }
    else {
        QuickReplyModel *model = self.dataSource[indexPath.row];
        
        if (self.inputTextBlock) {
            self.inputTextBlock(model.content);
        }
    }
    
}

- (void)toggleSelectedReply:(NSInteger)index {
    UIButton *button = (UIButton *)[self viewWithTag:100+index];
    if (button) {
        button.selected = ![button isSelected];
    }
    
    QuickReplyModel *model = self.dataSource[index];
    
    BOOL isbool = [self.pkids containsObject: model.pkid];
    
    if (isbool == YES) {
        
        NSInteger index = [self.pkids indexOfObject:model.pkid];
        
        [self.pkids removeObjectAtIndex:index];
        
    }else{
        
        [self.pkids addObject:model.pkid];
        
    }
    
    if (self.selectChangeBlock) {
        self.selectChangeBlock(self.pkids);
    }
}

-(void)select:(UIButton *)sender{
    
//    sender.selected = ![sender isSelected];
    
    NSInteger index = sender.tag - 100;
    [self toggleSelectedReply:index];
    
    if (self.operationBlock) {
        self.operationBlock(nil);
    }
    
}

-(void)allPkids{
    
    [self.pkids removeAllObjects];
    
    for (int i = 0; i < self.dataSource.count; i++) {
        
        QuickReplyModel *model = self.dataSource[i];
        
        [self.pkids addObject:model.pkid];
        
        UIButton *button = [self viewWithTag:i+100];
        
        button.selected = YES;
        
    }
    
}

-(void)removePkids {
    
    for (NSInteger index = 0; index < self.dataSource.count; index++) {
        QuickReplyModel *model = self.dataSource[index];
        if ([self.pkids containsObject: model.pkid]) {
            [self.dataSource removeObject:model];
            index--;
        }
    }
    [self.pkids removeAllObjects];
    [self.myTable reloadData];
    
    for (int i = 0; i < self.dataSource.count; i++) {

        UIButton *button = [self viewWithTag:i+100];

        button.selected = NO;

    }
    
}

@end
