//
//  ProductExamineFailView.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/4.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ProductExamineFailView.h"
#import "ProductExamineTableViewCell.h"

@implementation ProductExamineFailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.dataSource = [NSMutableArray array];
        
        [self initUI];
        
    }
    
    return self;
    
}

-(void)addData:(NSArray *)array{
    
    [self.dataSource addObjectsFromArray:array];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myTable reloadData];
    });
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];/**< 初始化_tableView*/
    self.myTable.backgroundColor = kPageBgColor;
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
        ProductModel *model = self.dataSource[indexPath.row];
    //    // 获取cell高度
        return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProductExamineTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
    return 190;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MedicalRecordsTableViewCell";
    
    ProductExamineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[ProductExamineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.model = self.dataSource[indexPath.row];
    
    cell.reconsiderButton.tag = indexPath.row + 100;
    [cell.reconsiderButton addTarget:self action:@selector(reconsiderTag:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductModel *model = self.dataSource[indexPath.row];
    
    if (self.pushBlock) {
        self.pushBlock(model);
    }
    
}

- (void)reconsiderTag:(UIButton *)sender{
    
    ProductModel *model = self.dataSource[sender.tag - 100];
    
    if (self.reconsiderBlock) {
        self.reconsiderBlock(model);
    }
    
}

@end
