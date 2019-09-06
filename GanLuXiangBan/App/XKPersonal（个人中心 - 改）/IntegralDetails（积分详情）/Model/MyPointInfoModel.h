//
//  MyPointInfoModel.h
//  GanLuXiangBan
//
//  Created by Bruthlee on 2019/8/17.
//  Copyright © 2019 CICI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPointInfoDrugModel : NSObject
@property (nonatomic, copy) NSString *drug_name;// (string, optional): 药品名(商品名+通用名+规格) ,
@property (nonatomic, copy) NSString *price;// (string, optional): 价格 ,
@property (nonatomic, copy) NSString *qty;// (string, optional): 数量 ,
@property (nonatomic, copy) NSString *dosage;// (string, optional): 用法用量
@end

@interface MyPointInfoModel : NSObject
@property (nonatomic, copy) NSString *server_time;// (string, optional): 服务时间 ,
@property (nonatomic, assign) NSInteger points;// (integer, optional): 可获积分 ,
@property (nonatomic, copy) NSString *member_name;// (string, optional): 患者姓名 ,
@property (nonatomic, copy) NSString *gender;// (string, optional): 性别 ,
@property (nonatomic, assign) NSInteger age;// (integer, optional): 年龄 ,
@property (nonatomic, copy) NSString *rcd_result;// (string, optional): 临床诊断 ,
@property (nonatomic, strong) NSArray *rp_items;// (Array[vm_rp_detail], optional): 处方用药
@property (nonatomic, copy) NSString *pointsSource;// 积分来源
@property (nonatomic, copy) NSString *remarks;// 备注
@end
