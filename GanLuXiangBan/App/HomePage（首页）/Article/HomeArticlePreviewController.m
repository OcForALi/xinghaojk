//
//  HomeArticlePreviewController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeArticlePreviewController.h"

#import "HomeArticleDetailCell.h"
#import "HomeArticleRequest.h"

#import "HomeAddArticleViewController.h"
#import "HomeArticleSendController.h"

@interface HomeArticlePreviewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;
@end

@implementation HomeArticlePreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.canEdit) {
        WS(weakSelf)
        [self addNavRightTitle:@"编辑" complete:^{
            [weakSelf touchEditArticle];
        }];
    }
    if (self.model) {
        [self trimLetters];
    }
    [self loadArticleInfo];
}

- (NSString *)clearEnter:(NSString *)str {
    if (str && str.length > 0) {
        return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    return str;
}

- (void)trimLetters {
    self.model.NewsTitle = [self clearEnter:self.model.NewsTitle];
    self.model.NewsSTitle = [self clearEnter:self.model.NewsSTitle];
    self.model.Tags = [self clearEnter:self.model.Tags];
}

- (void)loadArticleInfo {
    NSInteger did = [GetUserDefault(UserID) integerValue];
    NSInteger cur = self.model.drid;
    if (self.model.pkid > 0 && did != cur) {
        WS(weakSelf)
        [[HomeArticleRequest new] detail:self.model.pkid complete:^(HttpGeneralBackModel *model) {
            
            if (model.data) {
                NSString *reld = weakSelf.model.ReleaseOn;
                NSString *crd = weakSelf.model.createOn;
                weakSelf.model = [HomeArticleSaveModel yy_modelWithJSON:model.data];
                [weakSelf trimLetters];
                if (!weakSelf.model.ReleaseOn) {
                    weakSelf.model.ReleaseOn = reld;
                }
                if (!weakSelf.model.createOn) {
                    weakSelf.model.createOn = crd;
                }
                [weakSelf.tableView reloadData];
                [weakSelf toggleSendButton];
            }
            
        }];
    }
    else {
        self.model.drname = GetUserDefault(UserName);
        self.model.drtitle = GetUserDefault(UserKSName);
        self.model.hospital_name = GetUserDefault(UserHospital);
    }
}

- (void)toggleSendButton {
    NSInteger did = [GetUserDefault(UserID) integerValue];
    NSInteger cur = self.model.drid;
    if (did != cur) {
        self.sendBtn.hidden = YES;
        [self.view setNeedsUpdateConstraints];
        self.tableViewBottomConstraint.constant = 0;
    }
}

#pragma mark - Action

- (void)touchEditArticle {
    NSInteger count = self.navigationController.viewControllers.count;
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:count-3];
    if (![vc isKindOfClass:HomeAddArticleViewController.class]) {
        vc = [self.navigationController.viewControllers objectAtIndex:count-2];
    }
    if ([vc isKindOfClass:HomeAddArticleViewController.class]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        HomeAddArticleViewController *edit = (HomeAddArticleViewController *)[self loadVC:@"HomeAddArticleViewController"];
        edit.model = self.model;
        edit.title = @"编辑文章";
        edit.canRemove = YES;
        [self.navigationController pushViewController:edit animated:YES];
    }
}

- (IBAction)touchSendArticle {
    HomeArticleSendController *vc = (HomeArticleSendController *)[self loadVC:@"HomeArticleSendController"];
    vc.pid = self.model.pkid;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 2;
    if (self.model) {
        if (self.model.Tags) {
            count++;
        }
        if (self.model.PageInfos) {
            count += self.model.PageInfos.count;
        }
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        HomeArticleDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeArticleDetailHeaderCell"];
        cell.titleLabel.text = self.model.NewsTitle;
        if (self.model.NewsSTitle && self.model.NewsSTitle.length > 0) {
            cell.subTitleLabel.text = [NSString stringWithFormat:@"--------%@",self.model.NewsSTitle];
        }
        else {
            cell.subTitleLabel.text = @"";
        }
        NSString *date = self.model.ReleaseOn ? self.model.ReleaseOn : self.model.createOn;
        if (date && date.length > 0) {
            date = [date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        }
        cell.dateLabel.text = date;
        cell.numberLabel.text = [NSString stringWithFormat:@"%@人阅读", @(self.model.clike)];
        if (self.model.drname && self.model.drtitle && self.model.hospital_name) {
            cell.infoLabel.text = [NSString stringWithFormat:@"%@   %@   %@",self.model.drname,self.model.drtitle,self.model.hospital_name];
        }
        else {
            cell.infoLabel.text = @"";
        }
        return cell;
    }
    else {
        HomeArticleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeArticleDetailCell"];
        if (self.model.Tags) {
            if (row == 1) {
                HomeArticleDetailTagCell *tagCell = [tableView dequeueReusableCellWithIdentifier:@"HomeArticleDetailTagCell"];
                tagCell.tagLabel.text = self.model.Tags;
                return tagCell;
            }
            else if (row == 2) {
                cell.titleLabel.text = self.model.Content;
                return cell;
            }
        }
        else if (row == 1) {
            cell.titleLabel.text = self.model.Content;
            return cell;
        }
        
        row-=2;
        if (self.model.Tags) {
            row--;
        }
        NSArray *list = self.model.PageInfos;
        if (list && row < list.count) {
            HomeArticlePageModel *page = [list objectAtIndex:row];
            if (page.image || (page.file_path && [page.file_path rangeOfString:@"http"].location != NSNotFound)) {
                HomeArticleDetailPictureCell *picell = [tableView dequeueReusableCellWithIdentifier:@"HomeArticleDetailPictureCell"];
                if (page.image) {
                    picell.pictureView.image = page.image;
                }
                else if (page.file_path) {
                    [picell.pictureView sd_setImageWithURL:[NSURL URLWithString:page.file_path]];
                }
                return picell;
            }
            else {
                cell.titleLabel.text = page.content;
            }
        }
        return cell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        CGFloat height = [self cpHeight:self.model.NewsTitle font:16];
        height += [self cpHeight:self.model.NewsSTitle font:13];
        height += 40;
        return height > 120 ? height : 120;
    }
    else {
        if (self.model.Tags) {
            if (row == 1) {
                return [self cpHeight:self.model.Tags font:14] + 10;
            }
            else if (row == 2) {
                return [self cpHeight:self.model.Content font:14];
            }
        }
        else if (row == 1) {
            return [self cpHeight:self.model.Content font:14];
        }
        row-=2;
        if (self.model.Tags) {
            row--;
        }
        NSArray *list = self.model.PageInfos;
        HomeArticlePageModel *page = [list objectAtIndex:row];
        if (page.image || (page.file_path && [page.file_path rangeOfString:@"http"].location != NSNotFound)) {
            return 200;
        }
        else {
            return [self cpHeight:page.content font:14];
        }
    }
}

- (CGFloat)cpHeight:(NSString *)content font:(CGFloat)font {
    if (!content) {
        return 8;
    }
    CGFloat height = [content boundingRectWithSize:CGSizeMake(ScreenWidth-30, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFontRegular(font)} context:nil].size.height;
    return ceilf(height) + font;
}

@end
