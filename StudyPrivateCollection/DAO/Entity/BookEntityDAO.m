//
//  BookEntityDAO.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "BookEntityDAO.h"

@implementation BookEntityDAO

+ (long long)insertModel:(BookEntity *)bookEntity withDataBase:(FMDatabase *)db {
    
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_ENTITY (doubanId, isbn10, isbn13, title, doubanURL, image, pubdate, publisher, price, summary, author_intro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", @(bookEntity.doubanId), bookEntity.isbn10, bookEntity.isbn13, bookEntity.title, bookEntity.doubanUrl, bookEntity.image, bookEntity.pubdate, bookEntity.publisher, bookEntity.price, bookEntity.summary, bookEntity.author_intro];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
    
}

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDataBase:(FMDatabase *)db {
                                                                                
    FMResultSet *result = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY WHERE doubanId = ?", @(doubanId)];
    
    if ([result next]) {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:result];
        [result close];
        return entity;
    }
    
    return nil;
    
}


+ (BOOL)deleteModelWithId:(long long)id withDataBase:(FMDatabase *)db {
    
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_ENTITY WHERE id = ?", @(id)];
    
    return success;
    
}

+ (NSArray<BookEntity *> *)queryAllModelsWithDataBase:(FMDatabase *)db {
    
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY"];
    while ([s next]) {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:s];
        [results addObject:entity];
    }
    
    [s close];
    
    return results;
    
}

@end
