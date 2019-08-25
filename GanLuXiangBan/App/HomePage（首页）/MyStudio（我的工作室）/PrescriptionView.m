//
//  PrescriptionView.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/19.
//  Copyright © 2019 黄锡凯. All rights reserved.
//

#import "PrescriptionView.h"

CGFloat const PrescriptionCellSpace = 14.0;

@interface PrescriptionSectionCell : UITableViewCell
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation PrescriptionSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor colorWithHexString:@"0x63B8FF"];
        [self.contentView addSubview:self.mainView];
        self.mainView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, PrescriptionCellSpace, 0, PrescriptionCellSpace));
        
        UILabel *rp = [[UILabel alloc] init];
        rp.text = @"Rp";
        rp.textColor = [UIColor whiteColor];
        rp.font = kFontMedium(16);
        [self.mainView addSubview:rp];
        rp.sd_layout.leftSpaceToView(self.mainView, 10).topSpaceToView(self.mainView, 0).bottomSpaceToView(self.mainView, 0).widthIs(30);
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = kMainTextColor;
        self.titleLabel.font = kFontRegular(14);
        [self.mainView addSubview:self.titleLabel];
        
        self.numLabel = [[UILabel alloc] init];
        self.numLabel.textColor = [UIColor whiteColor];
        self.numLabel.textAlignment = NSTextAlignmentRight;
        self.numLabel.font = kFontRegular(14);
        [self.mainView addSubview:self.numLabel];
        
        self.numLabel.sd_layout.topSpaceToView(self.mainView, 0).rightSpaceToView(self.mainView, 8).bottomSpaceToView(self.mainView, 0).widthIs(80);
        self.titleLabel.sd_layout.topSpaceToView(self.mainView, 0).leftSpaceToView(rp, 8).rightSpaceToView(self.numLabel, 15).bottomSpaceToView(self.mainView, 0);
    }
    return self;
}

@end

#pragma mark -

@interface PrescriptionRowCell : UITableViewCell
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation PrescriptionRowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.mainView];
        self.mainView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, PrescriptionCellSpace, 0, PrescriptionCellSpace));
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = kMainTextColor;
        self.titleLabel.font = kFontRegular(14);
        [self.mainView addSubview:self.titleLabel];
        
        self.numLabel = [[UILabel alloc] init];
        self.numLabel.textColor = kSixColor;
        self.numLabel.textAlignment = NSTextAlignmentRight;
        self.numLabel.font = kFontRegular(14);
        [self.mainView addSubview:self.numLabel];
        
        self.numLabel.sd_layout.topSpaceToView(self.mainView, 0).rightSpaceToView(self.mainView, PrescriptionCellSpace).bottomSpaceToView(self.mainView, 0).widthIs(80);
        self.titleLabel.sd_layout.topSpaceToView(self.mainView, 0).leftSpaceToView(self.mainView, PrescriptionCellSpace).rightSpaceToView(self.numLabel, 15).bottomSpaceToView(self.mainView, 0);
    }
    return self;
}

@end

#pragma mark -

@implementation PrescriptionView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PrescriptionModel *sec = [self.dataSources objectAtIndex:section];
    NSInteger count = 1;
    if (sec && sec.drugs && sec.drugs.count > 0) {
        count += sec.drugs.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    PrescriptionModel *sec = [self.dataSources objectAtIndex:section];
    if (row == 0) {
        PrescriptionSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrescriptionSectionCell"];
        if (!cell) {
            cell = [[PrescriptionSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PrescriptionSectionCell"];
        }
        cell.titleLabel.text = [NSString stringWithFormat:@"临床诊断：%@", sec.check_result];
        cell.numLabel.text = [NSString stringWithFormat:@"共%@个品种", @(sec.drugs.count)];
        return cell;
    }
    else {
        row--;
        PrescriptionRowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrescriptionRowCell"];
        if (!cell) {
            cell = [[PrescriptionRowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PrescriptionRowCell"];
        }
        PrescriptionDrugModel *item = [sec.drugs objectAtIndex:row];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@(%@)", item.name, item.alia];
        cell.numLabel.text = [NSString stringWithFormat:@"X%@",item.num];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        return 44;
    }
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (self.SelectedPrescriptionBlock && section < self.dataSources.count) {
        PrescriptionModel *sec = [self.dataSources objectAtIndex:section];
        NSMutableArray *res = [[NSMutableArray alloc] init];
        if (sec.drugs && sec.drugs.count > 0) {
            for (PrescriptionDrugModel *item in sec.drugs) {
                if (item.status != 1) {
                    [res addObject:item.name];
                }
            }
        }
        if (res.count == 0) {
            self.SelectedPrescriptionBlock(sec);
        }
        else {
            NSString *title = [res componentsJoinedByString:@"、"];
            title = [NSString stringWithFormat:@"%@，没有上架，可能没有库存，不能进行续方", title];
            [self makeToast:title];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
