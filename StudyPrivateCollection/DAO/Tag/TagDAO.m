//
//  TagDAO.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "TagDAO.h"

@implementation TagDAO

+ (long long)insertModel:(TagModel *)tagModel withDataBase:(FMDatabase *)db {
    
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_TAG (bookId, name, count) VALUES (?, ?, ?)", @(tagModel.bookId), tagModel.name, @(tagModel.count)];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
    
}

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_TAG WHERE bookId = ?", @(bookId)];
    
    return success;
    
}

+ (NSArray<TagModel *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet * s = [db executeQuery:@"SELECT * FROM TB_BOOK_TAG WHERE bookId = ?", @(bookId)];
    while ([s next]) {
        TagModel *tag = [[TagModel alloc] initWithFMResultSet:s];
        [results addObject:tag];
    }
    
    [s close];
    
    return results;
    
}

@end
