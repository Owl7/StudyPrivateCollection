//
//  BookEntity.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 23/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookEntity.h"
#import "AuthorModel.h"
#import "TranslatorModel.h"
#import "TagModel.h"

@implementation BookEntity

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    BookEntity *bookEntity = [[[self class] alloc] init];
    
    bookEntity.doubanId = [[dic objectForKey:@"id"] longLongValue];
    bookEntity.isbn10 = [dic objectForKey:@"isbn10"];
    bookEntity.isbn13 = [dic objectForKey:@"isbn13"];
    bookEntity.title = [dic objectForKey:@"title"];
    bookEntity.doubanUrl = [dic objectForKey:@"alt"];
    bookEntity.image = [[dic objectForKey:@"images"] objectForKey:@"large"];
    bookEntity.publisher = [dic objectForKey:@"publisher"];
    bookEntity.price = [dic objectForKey:@"price"];
    bookEntity.summary = [dic objectForKey:@"summary"];
    bookEntity.author_intro = [dic objectForKey:@"author_intro"];
    bookEntity.pubdate = [dic objectForKey:@"pubdate"];
    
    NSMutableArray *authors = [@[] mutableCopy];
    [[dic objectForKey:@"author"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AuthorModel *authorModel = [AuthorModel new];
        [authorModel setName:obj];
        [authors addObject:authorModel];
    }];
    
    bookEntity.authors = authors;
    
    NSMutableArray *translators = [@[] mutableCopy];
    [[dic objectForKey:@"translator"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TranslatorModel *translatorModel = [TranslatorModel new];
        [translatorModel setName:obj];
        [translators addObject:translatorModel];
    }];
    
    bookEntity.translators = translators;
    
    bookEntity.tags = [self modelArrayFromDictArray:[dic objectForKey:@"tags"] withModelClass:[TagModel class]];
    
    return bookEntity;
    
}

- (id)copyWithZone:(NSZone *)zone {
    
    BookEntity *bookEntity = [[[self class] allocWithZone:zone] init];
    
    bookEntity.id = self.id;
    bookEntity.doubanId = self.doubanId;
    bookEntity.isbn10 = [self.isbn10 copy];
    bookEntity.isbn13 = [self.isbn13 copy];
    bookEntity.title = [self.title copy];
    bookEntity.doubanUrl = [self.doubanUrl copy];
    bookEntity.image = [self.image copy];
    bookEntity.publisher = [self.publisher copy];
    bookEntity.price = [self.price copy];
    bookEntity.summary = [self.summary copy];
    bookEntity.author_intro = [self.author_intro copy];
    bookEntity.translators = [self.translators copy];
    bookEntity.authors = [self.authors copy];
    bookEntity.tags = [self.tags copy];
    bookEntity.pubdate = [self.pubdate copy];
    
    return bookEntity;
    
}

@end
