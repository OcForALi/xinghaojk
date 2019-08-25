
//
//  XmlDrugRequest.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/29.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "XmlDrugRequest.h"

@interface XmlDrugRequest ()

/// 数据源
@property (nonatomic, strong) NSMutableDictionary *dataDict;
/// xml字段
@property (nonatomic, strong) NSString *xmlString;
/// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
/// 临时数据
@property (nonatomic, strong) NSMutableArray *items;
/// 临时字典
@property (nonatomic, strong) NSMutableDictionary *itemsDict;

@end

@implementation XmlDrugRequest


- (instancetype)init {
    
    if (self = [super init]) {
        
        self.items = [NSMutableArray array];
        self.dataSource = [NSMutableArray array];
        self.dataDict = [NSMutableDictionary dictionaryWithDictionary:@{@"id" : @"", @"name" : @"", @"items" : @[]}];
        self.itemsDict = [NSMutableDictionary dictionaryWithDictionary:@{@"id" : @"", @"name" : @""}];
    }
    
    return self;
}

- (void)setXmlData:(NSData *)xmlData {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - NSXMLParserDelegate
// 开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    [self.dataDict removeAllObjects];
}

// 获取值
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    self.xmlString = string;
}

// 获取Key
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    elementName = [elementName stringByReplacingOccurrencesOfString:@"d2p1:" withString:@""];
    
    // 获取ID 然后判断是否连着连续则创建items，否则创建字典保存
    if ([elementName isEqualToString:@"id"]) {
        
        if ([self.dataDict[@"id"] length] == 0) {
            self.dataDict[@"id"] = self.xmlString;
        }
        else {
            self.itemsDict[@"id"] = self.xmlString;
        }
    }
    
    // 数组
    if ([elementName isEqualToString:@"items"]) {
        self.dataDict[@"items"] = [self.items mutableCopy];
        [self.items removeAllObjects];
    }
    
    // 判断是否数组结束，是则保存进 itemsDict ，否则跟ID保存在一起
    if ([elementName isEqualToString:@"name"]) {
        
        if ([self.dataDict[@"items"] count] > 0 && [self.dataDict[@"id"] length] > 0) {
            
            self.dataDict[@"name"] = self.xmlString;
        }
        else if ([self.dataDict[@"id"] isEqualToString:@"16"]) {
            
            self.dataDict[@"name"] = self.xmlString;
        }
        else {
            
            self.itemsDict[@"name"] = self.xmlString;
            [self.items addObject:self.itemsDict];
            
            self.itemsDict = [NSMutableDictionary dictionaryWithDictionary:@{@"id" : @"", @"name" : @""}];
        }
    }
    
    // 将 itemsDict 保存进数组并清空
    if ([elementName isEqualToString:@"DrugClassItem"]) {
        
        [self.dataSource addObject:self.dataDict];
        self.dataDict = [NSMutableDictionary dictionaryWithDictionary:@{@"id" : @"", @"name" : @"", @"items" : @[]}];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {

    dispatch_async(dispatch_get_main_queue(), ^{
        self.xmlParsingSuccessBlock(self.dataSource);
    });
}

@end
