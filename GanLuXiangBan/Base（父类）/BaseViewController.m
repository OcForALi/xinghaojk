//
//  BaseViewController.m
//  GanLuXiangBan
//
//  Created by M on 2018/4/30.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <RTRootNavigationController/RTRootNavigationController.h>
#import "BaseViewController.h"
#import <MBProgressHUD.h>

@interface BaseViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) UIActionSheet *sheet;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation BaseViewController
@synthesize hud;

- (instancetype)loadVC:(NSString *)vcId {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:vcId];
}

- (void)viewDidLoad {

    [super viewDidLoad];

    self.view.backgroundColor = kPageBgColor;
    [self setNavigationItem];
    
    // 导航栏高度
    self.navBarHeight = self.navigationController.navigationBar.frame.size.height;
    // 状态栏高度
    self.statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    // 导航总高度
    self.navHeight = self.navBarHeight + self.statusBarHeight;
    // tabBar高度
    self.tabBarHeight = self.tabBarController.tabBar.frame.size.height;
}

#pragma mark - 状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - 导航
- (void)setNavigationItem {
    
    self.navigationController.navigationBar.barTintColor = kMainColor;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    
}

- (void)addNavRightTitle:(NSString *)titleString complete:(void (^)())complete {
    [self addNavRightTitle:titleString width:46 complete:complete];
}

- (void)addNavRightTitle:(NSString *)titleString width:(CGFloat)width complete:(void (^)())complete {
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, 0, width, 44);
    saveBtn.backgroundColor = kMainColor;
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [saveBtn setTitle:titleString forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (complete) {
            complete();
        }
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
}

#pragma mark - 返回按钮
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 34, 40);
    [btn setImage:[UIImage imageNamed:@"backImg"] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    
    return YES;
}

#pragma mark - 提示框
- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg isShowCancel:(BOOL)isShowCancel complete:(void (^)())complete {
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            complete();
        }];
        [alertController addAction:action];
        
        if (isShowCancel) {
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

#pragma mark - ActionSheet
- (void)actionSheetWithTitle:(NSString *)title titles:(NSArray *)titles isCan:(BOOL)isCan completeBlock:(ActionSheetCompleteBlock)actionSheetComplete {
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        self.complete = actionSheetComplete;
        self.sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:isCan ? @"取消" : nil destructiveButtonTitle:nil otherButtonTitles:nil];
        self.sheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        for (int i = 0; i < titles.count; i++) {
            [self.sheet addButtonWithTitle:titles[i]];
        }
        
        [self.sheet showInView:self.view];
    });
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.complete) {
        self.complete(buttonIndex);
    }
    
    [self.sheet dismissWithClickedButtonIndex:0 animated:YES];
}




- (void)showHudAnimated:(BOOL)animated {
    
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
     
        @strongify(self);
        if (self.hud && self.hud.superview == self.view) {
            return;
        }
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:animated];
        self.hud.label.text = @"正在加载中";
    });
    
}

- (void)hideHudAnimated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (UIButton *)setupBottomButton:(NSString *)title {
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    commit.backgroundColor = kMainColor;
    [commit.titleLabel setFont:kFontMedium(18)];
    [commit setTitle:title forState:UIControlStateNormal];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:commit];
    commit.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, kTabbarSafeBottomMargin).heightIs(49);
    return commit;
}

@end
