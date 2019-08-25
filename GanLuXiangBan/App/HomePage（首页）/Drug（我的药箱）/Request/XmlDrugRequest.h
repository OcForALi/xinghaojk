//
//  XmlDrugRequest.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/29.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlDrugRequest : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSData *xmlData;
@property (nonatomic, strong) void (^xmlParsingSuccessBlock)(NSArray *dataSource);

@end
