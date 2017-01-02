//
//  AuthorDAO.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "AuthorDAO.h"

@implementation AuthorDAO

+ (long long)insertModel:(AuthorModel *)authorModel withDataBase:(FMDatabase *)db {
    
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_AUTHOR (bookId, name) VALUES (?, ?)", @(authorModel.bookId), authorModel.name];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
    
}

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_AUTHOR WHERE bookId = ?", @(bookId)];
    
    return success;
    
}

+ (NSArray<AuthorModel *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet * s = [db executeQuery:@"SELECT * FROM TB_BOOK_AUTHOR WHERE bookId = ?", @(bookId)];
    while ([s next]) {
        AuthorModel *author = [[AuthorModel alloc] initWithFMResultSet:s];
        [results addObject:author];
    }
    
    [s close];
    
    return results;
    
}

+ (NSArray<AuthorModel *> *)queryAllModelsWithDataBase:(FMDatabase *)db {
    
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet * s = [db executeQuery:@"SELECT * FROM TB_BOOK_AUTHOR"];
    while ([s next]) {
        AuthorModel *author = [[AuthorModel alloc] initWithFMResultSet:s];
        if (author.bookId) {
            
        }
        [results addObject:author];
    }
    
    [s close];
    
    return results;
    
}

@end
