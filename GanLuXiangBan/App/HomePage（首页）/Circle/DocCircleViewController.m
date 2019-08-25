//
//  DocCircleViewController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/8.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "DocCircleViewController.h"

#import "DocCircleTableView.h"
#import "DocCircleRequest.h"

#import "DocCircleExtentionController.h"

@interface DocCircleViewController ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *kdLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *actNumLabel;
@property (nonatomic, strong) DocCircleTableView *tableView;

@property (nonatomic, strong) DocCircleModel *model;
@end

@implementation DocCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"医生圈";
    [self setupTableList];
    
    [self loadDocCircleDatas];
}

- (void)loadDocCircleDatas {
    WS(weakSelf)
    [[DocCircleRequest new] doctors:@"" startDate:@"" endDate:@"" isScreen:NO complete:^(HttpGeneralBackModel *object) {
        if (object.retcode == 0 && object.data) {
            weakSelf.model = [DocCircleModel yy_modelWithJSON:object.data];
            [weakSelf showDatas];
        }
        else if (object.retmsg) {
            [weakSelf.view makeToast:object.retmsg];
        }
    }];
}

- (void)showDatas {
    if (self.model) {
        self.numLabel.text = [NSString stringWithFormat:@"%@人", self.model.sumDoctor];
        self.kdLabel.text = [NSString stringWithFormat:@"%@张", self.model.sumOrder];
        self.moneyLabel.text = [NSString stringWithFormat:@"%@元", self.model.sumAmount];
        self.actNumLabel.text = [NSString stringWithFormat:@"%@人", self.model.sumPass];
//        [self resetDocKpi:@[self.model.tree_3level]];
        self.tableView.model = self.model.tree_3level;
        [self.tableView reloadData];
    }
}

//- (void)resetDocKpi:(NSArray *)list {
//    for (DocCircleLevelBaseModel *item in list) {
//        item.pass = [self checkRedPoint:item.invited_drid];
//        [self resetDocKpi:item.childs];
//    }
//}
//
//- (BOOL)checkRedPoint:(NSInteger)docId {
//    NSArray *kpi = self.model.dr_kpi_item;
//    if (kpi && kpi.count > 0) {
//        for (DocCircleLevelBaseModel *item in kpi) {
//            if (docId == item.invited_drid) {
//                return YES;
//            }
//        }
//    }
//    return NO;
//}

- (void)touchCircleStaticDatas:(UIButton *)button {
    NSInteger tag = button.tag - 10;
    if (self.model && tag < 3) {
        DocCircleExtentionController *vc = [DocCircleExtentionController new];
        vc.model = self.model;
        if (tag == 0) {
            vc.type = DocCircleShowTypeDoc;
        }
        else if (tag == 1) {
            vc.type = DocCircleShowTypeNum;
        }
        else {
            vc.type = DocCircleShowTypeMoney;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UI

- (void)setupTableList {
    [self.view addSubview:self.headerView];
    
    self.tableView = [[DocCircleTableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.topSpaceToView(self.headerView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
}

- (UIView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tt = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
        tt.text = @"统计概览";
        tt.font = kFontMedium(16);
        tt.textColor = [UIColor blackColor];
        [_headerView addSubview:tt];
        
        NSArray *titles = @[@"拓展医生", @"开单数", @"开单金额", @"活跃医生数"];
        NSArray *secunit = @[@"0人", @"0张", @"0元", @"0人"];
        NSInteger count = titles.count;
        CGFloat y = 40;
        for (int i = 0; i < count; i++) {
            
//            UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            bgBtn.frame = CGRectMake(ScreenWidth / 3 * i, 0, ScreenWidth / 3, self.headerView.height);
//            [_headerView addSubview:bgBtn];
            UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / count * i, y, ScreenWidth / count, 100)];
//            bgBtn.frame = CGRectMake(ScreenWidth / 3 * i, 0, ScreenWidth / 3, self.headerView.height);
            [_headerView addSubview:itemView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, itemView.width, 15)];
            titleLabel.text = titles[i];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [itemView addSubview:titleLabel];
            
            UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(titleLabel.frame) + 15, itemView.width-10, 25)];
            numberLabel.text = secunit[i];
            numberLabel.font = kFontMedium(18);
            numberLabel.textColor = kMainColor;
            numberLabel.textAlignment = NSTextAlignmentCenter;
            numberLabel.height = [numberLabel getTextHeight];
            numberLabel.adjustsFontSizeToFitWidth = YES;
            [itemView addSubview:numberLabel];
            if (i == 0) {
                self.numLabel = numberLabel;
            }
            else if (i == 1) {
                self.kdLabel = numberLabel;
            }
            else if (i == 2) {
                self.moneyLabel = numberLabel;
            }
            else if (i == 3) {
                self.actNumLabel = numberLabel;
            }
            
//            _headerView.height = CGRectGetMaxY(numberLabel.frame) + 15;
            
            if (i > 0) {
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / count * i, y+15, 0.5, itemView.height - 50)];
                lineView.backgroundColor = kLineColor;
                [_headerView addSubview:lineView];
            }
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = itemView.bounds;
            btn.tag = i + 10;
            [btn addTarget:self action:@selector(touchCircleStaticDatas:) forControlEvents:UIControlEventTouchUpInside];
            [itemView addSubview:btn];
        }
        UIView *sec = [[UIView alloc] initWithFrame:CGRectMake(0, y+90, self.headerView.width, _headerView.height-90-y)];
        sec.backgroundColor = kPageBgColor;
        [_headerView addSubview:sec];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, sec.height)];
        label.text = @"扩展关系";
        label.font = kFontMedium(16);
        label.textColor = [UIColor blackColor];
        [sec addSubview:label];
    }
    return _headerView;
}

@end
