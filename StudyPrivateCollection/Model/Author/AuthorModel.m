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
    
    return author;
    
}

- (id)copyWithZone:(NSZone *)zone {
    
    AuthorModel *author = [[[self class] allocWithZone:zone] init];
    
    author.bookId = self.bookId;
    author.name = [self.name copy];
    
    return author;
    
}

@end
