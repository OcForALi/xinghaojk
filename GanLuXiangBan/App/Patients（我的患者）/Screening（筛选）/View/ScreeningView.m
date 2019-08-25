//
//  ScreeningView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/20.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "ScreeningView.h"

#import "CheckListDetailsModel.h"

@interface ScreeningViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *check;
@end

@implementation ScreeningViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.check = [[UIImageView alloc] init];
        [self.contentView addSubview:self.check];
        self.check.sd_layout.rightSpaceToView(self.contentView, 16).widthIs(16).heightEqualToWidth().centerYEqualToView(self.contentView);
        
        self.name = [[UILabel alloc] init];
        self.name.textColor = kMainTextColor;
        self.name.font = kFontRegular(14);
        [self.contentView addSubview:self.name];
        self.name.sd_layout.leftSpaceToView(self.contentView, 16).rightSpaceToView(self.check, 16).heightIs(24).centerYEqualToView(self.contentView);
    }
    return self;
}

@end


@implementation ScreeningView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScreeningViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningViewCell"];
    if (cell == nil) {
        cell = [[ScreeningViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ScreeningViewCell"];
    }
    
    CheckDemoModel *obj = self.dataSources[indexPath.row];
    cell.name.text = obj.chk_item;
    NSString *name = obj.isSelect ? @"SelectPatients" : @"NoSelectPatients";
    cell.check.image = [UIImage imageNamed:name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CheckDemoModel *obj = self.dataSources[indexPath.row];
    obj.isSelect = !obj.isSelect;
    [tableView reloadData];
}

@end
