//
//  DocCircleFilterView.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DocCircleFilterConfirm)(NSString *start, NSString *end, NSString *keyword);

@interface DocCircleFilterView : UIView

- (void)showFilterView:(DocCircleFilterConfirm)block;

@end
