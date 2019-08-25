//
//  PrescriptionModel.m
//  GanLuXiangBan
//
//  Created by hollywater on 2019/3/23.
//  Copyright © 2019 CICI. All rights reserved.
//

#import "PrescriptionModel.h"

@implementation PrescriptionAddDrugModel

@end

@implementation PrescriptionAddModel

@end

@implementation SendRecipePost

@end


@implementation PrescriptionDrugModel

+ (instancetype)initWithDes:(NSString *)des {
    NSArray *arr = [des componentsSeparatedByString:@"#"];
    PrescriptionDrugModel *obj = [PrescriptionDrugModel new];
    if (arr && arr.count >= 4) {
        obj.drugId = arr[0];
        obj.name = arr[1];
        obj.alia = arr[2];
        obj.num = arr[3];
        if (arr.count >= 5) {
            obj.status = [arr[4] integerValue];
        }
        else {
            obj.status = 1;
        }
    }
    return obj;
}

@end

@implementation PrescriptionModel

- (NSArray *)drugs {
    if (!_drugs) {
        if (self.drug_use_str && self.drug_use_str.length > 0) {
            NSMutableArray *list = [NSMutableArray new];
            NSArray *res = [self.drug_use_str componentsSeparatedByString:@";"];
            if (res && res.count > 0) {
                for (NSString *item in res) {
                    PrescriptionDrugModel *obj = [PrescriptionDrugModel initWithDes:item];
                    [list addObject:obj];
                }
            }
            _drugs = list;
        }
        else {
            _drugs = [NSArray array];
        }
    }
    return _drugs;
}

@end



@implementation PrescriptionDetailModel


@end
