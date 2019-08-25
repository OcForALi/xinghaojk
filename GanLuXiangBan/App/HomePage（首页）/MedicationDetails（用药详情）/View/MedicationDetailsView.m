//
//  MedicationDetailsView.m
//  GanLuXiangBan
//
//  Created by 尚洋 on 2018/6/3.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "MedicationDetailsView.h"
#import "DrugDetailModel.h"
#import "MedicationDetailsTableViewCell.h"
#import <WXApi.h>

@implementation MedicationDetailsView

@synthesize headerView;
@synthesize footerView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = [NSMutableArray array];
        
        [self initUI];
        
    }
    
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myTable.frame = self.bounds;
    
}

-(void)setModel:(MedicationDetailsModel *)model{
    
    _model = model;
    
    [self footerView];
    
//    float totalPrice = 0;
    
    for (int i = 0; i < model.drug_items.count; i++) {
        
        NSDictionary *dict = model.drug_items[i];
        
        DrugDetailModel *drugDetailModel = [DrugDetailModel new];
        [drugDetailModel setValuesForKeysWithDictionary:dict];
        
        drugDetailModel.drug_name = [NSString stringWithFormat:@"%d、%@",i+1,drugDetailModel.drug_name];
        
//        totalPrice = totalPrice + [drugDetailModel.price floatValue];
        
        [self.dataSource addObject:drugDetailModel];
        
    }
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"Home_HeadDefault"]];
    
    self.patient_nameLabel.text = model.patient_name;
    
    self.patient_genderLebl.text = model.patient_gender;
    
    self.patient_ageLabel.text = [NSString stringWithFormat:@"%ld岁",(long)model.patient_age];

    self.recommendedTimeLabel.text = [NSString stringWithFormat:@"推荐用药时间：%@",self.model.recommend_time];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥%0.2f",[model.total_price floatValue]];
    
    [self.myTable reloadData];
    
}

-(void)initUI{
    
    self.myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];/**< 初始化_tableView*/
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableHeaderView = self.headerView;
//    self.myTable.tableFooterView = self.footerView;
    [self addSubview:self.myTable];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MedicationDetailsTableViewCell";
    
    MedicationDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[MedicationDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.model = self.dataSource[indexPath.row];
    
//    if ([self.model.status isEqualToString:@"-1"]) {
//
//        cell.qtyLabel.hidden = NO;
//        
//        cell.priceLabel.hidden = YES;
//
//    }else{
//
//        cell.qtyLabel.hidden = YES;
//
//        cell.priceLabel.hidden = NO;
//
//    }
    
    return cell;
}

- (UIView *)headerView {
    
    if (!headerView) {
        
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        self.headImageView = [UIImageView new];
        self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.headImageView.layer setMasksToBounds:YES];
        [self.headImageView.layer setCornerRadius:30.0];
        [headerView addSubview:self.headImageView];
        
        self.headImageView.sd_layout
        .leftSpaceToView(headerView, 15)
        .topSpaceToView(headerView, 10)
        .widthIs(60)
        .heightEqualToWidth();
        
        self.patient_nameLabel = [UILabel new];
        self.patient_nameLabel.font = [UIFont systemFontOfSize:18];
        [headerView addSubview:self.patient_nameLabel];
        
        self.patient_nameLabel.sd_layout
        .leftSpaceToView(self.headImageView, 15)
        .topSpaceToView(headerView, 10)
        .heightIs(18);
        [self.patient_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        self.patient_genderLebl = [UILabel new];
        self.patient_genderLebl.textColor = [UIColor lightGrayColor];
        self.patient_genderLebl.font = [UIFont systemFontOfSize:16];
        [headerView addSubview:self.patient_genderLebl];
        
        self.patient_genderLebl.sd_layout
        .leftSpaceToView(self.headImageView, 15)
        .bottomSpaceToView(headerView, 10)
        .heightIs(16);
        [self.patient_genderLebl setSingleLineAutoResizeWithMaxWidth:200];
        
        self.patient_ageLabel = [UILabel new];
        self.patient_ageLabel.textColor = [UIColor lightGrayColor];
        self.patient_ageLabel.font = [UIFont systemFontOfSize:16];
        [headerView addSubview:self.patient_ageLabel];
        
        self.patient_ageLabel.sd_layout
        .leftSpaceToView(self.patient_genderLebl, 15)
        .centerYEqualToView(self.patient_genderLebl)
        .heightIs(16);
        [self.patient_ageLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        self.stateLabel = [UILabel new];
        self.stateLabel.font = [UIFont systemFontOfSize:14];
        self.stateLabel.textColor = kMainColor;
        [headerView addSubview:self.stateLabel];
        
        self.stateLabel.sd_layout
        .rightSpaceToView(headerView, 8)
        .centerYEqualToView(headerView)
        .heightIs(16);
        [self.stateLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = RGB(237, 237, 237);
        [headerView addSubview:lineView];
        
        lineView.sd_layout
        .leftSpaceToView(headerView, 0)
        .rightSpaceToView(headerView, 0)
        .heightIs(0.5)
        .bottomSpaceToView(headerView, 0);
        
    }
    
    return headerView;
    
}

- (UIView *)footerView {
    
    if (!footerView) {
        
        if ([self.status isEqualToString:@"-1"]){
            
            footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 62)];
            footerView.backgroundColor = [UIColor whiteColor];
            
            self.recommendedTimeLabel = [UILabel new];
            self.recommendedTimeLabel.font = [UIFont systemFontOfSize:14];
            [footerView addSubview:self.recommendedTimeLabel];
            
            self.recommendedTimeLabel.sd_layout
            .leftSpaceToView(footerView, 20)
            .topSpaceToView(footerView, 10)
            .heightIs(14);
            [self.recommendedTimeLabel setSingleLineAutoResizeWithMaxWidth:300];
            
            UIView *line1View = [UIView new];
            line1View.backgroundColor = RGB(237, 237, 237);
            [footerView addSubview:line1View];
            
            line1View.sd_layout
            .leftSpaceToView(footerView, 0)
            .rightSpaceToView(footerView, 0)
            .heightIs(1)
            .topSpaceToView(self.recommendedTimeLabel, 10);
            
            UIView *qrcodeView = [UIView new];
            qrcodeView.userInteractionEnabled = YES;
            UITapGestureRecognizer *qrcodeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qrcode:)];
            [qrcodeView addGestureRecognizer:qrcodeTap];
            [footerView addSubview:qrcodeView];
            
            qrcodeView.sd_layout
            .leftSpaceToView(footerView, 0)
            .rightSpaceToView(footerView, 0)
            .topSpaceToView(line1View, 0)
            .heightIs(40);
            
            UIView *blueView = [UIView new];
            blueView.backgroundColor = kMainColor;
            [qrcodeView addSubview:blueView];
            
            blueView.sd_layout
            .leftSpaceToView(qrcodeView, 0)
            .topSpaceToView(qrcodeView, 10)
            .bottomSpaceToView(qrcodeView, 10)
            .widthIs(4);
            
            UILabel *recommendedLabel = [UILabel new];
            recommendedLabel.text = @"推荐二维码";
            recommendedLabel.font = [UIFont systemFontOfSize:18];
            [qrcodeView addSubview:recommendedLabel];
            
            recommendedLabel.sd_layout
            .leftSpaceToView(blueView, 15)
            .centerYEqualToView(qrcodeView)
            .heightIs(18);
            [recommendedLabel setSingleLineAutoResizeWithMaxWidth:200];
            
            UIImageView *nextImageView = [UIImageView new];
            nextImageView.image = [UIImage imageNamed:@"Home_RightArrow"];
            nextImageView.contentMode = UIViewContentModeScaleAspectFit;
            [qrcodeView addSubview:nextImageView];
            
            nextImageView.sd_layout
            .rightSpaceToView(qrcodeView, 15)
            .centerYEqualToView(qrcodeView)
            .widthIs(20)
            .heightEqualToWidth();
            
            UILabel *nextLabel = [UILabel new];
            nextLabel.text = @"点击推荐";
            nextLabel.font = [UIFont systemFontOfSize:14];
            nextLabel.textColor = [UIColor lightGrayColor];
            [qrcodeView addSubview:nextLabel];
            
            nextLabel.sd_layout
            .rightSpaceToView(nextImageView, 5)
            .centerYEqualToView(qrcodeView)
            .heightIs(14);
            [nextLabel setSingleLineAutoResizeWithMaxWidth:100];
            
            UIView *line2View = [UIView new];
            line1View.backgroundColor = RGB(237, 237, 237);
            [footerView addSubview:line2View];
            
            line2View.sd_layout
            .leftSpaceToView(footerView, 0)
            .rightSpaceToView(footerView, 0)
            .heightIs(1)
            .topSpaceToView(qrcodeView, 0);
            
            UILabel *promptLabel = [UILabel new];
            promptLabel.text = @"温馨提示：\n\n1、患者需要使用微信扫描/识别二维码（分享到微信后，患者长按二维码即可识别），关注公众号并成功注册。\n2、注册后，此推荐用药将转为生效状态并能提供给患者进行支付。";
            promptLabel.font = [UIFont systemFontOfSize:14];
            [footerView addSubview:promptLabel];
            
            promptLabel.sd_layout
            .leftSpaceToView(footerView, 15)
            .rightSpaceToView(footerView, 15)
            .topSpaceToView(line2View, 10)
            .autoHeightRatio(0);
            
            
            self.myTable.tableFooterView = self.footerView;
            
        }
        else {
            NSInteger count = 0;
            if (self.model.logistics_list) {
                count = self.model.logistics_list.count;
            }
            footerView = [[UIView alloc] init];
            footerView.backgroundColor = [UIColor whiteColor];
            self.myTable.tableFooterView = footerView;
            footerView.sd_layout.topSpaceToView(self.myTable, 0).leftSpaceToView(self.myTable, 0).rightSpaceToView(self.myTable, 0);
            
            UILabel *label = [UILabel new];
            label.text = @"药品总价";
            label.font = [UIFont systemFontOfSize:18];
            [footerView addSubview:label];
            
            label.sd_layout
            .leftSpaceToView(footerView, 20)
            .topSpaceToView(footerView, 10)
            .heightIs(18);
            [label setSingleLineAutoResizeWithMaxWidth:200];
            
            self.totalPriceLabel = [UILabel new];
            self.totalPriceLabel.textColor = [UIColor redColor];
            self.totalPriceLabel.font = [UIFont systemFontOfSize:18];
            self.totalPriceLabel.text = [NSString stringWithFormat:@"¥%0.2f",[self.model.total_price floatValue]];
            [footerView addSubview:self.totalPriceLabel];
            
            self.totalPriceLabel.sd_layout
            .rightSpaceToView(footerView, 20)
            .centerYEqualToView(label)
            .heightIs(18);
            [self.totalPriceLabel setSingleLineAutoResizeWithMaxWidth:200];
            
            UIView *lineView = [UIView new];
            lineView.backgroundColor = RGB(237, 237, 237);
            [footerView addSubview:lineView];
            
            lineView.sd_layout
            .leftSpaceToView(footerView, 0)
            .rightSpaceToView(footerView, 0)
            .heightIs(0.5)
            .topSpaceToView(label, 10);
            
            
            UIView *qrcodeView = [UIView new];
            [footerView addSubview:qrcodeView];
            
            qrcodeView.sd_layout
            .leftSpaceToView(footerView, 0)
            .rightSpaceToView(footerView, 0)
            .topSpaceToView(lineView, 0)
            .heightIs(40);
            
            UIView *blueView = [UIView new];
            blueView.backgroundColor = kMainColor;
            [qrcodeView addSubview:blueView];
            
            blueView.sd_layout
            .leftSpaceToView(qrcodeView, 0)
            .topSpaceToView(qrcodeView, 10)
            .bottomSpaceToView(qrcodeView, 10)
            .widthIs(4);
            
            UILabel *recommendedLabel = [UILabel new];
            recommendedLabel.text = @"药品物流信息跟踪";
            recommendedLabel.font = [UIFont systemFontOfSize:16];
            [qrcodeView addSubview:recommendedLabel];
            
            recommendedLabel.sd_layout
            .leftSpaceToView(blueView, 15)
            .centerYEqualToView(qrcodeView)
            .heightIs(16);
            [recommendedLabel setSingleLineAutoResizeWithMaxWidth:200];
            
            UIView *line2View = [UIView new];
            line2View.backgroundColor = RGB(237, 237, 237);
            [footerView addSubview:line2View];
            
            line2View.sd_layout
            .leftSpaceToView(footerView, 0)
            .rightSpaceToView(footerView, 0)
            .heightIs(0.5)
            .topSpaceToView(qrcodeView,0);
            
            if (count > 0) {
                UIView *lastView = line2View;
                for (int i = 0; i < self.model.logistics_list.count; i++) {
                    
                    MedicationDetailsLogisticsModel *item = [self.model.logistics_list objectAtIndex:i];
                    
                    UIView *view = [UIView new];
                    view.backgroundColor = kPageBgColor;
                    [footerView addSubview:view];
                    
                    view.sd_layout
                    .leftSpaceToView(footerView, 0)
                    .rightSpaceToView(footerView, 0)
                    .topSpaceToView(lastView, 0);
                    
                    UIImageView *imageView = [UIImageView new];
                    imageView.image = [UIImage imageNamed:@"Home_DrugIcon"];
                    imageView.contentMode = UIViewContentModeScaleAspectFit;
                    [view addSubview:imageView];
                    
                    imageView.sd_layout
                    .leftSpaceToView(view, 10)
                    .topSpaceToView(view, 0)
                    .widthIs(20)
                    .heightEqualToWidth();
                    
                    UIView *line1View = [UIView new];
                    line1View.backgroundColor = [UIColor lightGrayColor];
                    [view addSubview:line1View];
                    
                    CGFloat bottom = i < self.model.logistics_list.count - 1 ? -15 : 0;
                    line1View.sd_layout
                    .centerXEqualToView(imageView)
                    .topSpaceToView(imageView, 0)
                    .bottomSpaceToView(view, bottom)
                    .widthIs(0.5);
                    
                    UILabel *recommendedLabel = [UILabel new];
                    recommendedLabel.text = item.context;
                    recommendedLabel.textColor = i == 0 ? [UIColor redColor] : kMainColor;
                    recommendedLabel.font = [UIFont systemFontOfSize:14];
                    recommendedLabel.numberOfLines = 0;
                    [view addSubview:recommendedLabel];
                    
                    recommendedLabel.sd_layout
                    .leftSpaceToView(imageView, 15).rightSpaceToView(view, 15)
                    .topSpaceToView(view, 5)
                    .autoHeightRatio(0);
                    
                    UILabel *timeLabel = [UILabel new];
                    timeLabel.text = item.ftime;
                    timeLabel.textColor = kMainColor;
                    timeLabel.font = [UIFont systemFontOfSize:14];
                    [view addSubview:timeLabel];
                    
                    timeLabel.sd_layout
                    .leftSpaceToView(imageView, 15)
                    .topSpaceToView(recommendedLabel, 10)
                    .heightIs(14);
                    [timeLabel setSingleLineAutoResizeWithMaxWidth:300];
                    
                    [view setupAutoHeightWithBottomView:timeLabel bottomMargin:15];
                    
                    lastView = view;
                }
                [footerView setupAutoHeightWithBottomView:lastView bottomMargin:20];
                
                WS(weakSelf)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.footerView.height = CGRectGetMaxY(lastView.frame) + 20;
                    weakSelf.myTable.tableFooterView = weakSelf.footerView;
                });
            }
            else {
                UILabel *label = [[UILabel alloc] init];
                label.text = @"暂无物流信息";
                label.textColor = kNightColor;
                label.textAlignment = NSTextAlignmentCenter;
                label.font = kFontRegular(14);
                [footerView addSubview:label];
                
                label.sd_layout.topSpaceToView(line2View, 30).widthIs(150).heightIs(20).centerXEqualToView(footerView);
                [footerView setupAutoHeightWithBottomView:label bottomMargin:20];
            }
        }
    }
 
    return footerView;
}

-(void)reloadStatus:(NSString *)status payStatus:(NSString *)payStatus {
//
//    _status = status;
//
//    if ([_status isEqualToString:@"0001"]) {
//        self.stateLabel.text = @"已支付";
//        self.stateLabel.textColor = kMainColor;
//    }else if ([_status isEqualToString:@"0000"]){
//        self.stateLabel.text = @"未支付";
//        self.stateLabel.textColor = [UIColor redColor];
//    }else if ([_status isEqualToString:@"-1"]){
//        self.stateLabel.text = @"未生效";
//        self.stateLabel.textColor = [UIColor blackColor];
//    }else if ([_status isEqualToString:@"0004"]){
//        self.stateLabel.text = @"已取消";
//        self.stateLabel.textColor = [UIColor blackColor];
//    }else if ([_status isEqualToString:@"0009"]){
//        self.stateLabel.text = @"已配货";
//    }else if ([_status isEqualToString:@"0005"]){
//        self.stateLabel.text = @"已发货";
//    }else if ([_status isEqualToString:@"0006"]){
//        self.stateLabel.text = @"已收货";
//    }else{
//        self.stateLabel.text = @"未购买";
//        self.stateLabel.textColor = [UIColor redColor];
//    }
    self.status = status;
    /**
     状态: -1 未生效
     0 未发送
     1 未购买
     0000 订单确认 0001 等待配货 0003 待发货
     0005 已发货 0007 已收货(已签收) 0009 已调拨
     0010 已取消 0011 已删除
     */
    NSString *txt = @"未生效";
    if ([status isEqualToString:@"0"]) {
        txt = @"未发送";
    }else if ([status isEqualToString:@"1"]){
        txt = @"未购买";
    }else if ([status isEqualToString:@"0000"]){
        txt = @"已确认";
    }else if ([status isEqualToString:@"0001"]){
        txt = @"待配货";
    }else if ([status isEqualToString:@"0003"]){
        txt = @"待发货";
    }else if ([status isEqualToString:@"0005"]){
        txt = @"已发货";
    }else if ([status isEqualToString:@"0007"]){
        txt = @"已签收";
    }else if ([status isEqualToString:@"0009"]){
        txt = @"已调拨";
    }else if ([status isEqualToString:@"0010"]){
        txt = @"已取消";
    }else if ([status isEqualToString:@"0011"]){
        txt = @"已删除";
    }
    
    /**
     支付状态: 0000 未支付 0001 支付成功 0002 支付失败 0004 取消支付 0003 支付中
     */
    if (payStatus && [payStatus isEqualToString:@"0001"]) {
        txt = [txt stringByAppendingString:@" | 支付成功"];
    }
    else if (payStatus && [payStatus isEqualToString:@"0002"]) {
        txt = [txt stringByAppendingString:@" | 支付失败"];
    }
    else if (payStatus && [payStatus isEqualToString:@"0003"]) {
        txt = [txt stringByAppendingString:@" | 支付中"];
    }
    else if (payStatus && [payStatus isEqualToString:@"0004"]) {
        txt = [txt stringByAppendingString:@" | 取消支付"];
    }
    else {
        txt = [txt stringByAppendingString:@" | 未支付"];
    }
    
    self.stateLabel.text = txt;
}

-(void)qrcode:(UITapGestureRecognizer *)sender{
    
    self.qrcodeBGView = [UIView new];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.qrcodeBGView];
    
    self.qrcodeBGView.sd_layout
    .xIs(0)
    .yIs(0)
    .widthIs(ScreenWidth)
    .heightIs(ScreenHeight);
    
    [self qrcode];
    
}

-(void)qrcode{
    
    UIView *bgView = [UIView new];
    bgView .backgroundColor = RGBA(51, 51, 51, 0.7);
    bgView .userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [bgView  addGestureRecognizer:backTap];
    [self.qrcodeBGView addSubview:bgView];
    
    bgView.sd_layout
    .leftSpaceToView(self.qrcodeBGView, 0)
    .rightSpaceToView(self.qrcodeBGView, 0)
    .topSpaceToView(self.qrcodeBGView, 0)
    .bottomSpaceToView(self.qrcodeBGView, 0);
    
    UIView *whiteBGView = [UIView new];
    whiteBGView.backgroundColor = [UIColor whiteColor];
    [self.qrcodeBGView addSubview:whiteBGView];
    
    whiteBGView.sd_layout
    .centerYEqualToView(self.qrcodeBGView)
    .centerXEqualToView(self.qrcodeBGView)
    .widthRatioToView(self.qrcodeBGView, 0.8);
//    .heightRatioToView(self.qrcodeBGView, 0.8);
    
    UIImageView *imageView = [UIImageView new];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.cf_qrcode]];
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [whiteBGView addSubview:imageView];
    
    imageView.sd_layout
    .leftSpaceToView(whiteBGView, 50)
    .rightSpaceToView(whiteBGView, 50)
    .topSpaceToView(whiteBGView, 20)
    .heightEqualToWidth();
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [whiteBGView addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(whiteBGView, 0)
    .rightSpaceToView(whiteBGView, 0)
    .heightIs(0.5)
    .topSpaceToView(imageView, 20);
    
    UILabel *shareLabel = [UILabel new];
    shareLabel.text = @"分享到";
    shareLabel.font = [UIFont systemFontOfSize:14];
    [whiteBGView addSubview:shareLabel];
    
    shareLabel.sd_layout
    .centerXEqualToView(whiteBGView)
    .topSpaceToView(lineView, 10)
    .heightIs(16);
    [shareLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    UIImageView *wxImageView = [UIImageView new];
    wxImageView.image = [UIImage imageNamed:@"Home_WX"];
    wxImageView.userInteractionEnabled = YES;
    wxImageView.layer.cornerRadius = 30;
    wxImageView.layer.masksToBounds = YES;
    wxImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *wxTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wx:)];
    [wxImageView addGestureRecognizer:wxTap];
    [whiteBGView addSubview:wxImageView];
    
    wxImageView.sd_layout
    .centerXEqualToView(whiteBGView)
    .topSpaceToView(shareLabel, 10)
    .widthIs(60)
    .heightEqualToWidth();
    
    UILabel *wxLabel = [UILabel new];
    wxLabel.text = @"微信";
    wxLabel.font = [UIFont systemFontOfSize:14];
    [whiteBGView addSubview:wxLabel];
    
    wxLabel.sd_layout
    .centerXEqualToView(whiteBGView)
    .topSpaceToView(wxImageView, 5)
    .heightIs(14);
    [wxLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    [whiteBGView setupAutoHeightWithBottomView:wxLabel bottomMargin:14];
}

-(void)wx:(UITapGestureRecognizer *)sender{
    
    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = [NSString stringWithFormat:@"我是%@医生，现推荐你用一下药物，请先关注我的微信公众号...",GetUserDefault(UserName)];
    message.title = [NSString stringWithFormat:@"我是%@医生，欢迎关注我的幸好健康医生端公众账号，以便于为你提供一体化服务。",GetUserDefault(UserName)];
    //http://nkwx.6ewei.com/yy/views/scan.html#/yyscan?recipe_id=
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = [NSString stringWithFormat:@"http://nkwx.6ewei.com/yy/views/scan.html#/yyscan?recipe_id=%@",self.recipeid];
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
    
}

-(void)back{
    
    [self.qrcodeBGView removeFromSuperview];
    
}

@end
