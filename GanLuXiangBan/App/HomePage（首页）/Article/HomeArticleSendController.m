//
//  HomeArticleSendController.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/7.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeArticleSendController.h"

#import <MBProgressHUD.h>
#import "HomeArticleRequest.h"
#import "GroupEditorModel.h"

#import "GroupEditorViewController.h"
#import "PatientListViewController.h"
#import "HomeArticleViewController.h"

@interface HomeArticleSendController ()

@property (weak, nonatomic) IBOutlet UIImageView *allIcon;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *groupIcon;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@property (nonatomic, assign) BOOL isAll;
@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation HomeArticleSendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = kMainColor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    
    self.tableView.tableFooterView = [UIView new];
    self.numLabel.text = @"0";
    self.groupLabel.text = @"";
    self.userLabel.text = @"";
    
    [self loadCount];
    self.isAll = YES;
    self.allIcon.image = [UIImage imageNamed:@"SelectPatients"];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, 0, 44, 44);
    saveBtn.backgroundColor = kMainColor;
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self sendArticle];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
}

- (void)loadCount {
    WS(weakSelf)
    [[HomeArticleRequest new] patientCount:^(HttpGeneralBackModel *model) {
        
        if (model.data) {
            NSInteger count = [model.data integerValue];
            weakSelf.numLabel.text = [NSString stringWithFormat:@"共%@人", @(count)];
        }
        
    }];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 34, 40);
    [btn setImage:[UIImage imageNamed:@"backImg"] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (void)sendArticle {
    NSInteger type = 0;
    if (self.isAll == NO) {
        BOOL have = self.groups && self.groups.count > 0;
        if (!have) {
            have = self.users && self.users.count > 0;
        }
        if (!have) {
            [self.view makeToast:@"请选择发送对象"];
            return;
        }
        type = 1;
    }
    
    NSMutableArray *gids = [[NSMutableArray alloc] init];
    for (GroupEditorModel *item in self.groups) {
        [gids addObject:item.label];
    }
    NSMutableArray *uids = [[NSMutableArray alloc] init];
    for (GroupAddModel *item in self.users) {
        [uids addObject:item.mid];
    }
    
    [self showHudAnimated];
    WS(weakSelf)
    [[HomeArticleRequest new] send:self.pid type:type label:gids mids:uids attention:NO complete:^(HttpGeneralBackModel *model) {
        
        [weakSelf hideHudAnimated];
        if (model.retcode == 0) {
            [weakSelf.view makeToast:@"发送成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSArray *ctrls = weakSelf.navigationController.viewControllers;
                for (UIViewController *vc in ctrls) {
                    if ([vc isKindOfClass:HomeArticleViewController.class]) {
                        HomeArticleViewController *home = (HomeArticleViewController *)vc;
                        home.refresh = YES;
                        [weakSelf.navigationController popToViewController:vc animated:YES];
                        break;
                    }
                }
            });
        }
        else {
            [weakSelf.view makeToast:model.retmsg];
        }
        
    }];
}

- (void)showHudAnimated {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        @strongify(self);
        if (self.hud && self.hud.superview == self.view) {
            return;
        }
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.label.text = @"正在加载中";
    });
    
}

- (void)hideHudAnimated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *no = @"NoSelectPatients", *sel = @"SelectPatients";
    NSInteger row = indexPath.row;
    if (row == 0) {
        self.allIcon.image = [UIImage imageNamed:sel];
        self.groupIcon.image = [UIImage imageNamed:no];
        self.userIcon.image = [UIImage imageNamed:no];
        self.isAll = YES;
    }
    else {
        self.allIcon.image = [UIImage imageNamed:no];
        self.isAll = NO;
        if (row == 1) {
            self.groupIcon.image = [UIImage imageNamed:sel];
            self.userIcon.image = [UIImage imageNamed:no];
            self.users = nil;
            self.userLabel.text = @"";
            
            NSMutableArray *uids = [[NSMutableArray alloc] init];
            for (GroupEditorModel *item in self.groups) {
                [uids addObject:item.label];
            }
            GroupEditorViewController *group = [GroupEditorViewController new];
            group.pickGroup = YES;
            group.pickGroupIdS = uids;
            group.title = @"选择分组";
            [self.navigationController pushViewController:group animated:YES];
            WS(weakSelf)
            group.pickerGroupBlock = ^(NSArray *groups) {
                
                weakSelf.groups = groups;
                NSMutableArray *show = [[NSMutableArray alloc] init];
                for (GroupEditorModel *item in self.groups) {
                    [show addObject:item.name];
                }
                weakSelf.groupLabel.text = [show componentsJoinedByString:@"，"];
                
            };
        }
        else {
            self.userIcon.image = [UIImage imageNamed:sel];
            self.groupIcon.image = [UIImage imageNamed:no];
            self.groups = nil;
            self.groupLabel.text = @"";
            
            NSMutableArray *uids = [[NSMutableArray alloc] init];
            for (GroupAddModel *item in self.users) {
                [uids addObject:item.mid];
            }
            
            PatientListViewController *viewController = [PatientListViewController new];
            viewController.selectIdArray = uids;
            WS(weakSelf)
            [viewController setCompleteBlock:^(id object) {
                
                weakSelf.users = object;
                DebugLog(@"object: %@", object);
                NSMutableArray *show = [[NSMutableArray alloc] init];
                for (GroupAddModel *model in object) {
                    [show addObject:model.patient_name];
                    if (show.count > 2) {
                        break;
                    }
                }
                weakSelf.userLabel.text = [show componentsJoinedByString:@"，"];
                
            }];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
