//
//  ReApplicationViewController.m
//  GanLuXiangBan
//
//  Created by Mac on 2019/9/9.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "ReApplicationViewController.h"

@interface ReApplicationViewController ()

@property (nonatomic ,strong) UILabel *noPassLabel;

@end

@implementation ReApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == 0) {
        self.title = @"上传授权证明";
    }else if (self.type == 1){
        self.title = @"重新提交";
    }
    
    [self initUI];
    
}

- (void)setAddModel:(DrugListModel *)addModel{
    _addModel = addModel;
    
}

- (void)initUI{
    
    NSArray *array = @[@"名称：",@"规格：",@"厂家："];
    
    for (int i = 0; i < array.count; i++) {
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14];
        label.text = array[i];
        [self.view addSubview:label];
        
        label.sd_layout
        .leftSpaceToView(self.view, 15)
        .topSpaceToView(self.view, 15 + i * 19)
        .heightIs(14);
        [label setSingleLineAutoResizeWithMaxWidth:200];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.tag = i + 1000;
        [self.view addSubview:contentLabel];
        
        contentLabel.sd_layout
        .leftSpaceToView(label, 5)
        .centerYEqualToView(label)
        .heightIs(14);
        [contentLabel setSingleLineAutoResizeWithMaxWidth:200];
        
    }
    
    self.noPassLabel = [UILabel new];
    self.noPassLabel.textColor = [UIColor redColor];
    self.noPassLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.noPassLabel];
    
    self.noPassLabel.sd_layout
    .leftSpaceToView(self.view, 15)
    .topSpaceToView(self.view, 15 + array.count * 19)
    .heightIs(14);
    [self.noPassLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    
    UIView *garyView = [UIView new];
    garyView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:garyView];
    
    if (self.type == 0) {
        garyView.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 20 + array.count * 19)
        .heightIs(2);
    }else if (self.type == 1){
        garyView.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.noPassLabel, 3)
        .heightIs(1);
    }
    
}

@end
