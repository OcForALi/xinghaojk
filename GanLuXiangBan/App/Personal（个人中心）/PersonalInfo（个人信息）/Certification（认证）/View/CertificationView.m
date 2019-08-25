//
//  CertificationView.m
//  GanLuXiangBan
//
//  Created by M on 2018/6/5.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "CertificationView.h"
#import "CertificationCell.h"
#import "TipCell.h"

@interface CertificationView () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat tipCellHeight;
@property (nonatomic, strong) UIImageView *currentImgView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation CertificationView

- (void)setCerImgModel:(CerImgModel *)cerImgModel {
    
    _cerImgModel = cerImgModel;
    [self reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        self.backgroundColor = [UIColor colorWithHexString:@"0xc6c6c6"];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == self.dataSources.count) {
        return 1;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.dataSources.count) {
        
        TipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TipCell"];
        if (cell == nil) {
            
            cell = [[TipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TipCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        cell.tipContent = @"1、确保上传的身份证、工作证以及证书能清晰看到姓名、照片以及职业资格编号等重要的信息。 \n2、工作人员在收到您的申请后2-3个工作日内会完成验证，验证完成会发放积分奖励。 \n3、证书照片仅用于认证，患者及第三方不可见。";
        self.tipCellHeight = cell.tipCellHeight;
        return cell;
    }
    else if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {

            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 45)];
            titleLabel.text = @"样例";
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textAlignment = NSTextAlignmentRight;
            titleLabel.textColor = [UIColor colorWithHexString:@"0x3c3c3c"];
            cell.accessoryView = titleLabel;
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.dataSources[indexPath.section];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"0x3c3c3c"];
        return cell;
    }
    
    CertificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationCell"];
    if (cell == nil) {
        cell = [[CertificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CertificationCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        self.cellHeight = cell.userImgView.height;
    }
    
    cell.text = self.dataSources[indexPath.section];
    
    if (self.cerImgModel != nil) {
        
        NSArray *imgUrls;
        if (self.cerImgModel.isDoctorFiles) {
            imgUrls = @[self.cerImgModel.emp_card, self.cerImgModel.qualification_card, self.cerImgModel.practice_card];
        }
        else {
            imgUrls = @[self.cerImgModel.id_card_face, self.cerImgModel.id_card_con];
        }
        
        if (imgUrls.count != 0) {
            
            NSString *urlString = imgUrls[indexPath.section];
            if (urlString.length > 0) {
                
                urlString = urlString.length > 0 ? urlString : @"";
                [cell.userImgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.cerImgModel.auth_status integerValue] == 2) {
        return;
    }
    
    if (indexPath.row == 1) {
        
        NSArray *titles = @[@"拍照", @"从相册选取一张照片"];
        [self actionSheetWithTitle:nil titles:titles isCan:YES completeBlock:^(NSInteger index) {
            
            CertificationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            self.currentImgView = cell.userImgView;
            self.currentIndex = indexPath.section;
            [self openImagePickerControllerWithIndex:index];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.dataSources.count) {
        return self.tipCellHeight;
    }
    else if (indexPath.row == 1) {
        return self.cellHeight;
    }
    return 45;
}

#pragma mark - UIImagePickerController
- (void)openImagePickerControllerWithIndex:(NSInteger)index {
    
    if (index != 0) {
        
        NSUInteger sourceType = 0;
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            if (index == 1) {
                
                //拍照
                sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.sourceType = sourceType;
            }
            else if (index == 2) {
                
                //相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePickerController.sourceType = sourceType;
            }
        }
        else {
            
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.sourceType = sourceType;
        }

        if (self.goImgBlock) {
            self.goImgBlock(imagePickerController);
        }        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.currentImgView.image = image;

        if (self.uploadImg) {
            self.uploadImg(self.currentIndex, image);
        }
    });
}

@end
