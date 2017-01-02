//
//  TranslatorDAO.m
//  StudyPrivateCollection
//
//  Created by 彭益伟 on 26/12/2016.
//  Copyright © 2016 pengyiwei. All rights reserved.
//

#import "TranslatorDAO.h"

@implementation TranslatorDAO

+ (long long)insertModel:(TranslatorModel *)translatorModel withDataBase:(FMDatabase *)db {
                                                   
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_TRANSLATOR (bookId, name) VALUES (?, ?)", @(translatorModel.bookId), translatorModel.name];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
    
}

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_TRANSLATOR WHERE bookId = ?", @(bookId)];
    
    return success;
    
}

+ (NSArray<TranslatorModel *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db {
    
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet * s = [db executeQuery:@"SELECT * FROM TB_BOOK_TRANSLATOR WHERE bookId = ?", @(bookId)];
    while ([s next]) {
        TranslatorModel *translator = [[TranslatorModel alloc] initWithFMResultSet:s];
        [results addObject:translator];
    }
    
    [s close];
    
    return results;
    
}

@end
