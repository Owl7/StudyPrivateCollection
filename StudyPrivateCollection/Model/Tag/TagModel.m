//
//  TagModel.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    TagModel *tag = [[[self class] alloc] init];
    
    tag.bookId = [[dic objectForKey:@"bookId"] longLongValue];
    tag.name = [dic objectForKey:@"name"];
    tag.count = [[dic objectForKey:@"count"] longLongValue];
    
    return tag;
    
}

- (instancetype)initWithFMResultSet:(FMResultSet *)result {
    
    TagModel *tag = [[[self class] alloc] init];
    
    tag.bookId = [result longLongIntForColumn:@"bookId"];
    tag.name = [result stringForColumn:@"name"];
    tag.count = [result longForColumn:@"count"];
    
    return tag;
    
}

- (id)copyWithZone:(NSZone *)zone {
    
    TagModel *tag = [[[self class] allocWithZone:zone] init];
    
    tag.bookId = self.bookId;
    tag.name = [self.name copy];
    tag.count = self.count;
    
    return tag;
    
}


@end
