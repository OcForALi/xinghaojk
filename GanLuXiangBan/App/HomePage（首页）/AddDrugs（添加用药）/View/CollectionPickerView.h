//
//  CollectionPickerView.h
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/25.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PickerAction) {
    PickerActionCancel,
    PickerActionConfirm,
    PickerActionCustom
};

typedef void(^PickerViewBlock)(PickerAction action, id model);

@interface CollectionPickerView : UIView

+ (void)show:(PickerType)type lastModel:(id)lastModel complete:(PickerViewBlock)complete;

@end
