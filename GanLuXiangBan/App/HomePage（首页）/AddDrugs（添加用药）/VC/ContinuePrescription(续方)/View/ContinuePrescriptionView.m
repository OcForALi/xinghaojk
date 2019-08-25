//
//  ContinuePrescriptionView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/21.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ContinuePrescriptionView.h"
#import "ContinueModel.h"
#import "ContinuePrescriptionTableViewCell.h"

@implementation ContinuePrescriptionView

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
    self.myTable.separatorColor = [UIColor clearColor];
    self.myTable.backgroundColor = [UIColor clearColor];
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
    
    ContinueModel *model = self.dataSource[indexPath.row];
    // 获取cell高度
    return [self.myTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ContinuePrescriptionTableViewCell class]  contentViewWidth:[self cellContentViewWith]];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
    
    ContinuePrescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[ContinuePrescriptionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.model = self.dataSource[indexPath.row];
    cell.OKLabel.userInteractionEnabled = YES;
    cell.OKLabel.tag = indexPath.row + 100;
    UITapGestureRecognizer *okTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ok:)];
    [cell.OKLabel addGestureRecognizer:okTap];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(void)ok:(UITapGestureRecognizer *)sender{
    
    ContinueModel *model = self.dataSource[sender.view.tag - 100];
    if (model.items && model.items.count > 0) {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in model.items) {
            NSInteger status = [dict[@"status"] integerValue];
            if (status != 1) {
                NSString *string = [NSString stringWithFormat:@"%@",dict[@"drug_name"]];
                [list addObject:string];
            }
        }
        if (list.count > 0) {
            NSString *title = [list componentsJoinedByString:@"、"];
            title = [NSString stringWithFormat:@"%@，没有上架，可能没有库存，不能进行续方", title];
            [self.superview makeToast:title];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ContinuePrescription" object:model];
        }
    }
    else {
        [self.superview makeToast:@"没有药品上架，不能进行续方"];
    }
    
}

@end
