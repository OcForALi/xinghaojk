//
//  DrugDetailsView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "DrugDetailsView.h"
#import "DrugDetailsTableViewCell.h"
#import "SDPhotoBrowser.h"

@interface DrugDetailsView() <SDPhotoBrowserDelegate>

@end

@implementation DrugDetailsView

@synthesize headerView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleArray = [NSMutableArray array];
        
        self.contentArray = [NSMutableArray array];
        
        [self initUI];
        
    }
    
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTable.separatorColor = [UIColor whiteColor];
    self.myTable.tableHeaderView = self.headerView;
    [self addSubview:self.myTable];
    
}

- (void)touchDrugPictures {
    NSArray *list = self.bannerView.imageURLStringsGroup;
    if (list && list.count > 0) {
        WS(weakSelf)
        self.bannerView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
            photoBrowser.delegate = weakSelf;
            photoBrowser.currentImageIndex = 0;
            photoBrowser.imageCount = list.count;
            photoBrowser.sourceImagesContainerView = weakSelf.superview;
            [photoBrowser show];
        };
    }
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return nil;
}
// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSArray *list = self.bannerView.imageURLStringsGroup;
    if (list && index < list.count) {
        return [NSURL URLWithString:list[index]];
    }
    return nil;
}

-(void)setModel:(DrugDetailsModel *)model{
    
    _model = model;
    
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (NSDictionary *dict in model.files) {
        
        if ([dict objectForKey:@"pic_path"]) {
            [imageArray addObject:[dict objectForKey:@"pic_path"]];
        }
        
    }
    
    self.bannerView.imageURLStringsGroup = imageArray;
    
    [self touchDrugPictures];
    
    self.drugNameLabel.text = [NSString stringWithFormat:@"%@(%@)",model.drug_name,model.common_name];
    
    self.drugStandardLabel.text = model.standard;
    
    self.drugProducerLabel.text = model.producer;
    
//    [self.titleArray addObjectsFromArray:@[@[@"处方药：",@"剂型：",@"贮藏：",@"批准文号："],@[@"适应症：",@"成分：",@"型状：",@"不良反应：",@"注意事项：",@"禁忌：",@"药物相互作用：",@"药理毒理"]]];
//
//    NSString *chufang;
//
//    if (model.ischufang == 0) {
//        chufang = @"否";
//    }else{
//        chufang = @"是";
//    }
//
//    [self.contentArray addObjectsFromArray:@[@[chufang,
//                                               [NSString stringWithFormat:@"%@",model.dosage_form],
//                                               [NSString stringWithFormat:@"%@",model.storage],
//                                               [NSString stringWithFormat:@"%@",model.auth_no]
//                                               ],@[
//                                                 @"",
//                                                 [NSString stringWithFormat:@"%@",model.chengfen],
//                                                 [NSString stringWithFormat:@"%@",model.character],
//                                                 [NSString stringWithFormat:@"%@",model.advers_reaction],
//                                                 [NSString stringWithFormat:@"%@",model.attentions],
//                                                 [NSString stringWithFormat:@"%@",model.fortbits],
//                                                 [NSString stringWithFormat:@"%@",model.drug_interation],
//                                                 [NSString stringWithFormat:@"%@",model.drug_toxicology]]]];

    [self.myTable reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    NSArray *array = self.titleArray[section];
//
//    return array.count;
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

//    return self.titleArray.count;
    return 1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *instructions = self.model ? self.model.instructions : nil;
    if (instructions && ![instructions isKindOfClass:NSNull.class] && instructions.length > 0) {
        CGFloat height = [instructions boundingRectWithSize:CGSizeMake(ScreenWidth-30, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFontRegular(14)} context:nil].size.height;
        return ceilf(height) + 10;
    }
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    static NSString *identifier = @"DrugDetailsTableViewCell";
//
//    DrugDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//
//    if (!cell)
//    {
//        cell = [[DrugDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    }
//
//    cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
//
//    if ([self.contentArray[indexPath.section][indexPath.row] isEqualToString:@"(null)"]) {
//
//    }else{
//        cell.contenLabel.text = self.contentArray[indexPath.section][indexPath.row];
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drugInstructionsCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"drugInstructionsCell"];
        cell.textLabel.textColor = kMainTextColor;
        cell.textLabel.font = kFontRegular(14);
        cell.textLabel.numberOfLines = 0;
    }
    NSString *instructions = self.model ? self.model.instructions : nil;
    if (instructions && ![instructions isKindOfClass:NSNull.class] && instructions.length > 0) {
        cell.textLabel.text = instructions;
    }
    return cell;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *instructions = self.model ? self.model.instructions : nil;
    if (instructions && ![instructions isKindOfClass:NSNull.class] && instructions.length > 0) {
        return 10;
    }
    return CGFLOAT_MIN;
}

/**< 每个分组下边预留的空白高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)headerView {
    
    if (!headerView) {
        
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.4*ScreenWidth + 120)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        self.bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.4*ScreenWidth)];
        self.bannerView.delegate = self;
        self.bannerView.autoScrollTimeInterval = 5;
//        self.bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        self.bannerView.backgroundColor = [UIColor whiteColor];
        self.bannerView.currentPageDotColor = [UIColor redColor];
        [headerView addSubview:self.bannerView];
        
        self.drugNameLabel = [UILabel new];
        self.drugNameLabel.font = [UIFont systemFontOfSize:16];
        [headerView addSubview:self.drugNameLabel];
        
        self.drugNameLabel.sd_layout
        .leftSpaceToView(headerView, 20)
        .rightSpaceToView(headerView, 20)
        .topSpaceToView(self.bannerView, 14)
        .autoHeightRatio(0);
        
        self.drugStandardLabel = [UILabel new];
        self.drugStandardLabel.font = [UIFont systemFontOfSize:16];
        [headerView addSubview:self.drugStandardLabel];
        
        self.drugStandardLabel.sd_layout
        .leftSpaceToView(headerView, 20)
        .rightSpaceToView(headerView, 20)
        .topSpaceToView(self.drugNameLabel, 14)
        .heightIs(16);
        
        self.drugProducerLabel = [UILabel new];
        self.drugProducerLabel.font = [UIFont systemFontOfSize:16];
        [headerView addSubview:self.drugProducerLabel];
        
        self.drugProducerLabel.sd_layout
        .leftSpaceToView(headerView, 20)
        .rightSpaceToView(headerView, 20)
        .topSpaceToView(self.drugStandardLabel, 14)
        .heightIs(16);
        
    }
    
    return headerView;
    
}

@end
