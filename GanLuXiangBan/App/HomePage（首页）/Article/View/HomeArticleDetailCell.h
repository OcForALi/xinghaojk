//
//  HomeArticleDetailCell.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/3.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeArticleDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end



@interface HomeArticleDetailHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end



@interface HomeArticleDetailPictureCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@end



@interface HomeArticleDetailTagCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end
