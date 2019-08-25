//
//  HomeAddArticleCell.m
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/7/2.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "HomeAddArticleCell.h"


@implementation HomeAddArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    WS(weakSelf)
    [[self.inputBox rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        
        if (weakSelf.model) {
            weakSelf.model.content = x;
        }
        
    }];
}

@end


@implementation HomeAddArticleTextareaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    WS(weakSelf)
    [[self.textArea rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        
        if (weakSelf.model) {
            weakSelf.model.content = x;
        }
        if (!x || x.length == 0) {
            weakSelf.tipLabel.hidden = NO;
        }
        else {
            weakSelf.tipLabel.hidden = YES;
        }
        
    }];
}

@end


@implementation HomeAddArticleImageCell

@end
