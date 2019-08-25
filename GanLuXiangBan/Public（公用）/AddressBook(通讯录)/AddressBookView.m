//
//  AddressBookView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/5/28.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "AddressBookView.h"
#import "IndexPathButton.h"

@implementation AddressBookView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        [self initUI];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.myTable];
    
}

-(void)setSectionArray:(NSMutableArray *)sectionArray{
    _sectionArray = sectionArray;
}

-(void)setSectionTitlesArray:(NSMutableArray *)sectionTitlesArray{
    
    _sectionTitlesArray = sectionTitlesArray;
 
    [self.myTable reloadData];
    
}

#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"AddressBookCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!self.cell) {
        self.cell = [[AddressBookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    PhoneContactModel *model = self.sectionArray[section][row];
    self.cell.model = model;
    self.cell.rightButton.indexPath = indexPath;
    [self.cell.rightButton addTarget:self action:@selector(indexPath:) forControlEvents:UIControlEventTouchUpInside];
    return self.cell;
}

-(void)indexPath:(IndexPathButton *)sender{
    
    PhoneContactModel *model = self.sectionArray[sender.indexPath.section][sender.indexPath.row];
    
    if (self.selectPhoneBlock) {
        self.selectPhoneBlock(model.phoneString);
    }
    
    if (sender.selected == NO) {
        sender.selected = YES;
    }else{
       sender.selected = NO;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitlesArray objectAtIndex:section];
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitlesArray;
}

@end
