//
//  XmlParsing.h
//  GanLuXiangBan
//
//  Created by M on 2018/5/6.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlParsing : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSData *xmlData;
@property (nonatomic, strong) void (^xmlParsingSuccessBlock)(NSMutableDictionary *dict);

@end
