//
//  AgentVarietyView.m
//  GanLuXiangBan
//
//  Created by 黄锡凯 on 2019/9/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "AgentVarietyView.h"
#import "AgentVarietyModel.h"

@implementation AgentVarietyView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AgentVarietyModel *model = self.dataSources[indexPath.section];
    NSArray *texts = @[model.drug_name,
                       [@"规格：" stringByAppendingString:model.spec],
                       [@"厂商：" stringByAppendingString:model.producer]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.row == 0) {
        
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@盒", model.num];
    }
    else {
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.detailTextLabel.text = @"";
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = kMainTextColor;
    cell.textLabel.text = texts[indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor redColor];
    return cell;
}

@end
