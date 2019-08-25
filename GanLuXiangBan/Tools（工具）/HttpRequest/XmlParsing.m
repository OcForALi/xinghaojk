//
//  XmlParsing.m
//  GanLuXiangBan
//
//  Created by M on 2018/5/6.
//  Copyright © 2018年 黄锡凯. All rights reserved.
//

#import "XmlParsing.h"

@interface XmlParsing () <NSXMLParserDelegate>

/// 数据源
@property (nonatomic, strong) NSMutableDictionary *dataDict;
/// xml字段
@property (nonatomic, strong) NSString *xmlString;

@end

@implementation XmlParsing

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.dataDict = [NSMutableDictionary dictionary];
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
    [self.dataDict setObject:self.xmlString forKey:elementName];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    dispatch_async(dispatch_get_main_queue(), ^{ 
        self.xmlParsingSuccessBlock(self.dataDict);
    });
}

@end
