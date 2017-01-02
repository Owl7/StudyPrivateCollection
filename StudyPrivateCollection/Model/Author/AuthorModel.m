//
//  AuthorModel.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "AuthorModel.h"

@implementation AuthorModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    AuthorModel *author = [[[self class] alloc] init];
    
    author.bookId = [[dic objectForKey:@"bookId"] longLongValue];
    author.name = [dic objectForKey:@"name"];
    
    float red = (arc4random() % 256);
    float green = (arc4random() % 256);
    float blue = (arc4random() % 256);
    
    author.color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    
    return author;
    
}

- (instancetype)initWithFMResultSet:(FMResultSet *)result {
    
    AuthorModel *author = [[[self class] alloc] init];
    
    author.bookId = [result longLongIntForColumn:@"bookId"];
    author.name = [result stringForColumn:@"name"];
    
    return author;
    
}

- (id)copyWithZone:(NSZone *)zone {
    
    AuthorModel *author = [[[self class] allocWithZone:zone] init];
    
    author.bookId = self.bookId;
    author.name = [self.name copy];
    
    return author;
    
}

@end
