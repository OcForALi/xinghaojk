//
//  PatientGroupRightView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/4/19.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PatientGroupRightView.h"

@interface PatientGroupRightView() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) PatientGroupChooseBlock chooseBlock;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSArray *groups;
@end

@implementation PatientGroupRightView

+ (void)show:(NSArray *)groups complete:(PatientGroupChooseBlock)complete {
    PatientGroupRightView *view = [[PatientGroupRightView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.chooseBlock = complete;
    view.groups = groups;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view.tableView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancel addTarget:self action:@selector(touchCancelPicker) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancel];
        cancel.sd_layout.topSpaceToView(self, 0).leftSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs( CGRectGetWidth(frame)-120);
        
        UIView *titleView = [[UIView alloc] init];
        titleView.backgroundColor = kMainColor;
        [self addSubview:titleView];
        titleView.sd_layout.topSpaceToView(self, 0).leftSpaceToView(cancel, 0).rightSpaceToView(self, 0).heightIs(kNavbarSafeHeight+64);
        UILabel *title = [[UILabel alloc] init];
        title.backgroundColor = [UIColor clearColor];
        title.font = kFontRegular(15);
        title.text = @"患者分类";
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [titleView addSubview:title];
        title.sd_layout.leftSpaceToView(titleView, 0).rightSpaceToView(titleView, 0).bottomSpaceToView(titleView, 0).heightIs(44);
        
        self.tableView = [[BaseTableView alloc] init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.showsVerticalScrollIndicator = YES;
        [self addSubview:self.tableView];
        self.tableView.sd_layout.topSpaceToView(titleView, 0).leftEqualToView(titleView).rightEqualToView(titleView).bottomEqualToView(cancel);
    }
    return self;
}

- (void)touchCancelPicker {
    if (self.chooseBlock) {
        self.chooseBlock(YES, nil);
    }
    [self hide];
}

- (NSArray *)groups {
    if (!_groups) {
        _groups = [NSArray array];
    }
    return _groups;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientGroupRightViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"patientGroupRightViewCell"];
        cell.textLabel.textColor = kMainTextColor;
        cell.textLabel.font = kFontRegular(14);
    }
    GroupEditorModel *model = [self.groups objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.chooseBlock) {
        GroupEditorModel *model = [self.groups objectAtIndex:indexPath.row];
        self.chooseBlock(NO, model);
    }
    
    [self hide];
}

- (void)hide {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.chooseBlock = nil;
    [self removeFromSuperview];
}

@end
