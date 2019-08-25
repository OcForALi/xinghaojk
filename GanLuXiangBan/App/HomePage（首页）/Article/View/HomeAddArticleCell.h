//
//  HomeAddArticleCell.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeAddArticleModel.h"

@interface HomeAddArticleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *inputBox;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) HomeAddArticleModel *model;

@end


@interface HomeAddArticleTextareaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *textArea;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) HomeAddArticleModel *model;

@end


@interface HomeAddArticleImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
