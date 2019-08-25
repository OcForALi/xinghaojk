//
//  MyCardViewModel.h
//  GanLuXiangBan
//
//  Created by M on 2018/6/2.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "HttpRequest.h"
#import "MyCardModel.h"
@interface MyCardViewModel : HttpRequest

/**
     获取所有银行

     @param complete 成功回调
 */
- (void)getAllBankComplete:(void (^)(id object))complete;

/**
     获取用户银行卡列表

     @param complete 成功回调
 */
- (void)getUserBankListComplete:(void (^)(id object))complete;

/**
     删除银行卡

     @param ids 银行ID数组
     @param complete 成功回调
 */
- (void)deleteBankWithIds:(NSArray *)ids complete:(void (^)(id object))complete;

/**
     添加银行卡

     @param cardperson 卡号用户
     @param bank 银行
     @param cardNumber 银行卡号
     @param complete 成功回调
 */
- (void)addBankWithCardperson:(NSString *)cardperson
                         bank:(NSString *)bank
                   cardNumber:(NSString *)cardNumber
                     complete:(void (^)(id object))complete;

/**
     设置默认银行卡

     @param idString 银行卡ID
     @param complete 成功回调
 */
- (void)setDefaultWithId:(NSString *)idString Complete:(void (^)(id))complete;

@end
