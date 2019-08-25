//
//  FamousModel.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/6/30.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "BaseModel.h"


@interface FamousModel : BaseModel

@property (nonatomic, strong) NSArray *visits;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *hospital_name;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, assign) BOOL unread;

@property (nonatomic, assign) NSInteger drid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *cust_name;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *name;

@end


@interface FamousVisitModel : NSObject

@property (nonatomic, copy) NSString *pay_remark;//未开通

@property (nonatomic, assign) NSInteger pay_type;

@property (nonatomic, copy) NSString *visit_remark;//线下

@property (nonatomic, assign) NSInteger show_type;

@property (nonatomic, assign) NSInteger visit_type;

@property (nonatomic, assign) NSInteger pay_money;

@property (nonatomic, assign) NSInteger visit_id;

@end



@interface FamousGroupModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL expand;

@property (nonatomic, copy) NSString *info;

@end
