//
//  HomeAddArticleViewController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeAddArticleViewController.h"

#import "HomeAddArticleCell.h"
#import "HomeAddArticleModel.h"

#import "CertificationViewModel.h"
#import "HomeArticleRequest.h"

#import "HomeChooseArticleTypeController.h"
#import "HomeArticlePreviewController.h"
#import "HomeArticleSendController.h"
#import "HomeArticleViewController.h"

typedef NS_ENUM(NSInteger, ArticleSaveAction) {
    ArticleSaveActionNormal = 0,
    ArticleSaveActionSend,
    ArticleSaveActionPreview
};

@interface HomeAddArticleViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) HomeAddArticleModel *currentModel;
@property (nonatomic, copy) NSString *articleId;
@end

@implementation HomeAddArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.title || self.title.length == 0) {
        self.title = @"新建文章";
    }
    
    WS(weakSelf)
    [self addNavRightTitle:@"发表文章" width:80 complete:^{
        [weakSelf touchPublishArticle:ArticleSaveActionSend];
    }];
    
    if (self.canRemove == NO) {
        [self.footerView setNeedsUpdateConstraints];
        [self.deleteBtn removeFromSuperview];
    }
    
    if (self.model) {
        NSArray *pages = self.model.PageInfos;
        if (pages && pages.count > 0) {
            for (HomeArticlePageModel *page in pages) {
                BOOL png = page.file_path && [page.file_path rangeOfString:@"http"].location != NSNotFound;
                HomeAddArticleModel *item = [HomeAddArticleModel new];
                item.type = png ? ArticlePicture : ArticleParagraph;
                item.content = png ? page.file_path : page.content;
                item.drnews_id = page.drnews_id;
                [self.datas addObject:item];
            }
            [self.tableView reloadData];
        }
    }
}

#pragma mark - Data

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
        
        HomeAddArticleModel *title = [HomeAddArticleModel new];
        title.type = ArticleTitle;
        title.des = @"请输入文章标题(100字以内)";
        title.fixed = YES;
        if (self.model) {
            title.content = self.model.NewsTitle;
        }
        [self.datas addObject:title];
        
        HomeAddArticleModel *tags = [HomeAddArticleModel new];
        tags.type = ArticleTags;
        tags.fixed = YES;
        tags.des = @"请输入适用疾病，多个疾病请用空格分隔(100字以内)";
        [self.datas addObject:tags];
        if (self.model.Tags && self.model.Tags.length > 0) {
            tags.content = self.model.Tags;
        }
        
        if (self.model.NewsSTitle && self.model.NewsSTitle.length > 0) {
            HomeAddArticleModel *tags = [HomeAddArticleModel new];
            tags.type = ArticleSubTitle;
            tags.content = self.model.NewsSTitle;
            tags.des = @"请输入文章副标题(100字以内)";
            [self.datas addObject:tags];
        }
    }
    return _datas;
}

- (void)addData:(ArticleType)type {
    HomeAddArticleModel *model = [HomeAddArticleModel new];
    model.type = type;
    model.des = @"请输入";
    if (type == ArticleTitle) {
        NSInteger count = 0;
        for (HomeAddArticleModel *item in self.datas) {
            if (item.type != ArticlePicture && item.type != ArticleParagraph) {
                count++;
            }
        }
        if (count < 3) {
            model.des = @"请输入文章副标题";
            model.type = ArticleSubTitle;
            if (self.datas.count <= 2) {
                [self.datas addObject:model];
            }
            else {
                [self.datas insertObject:model atIndex:2];
            }
        }
    }
    else {
        [self.datas addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - Action

- (void)touchPublishArticle:(ArticleSaveAction)action {
    HomeAddArticleModel *title = [self.datas firstObject];
    if (!title.content || title.content.length == 0 || title.content.length > 100) {
        [self.view makeToast:title.des];
        return;
    }
    HomeAddArticleModel *subtitle = nil;
    for (HomeAddArticleModel *item in self.datas) {
        if (item.type == ArticleSubTitle) {
            subtitle = item;
            break;
        }
    }
    if (subtitle.content && subtitle.content.length > 100) {
        [self.view makeToast:@"文章副标题不能超过100字"];
        return;
    }
    HomeAddArticleModel *tags = nil;
    for (HomeAddArticleModel *item in self.datas) {
        if (item.type == ArticleTags) {
            tags = item;
            break;
        }
    }
    if (!tags.content || tags.content.length == 0 || tags.content.length > 100) {
        [self.view makeToast:tags.des];
        return;
    }
    HomeAddArticleModel *content = nil;
    for (HomeAddArticleModel *item in self.datas) {
        if (item.type == ArticleParagraph) {
            if (!content) {
                content = item;
            }
            if (item.content && item.content.length > 500) {
                [self.view makeToast:@"段落字数不能超过500"];
                return;
            }
        }
    }
    BOOL haveContent = content && content.content && content.content.length > 0;
    if (haveContent && content.content.length > 500) {
        [self.view makeToast:@"文章内容段落字数不能超过500"];
        return;
    }
    
    HomeAddArticleModel *image = nil;
    for (HomeAddArticleModel *item in self.datas) {
        if (item.type == ArticlePicture) {
            image = item;
            break;
        }
    }
    BOOL haveImage = image && (image.data || (image.content && image.content.length > 0));
    if (!haveContent && !haveImage) {
        [self.view makeToast:@"请输入文章内容或者上传至少一张图片"];
        return;
    }
    
    [self showHudAnimated:YES];
    [self checkFile:action];
}

- (IBAction)touchAddSection {
    NSInteger count = 0;
    for (HomeAddArticleModel *item in self.datas) {
        if (item.type != ArticlePicture && item.type != ArticleParagraph) {
            count++;
        }
    }
    
    HomeChooseArticleTypeController *add = (HomeChooseArticleTypeController *)[self loadVC:@"HomeChooseArticleTypeController"];
    add.hideTitle = count >= 3;
    [self.navigationController pushViewController:add animated:YES];
    
    WS(weakSelf)
    add.chooseArticleTypeBlock = ^(ArticleType type) {
        [weakSelf addData:type];
    };
}

- (IBAction)touchPreviewArticle {
    [self touchPublishArticle:ArticleSaveActionPreview];
}

- (HomeArticleSaveModel *)setupArticleModel {
    HomeAddArticleModel *title = [self.datas firstObject];
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    HomeArticleSaveModel *save = [HomeArticleSaveModel new];
    save.NewsTitle = title.content;
    save.PageInfos = pages;
    if (self.model) {
        save.pkid = self.model.pkid;
    }
    
    NSInteger no = 1;
    for (NSInteger index = 1; index < self.datas.count; index++) {
        HomeAddArticleModel *item = [self.datas objectAtIndex:index];
        if (item.type == ArticleSubTitle) {
            save.NewsSTitle = item.content;
        }
        else if (item.type == ArticleTags) {
            save.Tags = item.content;
        }
//        else if ((!save.Content || save.Content.length == 0) && item.type == ArticleParagraph) {
//            save.Content = item.content;
//        }
        else {
            HomeArticlePageModel *page = [HomeArticlePageModel new];
            page.number = no;
            page.drnews_id = item.drnews_id;
            if (item.type == ArticlePicture) {
                page.file_path = item.content;
                page.image = item.data;
            }
            else {
                page.content = item.content;
            }
            [pages addObject:page];
            no++;
        }
    }
    
    return save;
}

- (void)uploadFile:(HomeAddArticleModel *)model action:(ArticleSaveAction)action {
    UIImage *image = model.data;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    WS(weakSelf)
    [[CertificationViewModel new] uploadImageWithImgs:imageData complete:^(id object) {
        
        if (object) {
            model.content = object;
            [weakSelf checkFile:action];
        }
        else {
            [weakSelf hideHudAnimated];
            [weakSelf.view makeToast:@"请求超时，请重试"];
        }
        
    }];
}

- (void)checkFile:(ArticleSaveAction)action {
    BOOL have = NO;
    for (HomeAddArticleModel *item in self.datas) {
        if (item.type == ArticlePicture && (!item.content || item.content.length == 0)) {
            have = YES;
            [self uploadFile:item action:action];
            break;
        }
    }
    if (!have) {
        [self commitArticleDatas:action];
    }
}

- (void)commitArticleDatas:(ArticleSaveAction)action {
    HomeArticleSaveModel *save = [self setupArticleModel];
    WS(weakSelf)
    [[HomeArticleRequest new] save:save complete:^(HttpGeneralBackModel *model) {
        
        [weakSelf hideHudAnimated];
        
        if (model.retcode == 0) {
            HomeArticleViewController *home = nil;
            for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                if ([vc isKindOfClass:HomeArticleViewController.class]) {
                    home = (HomeArticleViewController *)vc;
                    home.refresh = YES;
                    break;
                }
            }
            
            NSInteger pid = save.pkid;
            if (model.data) {
                pid = [model.data integerValue];
                save.pkid = pid;
            }
            weakSelf.model = save;
            
            if (action == ArticleSaveActionSend) {
                HomeArticleSendController *vc = (HomeArticleSendController *)[self loadVC:@"HomeArticleSendController"];
                vc.pid = pid;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            else if (action == ArticleSaveActionPreview) {
//                NSMutableArray *list = [NSMutableArray arrayWithArray:weakSelf.navigationController.viewControllers];
//                for (UIViewController *vc in list) {
//                    if ([vc isKindOfClass:HomeArticlePreviewController.class]) {
//                        [list removeObject:vc];
//                        break;
//                    }
//                }
                HomeArticlePreviewController *preview = (HomeArticlePreviewController *)[self loadVC:@"HomeArticlePreviewController"];
                preview.model = save;
                preview.canEdit = YES;
                preview.title = @"预览";
                [weakSelf.navigationController pushViewController:preview animated:YES];
//                [list addObject:preview];
//                [weakSelf.navigationController setViewControllers:list animated:YES];
            }
            else {
                [weakSelf.view makeToast:@"保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (home) {
                        [weakSelf.navigationController popToViewController:home animated:YES];
                    }
                });
            }
        }
        else {
            [weakSelf.view makeToast:model.retmsg];
        }
        
    }];
}

- (IBAction)touchSaveArticle:(UIButton *)sender {
    [self touchPublishArticle:ArticleSaveActionNormal];
}

- (IBAction)touchDeleteArticle {
    NSInteger pid = self.model.pkid;
    if (pid <= 0) {
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定删除此文章？" preferredStyle:UIAlertControllerStyleAlert];
    WS(weakSelf)
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[HomeArticleRequest new] remove:pid complete:^(HttpGeneralBackModel *model) {
            
            if (model.retcode == 0) {
                [weakSelf.view makeToast:@"删除成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                        if ([vc isKindOfClass:HomeArticleViewController.class]) {
                            HomeArticleViewController *home = (HomeArticleViewController *)vc;
                            home.refresh = YES;
                            [weakSelf.navigationController popToViewController:home animated:YES];
                            break;
                        }
                    }
                });
            }
            else {
                [weakSelf.view makeToast:model.retmsg];
            }
            
        }];
        
    }];
    [alertController addAction:action];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)touchRemoveItem:(UIButton *)button {
    NSInteger index = button.tag - 100;
    if (index > 0 && index < self.datas.count) {
        [self.datas removeObjectAtIndex:index];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    HomeAddArticleModel *model = [self.datas objectAtIndex:row];
    if (model.type == ArticleParagraph) {
        HomeAddArticleTextareaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeAddArticleTextareaCell"];
        cell.textArea.tag = row;
        cell.deleteBtn.hidden = model.fixed;
        cell.deleteBtn.tag = 100 + row;
        cell.model = model;
        cell.tipLabel.text = model.des;
        cell.tipLabel.hidden = model.content && model.content.length > 0;
        cell.textArea.text = model.content;
        [cell.deleteBtn addTarget:self action:@selector(touchRemoveItem:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (model.type == ArticlePicture) {
        HomeAddArticleImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeAddArticleImageCell"];
        cell.picture.tag = row;
        if (model.data) {
            cell.picture.image = model.data;
        }
        else if (model.content) {
            [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.content]];
        }
        else {
            cell.picture.image = [UIImage imageNamed:@"pngdef"];
        }
        cell.deleteBtn.hidden = model.fixed;
        cell.deleteBtn.tag = 100 + row;
        [cell.deleteBtn addTarget:self action:@selector(touchRemoveItem:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else {
        HomeAddArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeAddArticleCell"];
        cell.inputBox.tag = row;
        cell.model = model;
        cell.inputBox.text = model.content;
        cell.deleteBtn.hidden = model.fixed;
        cell.deleteBtn.tag = 100 + row;
        [cell.deleteBtn addTarget:self action:@selector(touchRemoveItem:) forControlEvents:UIControlEventTouchUpInside];
        if (model.des && model.des.length > 0) {
            cell.inputBox.placeholder = model.des;
        }
        return cell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    HomeAddArticleModel *model = [self.datas objectAtIndex:row];
    if (model.type == ArticleParagraph) {
        return 180;
    }
    else if (model.type == ArticlePicture) {
        return 150;
    }
    else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    HomeAddArticleModel *model = [self.datas objectAtIndex:row];
    if (model.type == ArticlePicture) {
        self.currentModel = model;
        WS(weakSelf)
        [self actionSheetWithTitle:@"上传图片" titles:@[@"拍摄", @"从相册选取一张图片"] isCan:YES completeBlock:^(NSInteger index) {
            
            if (index == 1) {
                [weakSelf pickSource:UIImagePickerControllerSourceTypeCamera];
            }
            else if (index == 2) {
                [weakSelf pickSource:UIImagePickerControllerSourceTypePhotoLibrary];
            }
            
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)pickSource:(UIImagePickerControllerSourceType)type {
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = type;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:imagePickerController animated:YES completion:nil];
        });
    }
    else {
        NSString *msg = type == UIImagePickerControllerSourceTypeCamera ? @"相机使用权限未开启" : @"相册使用权限未开启";
        [self alertWithTitle:@"提示" msg:msg isShowCancel:NO complete:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    WS(weakSelf)
    [picker dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.currentModel) {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            weakSelf.currentModel.data = image;
            weakSelf.currentModel.content = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
    }];
}

@end
